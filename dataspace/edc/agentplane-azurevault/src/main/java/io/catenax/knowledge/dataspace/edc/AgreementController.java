//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import io.catenax.knowledge.dataspace.edc.service.*;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import org.eclipse.dataspaceconnector.policy.model.Action;
import org.eclipse.dataspaceconnector.policy.model.Permission;
import org.eclipse.dataspaceconnector.policy.model.Policy;
import org.eclipse.dataspaceconnector.policy.model.PolicyType;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.types.domain.DataAddress;
import org.eclipse.dataspaceconnector.spi.types.domain.contract.offer.ContractOffer;
import org.eclipse.dataspaceconnector.spi.types.domain.edr.EndpointDataReference;

import com.auth0.jwt.JWT;
import com.auth0.jwt.interfaces.DecodedJWT;

import java.io.IOException;
import java.util.*;

import org.eclipse.dataspaceconnector.spi.types.domain.transfer.TransferType;
import org.jetbrains.annotations.Contract;

/**
 * An endpoint/service that receives information from the control plane
 */
@Consumes({MediaType.APPLICATION_JSON})
@Path("/endpoint-data-reference")
public class AgreementController {

    /**
     * EDC service references
     */
    protected final Monitor monitor;
    protected final DataManagement dataManagement;
    protected final AgentConfig config;

    /**
     * memory store for links from assets to the actual transfer addresses
     * TODO make this a distributed cache
     * TODO let this cache evict invalidate references automatically
     */
    // hosts all pending processes
    protected final Set<String> activeAssets = new HashSet<>();
    // any contract agreements indexed by asset
    protected final Map<String, ContractAgreement> agreementStore = new HashMap<>();
    // any transfer processes indexed by asset, the current process should
    // always adhere to the above agreement
    protected final Map<String, TransferProcess> processStore = new HashMap<>();
    // at the end of provisioning and endpoint reference will be set
    // that fits to the current transfer process
    protected final Map<String, EndpointDataReference> endpointStore = new HashMap<>();

    /**
     * creates an agreement controller
     *
     * @param monitor        logger
     * @param config         typed config
     * @param dataManagement data management service wrapper
     */
    public AgreementController(Monitor monitor, AgentConfig config, DataManagement dataManagement) {
        this.monitor = monitor;
        this.dataManagement = dataManagement;
        this.config = config;
    }

    /**
     * render nicely
     */
    @Override
    public String toString() {
        return super.toString() + "/endpoint-data-reference";
    }

    /**
     * this is called by the control plane when an agreement has been made
     *
     * @param dataReference contains the actual call token
     */
    @POST
    public void receiveEdcCallback(EndpointDataReference dataReference) {
        var agreementId = dataReference.getProperties().get("cid");
        monitor.debug(String.format("An endpoint data reference for agreement %s has been posted.", agreementId));
        synchronized (agreementStore) {
            for (Map.Entry<String, ContractAgreement> agreement : agreementStore.entrySet()) {
                if (agreement.getValue().getId().equals(agreementId)) {
                    synchronized (endpointStore) {
                        monitor.debug(String.format("Agreement %s belongs to asset %s.", agreementId, agreement.getKey()));
                        endpointStore.put(agreement.getKey(), dataReference);
                        return;
                    }
                }
            }
        }
        monitor.debug(String.format("Agreement %s has no active asset. Guess that came for another plane. Ignoring.", agreementId));
    }

    /**
     * accesses an active endpoint for the given asset
     *
     * @param assetId id of the agreed asset
     * @return endpoint found, null if not found or invalid
     */
    public EndpointDataReference get(String assetId) {
        synchronized (activeAssets) {
            if (!activeAssets.contains(assetId)) {
                monitor.debug(String.format("Asset %s is not active",assetId));
                return null;
            }
            synchronized (endpointStore) {
                EndpointDataReference result = endpointStore.get(assetId);
                if (result != null) {
                    String token = result.getAuthCode();
                    if (token != null) {
                        DecodedJWT jwt = JWT.decode(token);
                        if (!jwt.getExpiresAt().before(new Date(System.currentTimeMillis() + 30 * 1000))) {
                            return result;
                        }
                    }
                    endpointStore.remove(assetId);
                }
                monitor.debug(String.format("Active asset %s has timed out or was not installed.",assetId));
                synchronized (processStore) {
                    processStore.remove(assetId);
                    synchronized (agreementStore) {
                        ContractAgreement agreement = agreementStore.get(assetId);
                        if (agreement != null && agreement.getContractEndDate() <= System.currentTimeMillis()) {
                            agreementStore.remove(assetId);
                        }
                        activeAssets.remove(assetId);
                    }
                }
            }
        }
        return null;
    }

    /**
     * creates a new agreement (asynchronously)
     * and waits for the result
     *
     * @param remoteUrl ids endpoint url of the remote connector
     * @param asset     name of the asset to agree upon
     *                                   TODO make this federation aware: multiple assets, different policies
     */
    public EndpointDataReference createAgreement(String remoteUrl, String asset) throws IOException {
        synchronized (activeAssets) {
            if (activeAssets.contains(asset)) {
                throw new IOException("Cannot agree on an already active asset.");
            }
            activeAssets.add(asset);
            Collection<ContractOffer> contractOffers = dataManagement.findContractOffers(remoteUrl, asset);

            if (contractOffers.isEmpty()) {
                throw new BadRequestException(String.format("There is no contract offer in remote connector %s related to asset %s.", remoteUrl, asset));
            }

            // TODO implement a cost-based offer choice
            ContractOffer contractOffer = contractOffers.stream().findFirst().get();

            // Initiate negotiation
            var policy = Policy.Builder.newInstance()
                    .permission(Permission.Builder.newInstance()
                            .target(asset)
                            .action(Action.Builder.newInstance().type("USE").build())
                            .build())
                    .type(PolicyType.SET)
                    .build();

            var contractOfferDescription = new ContractOfferDescription(
                    contractOffer.getId(),
                    asset,
                    policy
            );
            var contractNegotiationRequest = ContractNegotiationRequest.Builder.newInstance()
                    .offerId(contractOfferDescription)
                    .connectorId("provider")
                    .connectorAddress(String.format(DataManagement.IDS_PATH, remoteUrl))
                    .protocol("ids-multipart")
                    .build();
            var negotiationId = dataManagement.initiateNegotiation(
                    contractNegotiationRequest
            );

            // Check negotiation state
            ContractNegotiation negotiation = null;

            long startTime = System.currentTimeMillis();

            try {
                while ((System.currentTimeMillis() - startTime < config.getNegotiationTimeout()) && (negotiation == null || !negotiation.getState().equals("CONFIRMED"))) {
                    Thread.sleep(config.getNegotiationPollinterval());
                    negotiation = dataManagement.getNegotiation(
                            negotiationId
                    );
                }
            } catch (InterruptedException e) {
                monitor.info(String.format("Negotiation thread for asset %s negotiation %s has been interrupted. Giving up.", asset, negotiationId));
            }

            if (negotiation == null || !negotiation.getState().equals("CONFIRMED")) {
                activeAssets.remove(asset);
                throw new InternalServerErrorException(String.format("Contract Negotiation %s for asset %s was not successful.", negotiationId, asset));
            }

            ContractAgreement agreement = dataManagement.getAgreement(negotiation.getContractAgreementId());

            if (agreement == null || !agreement.getAssetId().endsWith(asset)) {
                activeAssets.remove(asset);
                throw new InternalServerErrorException(String.format("Agreement %s does not refer to asset %s.", negotiation.getContractAgreementId(), asset));
            }

            synchronized (agreementStore) {
                agreementStore.put(asset, agreement);
            }

            DataAddress dataDestination = DataAddress.Builder.newInstance()
                    .type("HttpProxy")
                    .build();

            TransferType transferType = TransferType.Builder.
                    transferType()
                    .contentType("application/octet-stream")
                    // TODO make streaming
                    .isFinite(true)
                    .build();

            TransferRequest transferRequest = TransferRequest.Builder.newInstance()
                    .assetId(asset)
                    .contractId(agreement.getId())
                    .connectorId("provider")
                    .connectorAddress(String.format(DataManagement.IDS_PATH, remoteUrl))
                    .protocol("ids-multipart")
                    .dataDestination(dataDestination)
                    .managedResources(false)
                    .transferType(transferType)
                    .build();

            String transferId = dataManagement.initiateHttpProxyTransferProcess(transferRequest);

            // Check negotiation state
            TransferProcess process = null;

            startTime = System.currentTimeMillis();

            try {
                while ((System.currentTimeMillis() - startTime < config.getNegotiationTimeout()) && (process == null || !process.getState().equals("COMPLETED"))) {
                    Thread.sleep(config.getNegotiationPollinterval());
                    process = dataManagement.getTransfer(
                            transferId
                    );
                    synchronized (processStore) {
                        processStore.put(asset, process);
                    }
                }
            } catch (InterruptedException e) {
                monitor.info(String.format("Process thread for asset %s transfer %s has been interrupted. Giving up.", asset, transferId));
            }

            if (process == null || !process.getState().equals("COMPLETED")) {
                synchronized (processStore) {
                    processStore.remove(asset);
                }
                synchronized (agreementStore) {
                    agreementStore.remove(asset);
                }
                activeAssets.remove(asset);
                throw new InternalServerErrorException(String.format("Transfer process %s for agreement %s and asset %s could not be provisioned.", transferId, agreement.getId(), asset));
            }
        } // synchronized
        return get(asset);
    }

}

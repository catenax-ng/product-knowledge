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
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.eclipse.dataspaceconnector.spi.types.domain.transfer.TransferType;

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
    protected final Map<String, EndpointDataReference> endpointStore = new HashMap<>();
    protected final Map<String, ContractNegotiation> agreementStore = new HashMap<>();
    protected final Map<String, TransferProcess> processStore = new HashMap<>();
    protected final Map<String, String> transferStore = new HashMap<>();

    /**
     * creates an agreement controller
     * @param monitor logger
     * @param config typed config
     * @param dataManagement data management service wrapper
     */
    public AgreementController(Monitor monitor, AgentConfig config, DataManagement dataManagement) {
        this.monitor = monitor;
        this.dataManagement = dataManagement;
        this.config=config;
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
     * @param dataReference contains the actual call token
     * TODO how should several data planes receive their respective endpoints?
     */
    @POST
    public void receiveEdcCallback(EndpointDataReference dataReference) {
        var agreementId = dataReference.getProperties().get("cid");
        synchronized (endpointStore) {
            endpointStore.put(agreementId, dataReference);
        }
        monitor.debug(String.format("An endpoint data reference for agreement %s has been posted.", agreementId));
    }

    /**
     * accesses the endpoint for the given asset and validate any
     * endpoint address
     * @param assetId id of the agreed asset
     * @return endpoint found, null if not found or invalid
     */
    public EndpointDataReference get(String assetId) {
        synchronized(agreementStore) {
            ContractNegotiation negotation = agreementStore.get(assetId);
            if (negotation == null) {
                return null;
            }
            String agreementId = negotation.getContractAgreementId();
            if(agreementId==null) {
                return null;
            }
            synchronized (endpointStore) {
                EndpointDataReference result = endpointStore.get(agreementId);
                if (result != null) {
                    String token = result.getAuthCode();
                    if (token != null) {
                        DecodedJWT jwt = JWT.decode(token);
                        if (!jwt.getExpiresAt().before(new Date(System.currentTimeMillis() + 30 * 1000))) {
                            return result;
                        }
                    }
                    endpointStore.remove(agreementId);
                }
            }
            agreementStore.remove(assetId);
            // TODO need to deprovision transfer
            transferStore.remove(assetId);
            processStore.remove(assetId);
        }
        return null;
    }

    /**
     * creates a new agreement (asynchronously)
     * and waits for the result
     * @param remoteUrl ids endpoint url of the remote connector
     * @param asset name of the asset to agree upon
     * TODO make this federation aware: multiple assets, different policies
     */
    public EndpointDataReference createAgreement(String remoteUrl, String asset) throws IOException {
        Collection<ContractOffer> contractOffers = dataManagement.findContractOffers(remoteUrl,asset);

        if (contractOffers.isEmpty()) {
            throw new BadRequestException(String.format("There is no contract offer in remote connector %s related to asset %s.",remoteUrl,asset));
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
                .connectorAddress(String.format(DataManagement.IDS_PATH,remoteUrl))
                .protocol("ids-multipart")
                .build();
        var negotiationId = dataManagement.initiateNegotiation(
                contractNegotiationRequest
        );

        // Check negotiation state
        ContractNegotiation negotiation = null;

        long startTime=System.currentTimeMillis();

        try {
            while ((System.currentTimeMillis()-startTime<config.getNegotiationTimeout()) && (negotiation == null || !negotiation.getState().equals("CONFIRMED") )) {
                Thread.sleep(config.getNegotiationPollinterval());
                negotiation = dataManagement.getNegotiation(
                    negotiationId
                );
                synchronized(agreementStore) {
                    agreementStore.put(asset,negotiation);
                }
            }
        } catch(InterruptedException e ) {
            monitor.info(String.format("Negotiation thread for asset %s negotiation %s has been interrupted. Giving up.",asset,negotiationId));
        }

        if(negotiation == null || !negotiation.getState().equals("CONFIRMED")) {
            synchronized (agreementStore) {
                agreementStore.remove(asset);
            }
        } else {
            DataAddress dataDestination = DataAddress.Builder.newInstance()
                    .type(AgentSinkFactory.AGENT_TYPE_CLIENT)
                    .build();

            TransferType transferType = TransferType.Builder.
                    transferType()
                    .contentType("application/octet-stream")
                    // TODO make streaming
                    .isFinite(true)
                    .build();

            TransferRequest transferRequest = TransferRequest.Builder.newInstance()
                    .assetId(asset)
                    .contractId(negotiation.getContractAgreementId())
                    .connectorId("provider")
                    .connectorAddress(String.format(DataManagement.IDS_PATH, remoteUrl))
                    .protocol("ids-multipart")
                    .dataDestination(dataDestination)
                    .managedResources(false)
                    .transferType(transferType)
                    .build();

            String transferId = dataManagement.initiateHttpProxyTransferProcess(transferRequest);
            synchronized (transferStore) {
                transferStore.put(asset, transferId);
            }

            // Check negotiation state
            TransferProcess process = null;

            startTime=System.currentTimeMillis();

            try {
                while ((System.currentTimeMillis()-startTime<config.getNegotiationTimeout()) && (process == null || !process.getState().equals("COMPLETED") )) {
                    Thread.sleep(config.getNegotiationPollinterval());
                    process = dataManagement.getTransfer(
                            transferId
                    );
                    synchronized(processStore) {
                        processStore.put(asset,process);
                    }
                }
            } catch(InterruptedException e ) {
                monitor.info(String.format("Process thread for asset %s transfer %s has been interrupted. Giving up.",asset,transferId));
            }

            if(process == null || !process.getState().equals("COMPLETED")) {
                synchronized (processStore) {
                    processStore.remove(asset);
                }
                synchronized (transferStore) {
                    transferStore.remove(asset);
                }
                synchronized (agreementStore) {
                    agreementStore.remove(asset);
                }
            }
        }
        return get(asset);
    }

}

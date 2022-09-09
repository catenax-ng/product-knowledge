//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.catenax.knowledge.dataspace.edc.AgentConfig;
import jakarta.ws.rs.InternalServerErrorException;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.types.TypeManager;
import org.eclipse.dataspaceconnector.spi.types.domain.catalog.Catalog;
import org.eclipse.dataspaceconnector.spi.types.domain.contract.offer.ContractOffer;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Collection;
import java.util.stream.Collectors;

import static java.lang.String.format;

/**
 * DataManagement
 * is a service wrapper around the management endpoint
 * of the EDC control plane
 */
public class DataManagement {
    /**
     * some constants when interacting with control plane
     */
    public static final String IDS_PATH="%s/api/v1/ids/data";
    public static final String CATALOG_CALL = "%s/catalog?providerUrl="+IDS_PATH;
    public static final String URL_ENCODING = "UTF-8";
    public static final String NEGOTIATION_INITIATE_CALL = "%s/contractnegotiations";
    public static final String NEGOTIATION_CHECK_CALL = "%s/contractnegotiations/%s";
    public static final String TRANSFER_INITIATE_CALL = "%s/transferprocess";
    public static final String TRANSFER_CHECK_CALL = "%s/transferprocess/%s";

    /**
     * references to EDC services
     */
    private final Monitor monitor;
    private final ObjectMapper objectMapper;
    private final OkHttpClient httpClient;
    private final AgentConfig config;

    /**
     * creates a service wrapper
     * @param monitor logger
     * @param typeManager serialization
     * @param httpClient remoting
     * @param config typed config
     */
    public DataManagement(Monitor monitor, TypeManager typeManager, OkHttpClient httpClient, AgentConfig config) {
        this.monitor = monitor;
        this.objectMapper = typeManager.getMapper();
        this.httpClient = httpClient;
        this.config=config;
    }

    /**
     * Search for a dedicated asset
     * TODO imperformant
     * TODO replace by accessing the federated data catalogue
     * @param remoteControlPlaneIdsUrl url of the remote control plane ids endpoint
     * @param assetId (connector-unique) identifier of the asset
     * @return a collection of contract options to access the given asset
     * @throws IOException in case that the remote call did not succeed
     */
    public Collection<ContractOffer> findContractOffers(String remoteControlPlaneIdsUrl, String assetId) throws IOException {
        Catalog catalog = getCatalog(remoteControlPlaneIdsUrl);
        return catalog.getContractOffers().stream()
                .filter(it -> it.getAsset().getId().equals(assetId))
                .collect(Collectors.toList());
    }

    /**
     * Access the catalogue
     * @param remoteControlPlaneIdsUrl url of the remote control plane ids endpoint
     * @return catalog object
     * @throws IOException
     */
    public Catalog getCatalog(String remoteControlPlaneIdsUrl) throws IOException {
        var url = String.format(CATALOG_CALL,config.getControlPlaneManagementUrl() , URLEncoder.encode(remoteControlPlaneIdsUrl,URL_ENCODING));
        var request = new Request.Builder().url(url);
        config.getControlPlaneManagementHeaders().forEach(request::addHeader);

        try (var response = httpClient.newCall(request.build()).execute()) {
            var body = response.body();

            if (!response.isSuccessful() || body == null) {
                throw new InternalServerErrorException(format("Control plane responded with: %s %s", response.code(), body != null ? body.string() : ""));
            }

            return objectMapper.readValue(body.string(), Catalog.class);
        } catch (Exception e) {
            monitor.severe(format("Error in calling the control plane at %s", url), e);
            throw e;
        }
    }

    /**
     * initiates negotation
     * @param negotiationRequest
     * @return negotiation id
     * @throws IOException
     */
    public String initiateNegotiation(ContractNegotiationRequest negotiationRequest) throws IOException {
        var url = String.format(NEGOTIATION_INITIATE_CALL,config.getControlPlaneManagementUrl());
        var requestBody = RequestBody.create(
                objectMapper.writeValueAsString(negotiationRequest),
                MediaType.parse(jakarta.ws.rs.core.MediaType.APPLICATION_JSON)
        );

        var request = new Request.Builder()
                .url(url)
                .post(requestBody);
        config.getControlPlaneManagementHeaders().forEach(request::addHeader);

        try (var response = httpClient.newCall(request.build()).execute()) {
            var body = response.body();

            if (!response.isSuccessful() || body == null) {
                throw new InternalServerErrorException(format("Control plane responded with: %s %s", response.code(), body != null ? body.string() : ""));
            }

            var negotiationId = objectMapper.readTree(body.string()).get("id").textValue();

            monitor.info("Started negotiation with ID: " + negotiationId);

            return negotiationId;
        } catch (Exception e) {
            monitor.severe(format("Error in calling the control plane at %s", url), e);
            throw e;
        }
    }

    /**
     * return state of contract negotiation
     * @param negotiationId
     * @return
     * @throws IOException
     */
    public ContractNegotiation getNegotiation(String negotiationId) throws IOException {
        var url = String.format(NEGOTIATION_CHECK_CALL,config.getControlPlaneManagementUrl(),negotiationId);
        var request = new Request.Builder()
                .url(url);
        config.getControlPlaneManagementHeaders().forEach(request::addHeader);

        try (var response = httpClient.newCall(request.build()).execute()) {
            var body = response.body();

            if (!response.isSuccessful() || body == null) {
                throw new InternalServerErrorException(format("Control plane responded with: %s %s", response.code(), body != null ? body.string() : ""));
            }

            var negotiation = objectMapper.readValue(body.string(), ContractNegotiation.class);
            monitor.info(format("Negotiation %s is in state '%s' (agreementId: %s)", negotiationId, negotiation.getState(), negotiation.getContractAgreementId()));

            return negotiation;
        } catch (Exception e) {
            monitor.severe(format("Error in calling the Control plane at %s", url), e);
            throw e;
        }
    }

    /**
     * Initiates a transfer
     * @param transferRequest request
     * @return transfer id
     * @throws IOException
     */
    public String initiateHttpProxyTransferProcess(TransferRequest transferRequest) throws IOException {
        var url = String.format(TRANSFER_INITIATE_CALL,config.getControlPlaneManagementUrl());

        var requestBody = RequestBody.create(
                objectMapper.writeValueAsString(transferRequest),
                MediaType.parse(jakarta.ws.rs.core.MediaType.APPLICATION_JSON)
        );

        var request = new Request.Builder()
                .url(url)
                .post(requestBody);
        config.getControlPlaneManagementHeaders().forEach(request::addHeader);

        try (var response = httpClient.newCall(request.build()).execute()) {
            var body = response.body();

            if (!response.isSuccessful() || body == null) {
                throw new InternalServerErrorException(format("Control plane responded with: %s %s", response.code(), body != null ? body.string() : ""));
            }

            // For debugging purposes:
            // var transferProcessId = TransferId.Builder.newInstance().id(body.string()).build();
            var transferProcessId = objectMapper.readTree(body.string()).get("id").textValue();

            monitor.info(format("Transfer process (%s) initiated", transferProcessId));

            return transferProcessId;
        } catch (Exception e) {
            monitor.severe(format("Error in calling the control plane at %s", url), e);
            throw e;
        }
    }

    /**
     * return state of transfer process
     * @param transferProcessId
     * @return
     * @throws IOException
     */
    public TransferProcess getTransfer(String transferProcessId) throws IOException {
        var url = String.format(TRANSFER_CHECK_CALL,config.getControlPlaneManagementUrl(),transferProcessId);
        var request = new Request.Builder()
                .url(url);
        config.getControlPlaneManagementHeaders().forEach(request::addHeader);

        try (var response = httpClient.newCall(request.build()).execute()) {
            var body = response.body();

            if (!response.isSuccessful() || body == null) {
                throw new InternalServerErrorException(format("Control plane responded with: %s %s", response.code(), body != null ? body.string() : ""));
            }

            var process = objectMapper.readValue(body.string(), TransferProcess.class);
            monitor.info(format("Transfer %s is in state '%s' (dataDestination: %s)", transferProcessId, process.getState(), process.getDataDestination()));

            return process;
        } catch (Exception e) {
            monitor.severe(format("Error in calling the Control plane at %s", url), e);
            throw e;
        }
    }

}
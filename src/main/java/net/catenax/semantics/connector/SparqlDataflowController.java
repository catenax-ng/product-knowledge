/*
 * Copyright (c) 2021 T-Systems International Gmbh (Catena-X Consortium)
 *
 * See the AUTHORS file(s) distributed with this work for additional
 * information regarding authorship.
 *
 * See the LICENSE file(s) distributed with this work for
 * additional information regarding license terms.
 */
package net.catenax.semantics.connector;

import jakarta.ws.rs.core.HttpHeaders;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import org.eclipse.dataspaceconnector.dataloading.AssetLoader;
import org.eclipse.dataspaceconnector.spi.asset.AssetIndex;
import org.eclipse.dataspaceconnector.spi.asset.DataAddressResolver;
import org.eclipse.dataspaceconnector.spi.iam.IdentityService;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.transfer.flow.DataFlowController;
import org.eclipse.dataspaceconnector.spi.transfer.flow.DataFlowInitiateResponse;
import org.eclipse.dataspaceconnector.spi.transfer.response.ResponseStatus;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.DataAddress;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.DataRequest;
import org.jetbrains.annotations.NotNull;

import java.io.IOException;

/**
 * Implements (hacks) a synchronous data flow that
 * delegates against an (internal plane) SPARQL implementation endpoint
 */
public class SparqlDataflowController implements DataFlowController {
    public final static String DESTINATION_PROPERTY_QUERY="net.catenax.semantics.connector.sparql.query";
    public final static String DESTINATION_PROPERTY_RESPONSE="net.catenax.semantics.connector.sparql.response";

    protected final Monitor monitor;
    protected final IdentityService identityService;
    protected final String connectorId;
    protected final DataAddressResolver assetIndex;


    public SparqlDataflowController(Monitor monitor, IdentityService identityService, String connectorId, DataAddressResolver assetIndex) {
        this.monitor = monitor;
        this.identityService=identityService;
        this.connectorId=connectorId;
        this.assetIndex=assetIndex;
    }

    @Override
    public boolean canHandle(DataRequest dataRequest) {
        return dataRequest.getDataDestination().getType().equalsIgnoreCase("sparql");
    }

    @Override
    public @NotNull DataFlowInitiateResponse initiateFlow(DataRequest dataRequest) {
        var assetName = dataRequest.getAssetId();
        var address=assetIndex.resolveForAsset(assetName);
        var assetEndpoint = address.getProperty(TripleDataPlaneExtension.ASSET_ENDPOINT_PROPERTY).toString();

        monitor.debug(String.format("Initiating Synchronous SparQL Query delegation to backend %s for request %s", assetEndpoint, dataRequest));

        String query = dataRequest.getDataDestination().getProperty(DESTINATION_PROPERTY_QUERY);
        String correlationId = dataRequest.getDataDestination().getProperty(SparqlApiController.CORRELATION_HEADER);
        String accepts = dataRequest.getDataDestination().getProperty(HttpHeaders.ACCEPT);
        if(accepts==null) {
            accepts="application/sparql-result-xml";
        }
        // TODO different agreement delegation strategies
        String agreementToken = identityService.obtainClientCredentials(connectorId).getToken();
        //properties.get(SparqlApiController.AGREEMENT_HEADER,agreementToken);

        String issuerConnectors=connectorId+","+dataRequest.getDataDestination().getProperty(SparqlApiController.CONNECTOR_HEADER);

        OkHttpClient httpClient = new OkHttpClient();
        // form parameters
        okhttp3.MediaType mediaType = okhttp3.MediaType.parse("application/sparql-query");
        RequestBody formBody = RequestBody.create(mediaType, query);

        Request request = new Request.Builder()
                .url(assetEndpoint)
                .addHeader(SparqlApiController.CORRELATION_HEADER,correlationId)
                .addHeader(SparqlApiController.CONNECTOR_HEADER,issuerConnectors)
                .addHeader(SparqlApiController.AGREEMENT_HEADER,agreementToken)
                .addHeader(HttpHeaders.ACCEPT,accepts)
                .post(formBody)
                .build();

        try (okhttp3.Response response = httpClient.newCall(request).execute()) {

            if (!response.isSuccessful())
                return new DataFlowInitiateResponse(ResponseStatus.FATAL_ERROR,String.format("Got an unsuccessful response status %d",response.code()));

            // Get response body
            String responseBody = response.body().string();

            var updatedDestination= DataAddress.Builder.newInstance()
                    .type("sparql")
                    .property(SparqlApiController.CORRELATION_HEADER,correlationId)
                    .property(DESTINATION_PROPERTY_RESPONSE,responseBody).build();
            dataRequest.updateDestination(updatedDestination);

            return DataFlowInitiateResponse.OK;
        } catch (Exception e) {
            return new DataFlowInitiateResponse(ResponseStatus.FATAL_ERROR,e.getMessage());
        }
    }
}



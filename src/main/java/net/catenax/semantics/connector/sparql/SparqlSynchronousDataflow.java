/*
 * Copyright (c) 2021-2022 T-Systems International Gmbh (Catena-X Consortium)
 *
 * See the AUTHORS file(s) distributed with this work for additional
 * information regarding authorship.
 *
 * See the LICENSE file(s) distributed with this work for
 * additional information regarding license terms.
 */
package net.catenax.semantics.connector.sparql;

import jakarta.ws.rs.core.HttpHeaders;
import net.catenax.semantics.connector.TripleDataPlaneExtension;
import net.catenax.semantics.triples.SparqlHelper;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
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
 * Implements a (synchronous) data flow that
 * delegates against an (internal plane) SPARQL implementation endpoint
 * already in the initiation phase
 */
public class SparqlSynchronousDataflow implements DataFlowController {

    /**
     *  some constants where to hide request specific information in the request
     */
    public final static String SPARQL_DATAFLOW_TYPE="sparql";
    public final static String DESTINATION_PROPERTY_QUERY="net.catenax.semantics.connector.sparql.query";
    public final static String DESTINATION_PROPERTY_RESPONSE="net.catenax.semantics.connector.sparql.response";
    public final static String SPARQL_ENDPOINT = System.getProperty("sparqlEndpoint", "query");

    /**
     * we got an http client to call out
     */
    protected final SparqlHelper internalService;

    /**
     * links to the connector services
     */
    protected final Monitor monitor;
    protected final IdentityService identityService;
    protected final String connectorId;
    protected final DataAddressResolver resolver;

    /**
     * Creates a new SparQL Dataflow controller
     * @param monitor link to the logging facility
     * @param identityService we need our own agreement tokens
     * @param connectorId we need our own identity
     * @param resolver a service that helps us to find our endpoint published as an asset
     */
    public SparqlSynchronousDataflow(Monitor monitor, IdentityService identityService, String connectorId, DataAddressResolver resolver, SparqlHelper internalService) {
        this.monitor = monitor;
        this.identityService=identityService;
        this.connectorId=connectorId;
        this.resolver=resolver;
        this.internalService=internalService;
    }

    /**
     * The name of the dataflow
     * @param dataRequest
     * @return
     */
    @Override
    public boolean canHandle(DataRequest dataRequest) {
        return dataRequest.getDataDestination().getType().equalsIgnoreCase(SPARQL_DATAFLOW_TYPE);
    }

    /**
     * Initiate (and serve).
     * Note that all policy-related things should have been already checked
     * in the IDS incoming layer. Only a mapping to a suitable authentication/authorization
     * target in the internal plane would be left to be done here.
     * Otherwise all routed-through information should be already
     * precomputed and handed out to the internal module for 1-1 propagation.
     * If that information (like token or connector context) would be dependent on the service
     * federated than we would need to put that info into separate fields somehow
     * such that FUSEKI can grab the right one depending on the external query created (see
     * the FUSEKI patch and the HttpModifier applied there.
     * At the moment, FUSEKI will propagate all "catenax" headers without case distinction.
     * @param dataRequest an artifact request as been somehow put into the IDS plane
     * @return an initiate response indicating success or failure
     */
    @Override
    public @NotNull DataFlowInitiateResponse initiateFlow(DataRequest dataRequest) {
        var assetName = dataRequest.getAssetId();
        var address= resolver.resolveForAsset(assetName);
        var assetEndpoint = address.getProperty(TripleDataPlaneExtension.ASSET_ENDPOINT_PROPERTY).toString()+SPARQL_ENDPOINT;

        monitor.debug(String.format("Initiating Synchronous SparQL Query delegation to backend %s for request %s", assetEndpoint, dataRequest));

        String query = dataRequest.getDataDestination().getProperty(DESTINATION_PROPERTY_QUERY);
        String correlationId = dataRequest.getDataDestination().getProperty(TripleDataPlaneExtension.CORRELATION_HEADER);
        String accepts = dataRequest.getDataDestination().getProperty(HttpHeaders.ACCEPT);

        // TODO implement different agreement delegation strategies
        String agreementToken = identityService.obtainClientCredentials(connectorId).getToken();
        //properties.get(SparqlApiController.AGREEMENT_HEADER,agreementToken);

        String issuerConnectors=dataRequest.getDataDestination().getProperty(TripleDataPlaneExtension.CONNECTOR_HEADER);
        String extendedIssuerConnectors = issuerConnectors;
        if(!extendedIssuerConnectors.startsWith(connectorId)) {
            extendedIssuerConnectors=connectorId+";"+extendedIssuerConnectors;
        }

        try {
            String response = internalService.performQuery(assetEndpoint,query,correlationId,extendedIssuerConnectors,agreementToken,accepts);
            var updatedDestination= DataAddress.Builder.newInstance()
                    .type("sparql")
                    .property(TripleDataPlaneExtension.CORRELATION_HEADER,correlationId)
                    .property(DESTINATION_PROPERTY_RESPONSE,response).build();

            dataRequest.updateDestination(updatedDestination);

            return DataFlowInitiateResponse.OK;
        } catch (IOException e) {
            return new DataFlowInitiateResponse(ResponseStatus.FATAL_ERROR,
                    String.format("Synchronous dataflow initiation failed. Got an exception %s",e.getMessage()));
        }
    }
}



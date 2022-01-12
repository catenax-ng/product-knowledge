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
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import okhttp3.MultipartBody;
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

import java.util.List;
import java.util.Map;

/**
 * Implements an (asynchronous, ever-running) data flow that
 * forwards turtle events against an API plane.
 */
public class TurtleAsynchronousDataflow implements DataFlowController {

    /**
     *  some constants where to hide request specific information in the request
     */
    public final static String TURTLE_DATAFLOW_TYPE="turtle";
    protected final Map<String, List<DataRequest>> dataflows;
    
    /**
     * we got an http client to call out
     */
    protected final OkHttpClient httpClient;

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
    public TurtleAsynchronousDataflow(Monitor monitor, IdentityService identityService, String connectorId, DataAddressResolver resolver) {
        this.monitor = monitor;
        this.identityService=identityService;
        this.connectorId=connectorId;
        this.resolver=resolver;
        this.dataflows=new java.util.HashMap<>();
        //  TODO do we need to manipulate the call timeout?
        this.httpClient= new OkHttpClient.Builder().build();
    }

    /**
     * The name of the dataflow
     * @param dataRequest
     * @return
     */
    @Override
    public boolean canHandle(DataRequest dataRequest) {
        return dataRequest.getDataDestination().getType().equalsIgnoreCase(TURTLE_DATAFLOW_TYPE);
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
        monitor.debug(String.format("Initiating Asynchronous Turtle Event delegation for backend %s for request %s", assetName, dataRequest));
        List<DataRequest> pending = dataflows.get(assetName);
        if(pending==null) {
            pending=new java.util.ArrayList<DataRequest>();
            dataflows.put(assetName,pending);
        }
        pending.add(dataRequest);
        return DataFlowInitiateResponse.OK;
    }

    /**
     * delegates a change event in a given asset to the registered subscribers
     * @param asset
     * @param turtle
     * @param issuerConnectors
     * @param correlationId
     */
    public void triggerEvent(String asset, java.io.File turtle, String issuerConnectors, String correlationId) {

        // logging
        monitor.debug(String.format("Performing a trigger event %s to asset %s from calling connector(s) %s",correlationId,asset,issuerConnectors));

        String extendedIssuerConnectors=issuerConnectors;
        if(!extendedIssuerConnectors.startsWith(connectorId)) {
            extendedIssuerConnectors = connectorId + ";" + extendedIssuerConnectors;
        }

        List<DataRequest> flows=dataflows.get(asset);

        if(flows!=null && !flows.isEmpty()) {
            for(DataRequest subscriber : flows) {

                // logging
                monitor.debug(String.format("Found subscriber %s for trigger event %s",subscriber.getDataDestination(),correlationId));

                RequestBody formBody = new MultipartBody.Builder().setType(MultipartBody.FORM)
                        .addFormDataPart("file", turtle.getName(),
                                RequestBody.create(TurtleAsynchronousApi.TURTLE, turtle))
                        .addFormDataPart("graph",subscriber.getDataDestination().getProperty(TripleDataPlaneExtension.GRAPH_PROPERTY))
                        .build();

                Request request = new Request.Builder()
                        .url(subscriber.getDataDestination().getProperty(TripleDataPlaneExtension.LOCATION_PROPERTY))
                        .addHeader(TripleDataPlaneExtension.CORRELATION_HEADER,correlationId)
                        .addHeader(TripleDataPlaneExtension.CONNECTOR_HEADER,extendedIssuerConnectors)
                        .addHeader(TripleDataPlaneExtension.AGREEMENT_HEADER,subscriber.getDataDestination().getProperty(TripleDataPlaneExtension.AGREEMENT_PROPERTY))
                        .post(formBody)
                        .build();

                try (okhttp3.Response response = httpClient.newCall(request).execute()) {

                    if(!response.isSuccessful())
                        monitor.warning("Event triggering was not successful.");
                    else
                        monitor.debug("Event triggering was successful");
                } catch (Exception e) {
                    monitor.warning("Event triggering was not successful.",e);
                }
            }
        }
    }

    /**
     * TODO terminate all pending requests
     */
    public void shutdown() {
       dataflows.clear();
    }
}



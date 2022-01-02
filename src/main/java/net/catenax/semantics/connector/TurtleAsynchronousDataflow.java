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
import org.eclipse.dataspaceconnector.spi.asset.DataAddressResolver;
import org.eclipse.dataspaceconnector.spi.iam.IdentityService;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.transfer.flow.DataFlowController;
import org.eclipse.dataspaceconnector.spi.transfer.flow.DataFlowInitiateResponse;
import org.eclipse.dataspaceconnector.spi.transfer.response.ResponseStatus;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.DataAddress;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.DataRequest;
import org.jetbrains.annotations.NotNull;
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
    protected final Map<String,DataRequest> dataflows;
    
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
        this.dataflows=new java.util.HashMap<String,DataRequest>();
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
        dataflows.put(assetName,dataRequest);
        return DataFlowInitiateResponse.OK;
    }
    
}



/*
 * Copyright (c) 2021 T-Systems International GmbH (Catena-X Consortium)
 *
 * See the AUTHORS file(s) distributed with this work for additional
 * information regarding authorship.
 *
 * See the LICENSE file(s) distributed with this work for
 * additional information regarding license terms.
 */
package net.catenax.semantics.connector;

import de.fraunhofer.iais.eis.DynamicAttributeTokenBuilder;
import de.fraunhofer.iais.eis.TokenFormat;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.HttpHeaders;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import de.fraunhofer.iais.eis.ArtifactRequestMessage;
import de.fraunhofer.iais.eis.ArtifactRequestMessageBuilder;

import org.eclipse.dataspaceconnector.ids.api.transfer.ArtifactRequestController;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.ids.spi.daps.DapsService;
import org.eclipse.dataspaceconnector.ids.spi.policy.IdsPolicyService;
import org.eclipse.dataspaceconnector.spi.asset.AssetIndex;
import org.eclipse.dataspaceconnector.spi.policy.PolicyRegistry;
import org.eclipse.dataspaceconnector.spi.security.Vault;
import org.eclipse.dataspaceconnector.spi.transfer.TransferProcessListener;
import org.eclipse.dataspaceconnector.spi.transfer.TransferProcessManager;
import org.eclipse.dataspaceconnector.spi.transfer.TransferProcessObservable;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.TransferProcess;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.TransferProcessStates;

import java.net.URI;
import java.util.Map;
import java.util.UUID;

/**
 * SPARQL over HTTP synchronous API data plane controller
 * which interprets some connector-related headers
 * and then simply delegates to the internal IDS backplane
 * by "simulating" an ordinary artifact request
 * and then waiting/listening to the transfer process
 * (who is "magically" injected the response)
 * the connector-related headers are
 * - catenax-connector-context: should be a list of connector-urn#asset with which
 *   to perform a union of the target data
 * - catenax-security-token: a (federated) token containing all relevant agreement claims and signed
 *   by all relevant connectors
 * - catenax-correlation-id (optional): a unique request id which serves to do a lineage analysis
 *   in case of problems.
 */
@Path("/sparql")
public class SparqlSynchronousApi implements TransferProcessListener {


    /**
     * some dummy process used for state handling
     */
    protected static final TransferProcess DUMMY_PROCESS=TransferProcess.Builder.newInstance().id("DUMMY_PROCESS").build();

    /**
     * logging service
     */
    protected final Monitor monitor;

    /**
     * the connector plane is entered with the "ordinary"
     * artifect request controller
     */

    protected final ArtifactRequestController idsController;

    /**
     * keep some state about the concurrently ongoing synchronous requests
     */
    protected final Map<String,TransferProcess> openRequests=new java.util.HashMap<>();

    /**
     * create a new SPARQL API controller (and an embedded artifact request controller)
     * and register it as a listener to the transfer process manager
     * @param dapsService link to the daps service for token verification
     * @param assetIndex link to the asset registry for agreement infos
     * @param processManager link to the transfer process manager who does the actual request handling
     * @param policyService link to the policy service for validation of access
     * @param policyRegistry link to the policy registry for descriptions
     * @param vault link to the secret vault in case that long-term credentials need be safely hidden
     * @param monitor link to the logging facility
     */
    public SparqlSynchronousApi(DapsService dapsService,
                                AssetIndex assetIndex,
                                TransferProcessManager processManager,
                                IdsPolicyService policyService,
                                PolicyRegistry policyRegistry,
                                Vault vault,
                                Monitor monitor) {
        this.monitor = monitor;
        this.idsController=new ArtifactRequestController(
                dapsService,
                assetIndex,
                processManager,
                policyService,
                policyRegistry,
                vault,
                monitor);
        monitor.info(String.format("Registering %s as listener for transfer process manager %s for synchronous requests.",this,processManager));
        ((TransferProcessObservable) processManager).registerListener(this);
    }

    /**
     * A get call is done when the query is not too complicated.
     * This is the standard endpoint for the FUSEKI federated engine calling out.
     * FUSEKI needs XML results, not JSON results. So in abundance of further information
     * we would return XML instead of JSON.
     * @param asset The asset usually points to a database (and a graph therein that is associated to an access policy)
     * @param query A valid SparQL query encoded as a url parameter
     * @param httpHeaders the headers of the request
     * @return the response object contains the result binding (in case of success) or an encoded string with error details (in case of failure).
     */
    @GET
    @Path("{asset: [a-zA-Z0-9_/\\-]+}")
    @Produces({ MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON })
    public Response get(
            @PathParam("asset") String asset,
            @QueryParam("query") String query,
            @Context HttpHeaders httpHeaders
    ) {
        return process(asset, query, httpHeaders);
    }

    /**
     * A post call is done when the query becomes too large.
     * The expected body is of media type "application/sparql-query".
     * The result will be XML (default) or JSON.
     * @param asset The asset usually points to a database (and a graph therein that is associated to an access policy)
     * @param query A valid SparQL query encoded as a url parameter
     * @param httpHeaders the headers of the request
     * @return the response object contains the result binding (in case of success) or an encoded string with error details (in case of failure).
     */
    @POST
    @Path("{asset: [a-zA-Z0-9_/\\-]+}")
    @Consumes({"application/sparql-query"})
    @Produces({ MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON })
    public Response post(
            @PathParam("asset") String asset,
            String query,
            @Context HttpHeaders httpHeaders
    ) {
        return process(asset, query, httpHeaders);
    }

    /**
     * Implements the actual
     * request initiation and synchronisation
     * (no matter the HTTP method used)
     * @param asset The asset usually points to a database (and a graph therein that is associated to an access policy)
     * @param query A valid SparQL query encoded as a url parameter
     * @param headers the headers of the request
     * @return the response object contains the result binding (in case of success) or an encoded string with error details (in case of failure).
     */
    protected Response process(String asset, String query, HttpHeaders headers) {

        // first do some header lookups
        String agreementToken=headers.getHeaderString(TripleDataPlaneExtension.AGREEMENT_HEADER);
        String issuerConnectors=headers.getHeaderString(TripleDataPlaneExtension.CONNECTOR_HEADER);
        String correlationId=headers.getHeaderString(TripleDataPlaneExtension.CORRELATION_HEADER);
        String accepts=headers.getHeaderString(HttpHeaders.ACCEPT);
        if(accepts!=null && accepts.equals(MediaType.APPLICATION_JSON)) {
            accepts=MediaType.APPLICATION_JSON;
        } else if (accepts==null || accepts.contains(MediaType.MEDIA_TYPE_WILDCARD) || accepts.contains(MediaType.APPLICATION_XML)) {
            accepts=MediaType.APPLICATION_XML;
        } else {
            return fail(accepts,Response.Status.UNSUPPORTED_MEDIA_TYPE,"Only %s and %s are allowed as media types",MediaType.APPLICATION_XML,MediaType.APPLICATION_JSON);
        }
        if(correlationId==null) {
            correlationId= UUID.randomUUID().toString();
        }

        // logging
        monitor.debug(String.format("Received API query %s accepting %s to asset %s from calling connector(s) %s",correlationId,accepts,asset,issuerConnectors));

        // next we prepare the IDS artifact request
        ArtifactRequestMessageBuilder requestBuilder=new ArtifactRequestMessageBuilder();
        requestBuilder._securityToken_( new DynamicAttributeTokenBuilder()._tokenFormat_(TokenFormat.JWT)._tokenValue_(agreementToken).build());
        try {
            requestBuilder._requestedArtifact_(new URI(asset));

            String[] connectors=issuerConnectors.split(TripleDataPlaneExtension.CONNECTOR_CHAIN_DELIMITER);

            //
            // TODO extended policy check: analyse the SparQL query for
            // graphs, lookup sub-assets and policy and check
            // whether they are allowed to be unioned ...
            // Policy checking for services+graphs will need to be delegated
            // so it could be that we need to send the unioned graphs/services
            // as well
            //

            requestBuilder._issuerConnector_(new URI(issuerConnectors));
            requestBuilder._correlationMessage_(new URI(correlationId));
            ArtifactRequestMessage request = requestBuilder.build();
            Map<String, Object> destinationMap = new java.util.HashMap<>();
            request.setProperty("dataspaceconnector-data-destination",destinationMap);

            Map<String, String> properties = new java.util.HashMap<>();
            properties.put(TripleDataPlaneExtension.CORRELATION_HEADER,correlationId);
            properties.put(TripleDataPlaneExtension.AGREEMENT_HEADER,agreementToken);
            properties.put(TripleDataPlaneExtension.CONNECTOR_HEADER,issuerConnectors);
            properties.put(HttpHeaders.ACCEPT,accepts);
            properties.put(SparqlSynchronousDataflow.DESTINATION_PROPERTY_QUERY,query);
            destinationMap.put("properties",properties);

            destinationMap.put("type",SparqlSynchronousDataflow.SPARQL_DATAFLOW_TYPE);
            destinationMap.put("keyName",TripleDataPlaneExtension.CORRELATION_HEADER);

            // put dummy entry into the request table
            synchronized(openRequests) {
                if (openRequests.containsKey(correlationId)) {
                    return fail(accepts,Response.Status.CONFLICT,"A request with correlation id %s is already in progress. Maybe an illegal recursive call chain has been constructed.",
                            correlationId);
                } else {
                    openRequests.put(correlationId, DUMMY_PROCESS);
                }
            }

            var idsResponse=idsController.request(request);

            if(idsResponse.getStatus()!=200) {
                return fail(accepts,Response.Status.fromStatusCode(idsResponse.getStatus()),"Artifact request %s could not be successfully registered.",correlationId);
            }

            monitor.debug(String.format("Artifact request %s was successfully registered. Now synchronizing on the transfer process.",request));

            synchronized(openRequests) {
                TransferProcess process=openRequests.get(correlationId);
                while (process==null || (process.getState()>=TransferProcessStates.UNSAVED.code() && process.getState()<TransferProcessStates.IN_PROGRESS.code())) {
                    openRequests.wait();
                    process=openRequests.get(correlationId);
                }
                openRequests.remove(correlationId);
                if(process.getState()==TransferProcessStates.ENDED.code()) {
                    return fail(accepts,Response.Status.INTERNAL_SERVER_ERROR,process.getErrorDetail());
                } else {
                    String body=process.getDataRequest().getDataDestination().getProperty(SparqlSynchronousDataflow.DESTINATION_PROPERTY_RESPONSE);
                    monitor.debug(body);
                    return Response.ok(body,
                            accepts).build();
                }
            }
        } catch(Exception e) {
            monitor.warning("An error condition occured while trying to process request "+correlationId,e);
            return fail(accepts,Response.Status.INTERNAL_SERVER_ERROR,"An error condition occured: %s",e.getMessage());
        }
    }

    /**
     * create a failure response
     * @param mediaType of the response
     * @param status of the response
     * @param error in the response
     * @param args to the error
     * @return a response
     */
    protected Response fail(String mediaType, Response.Status status, String error, Object... args) {
        String detail=String.format(error,args);
        if(mediaType==MediaType.APPLICATION_XML) {
            detail=String.format("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<error>%s</error>",detail);
        } else if(mediaType==MediaType.APPLICATION_JSON) {
            detail=String.format("{\"error\":\"%s\"}",detail);
        }
        return Response.status(status.getStatusCode(),detail).build();
    }

    /**
     * is called when a new request has been created
     * @param process maybe a process unrelated to this API/controller which will be ignored
     */
    @Override
    public void created(TransferProcess process) {
        var dr = process.getDataRequest();
        if (dr != null) {
            var ds = dr.getDataDestination();
            if (ds != null) {
                String correlationId = ds.getProperty(TripleDataPlaneExtension.CORRELATION_HEADER);
                synchronized (openRequests) {
                    if (openRequests.containsKey(correlationId)) {
                        openRequests.put(correlationId, process);
                    }
                }
            }
        }
    }

    /**
     * is called when the request has been initiated (actually means that
     * the dataflow has already been performed, since we cannot guarantuee that
     * these type of processes will be correctly terminated by the EDC logic).
     * So we wakeup any pending requests here.
     * @param process maybe a process unrelated to this API/controller which will be ignored
     */
    @Override
    public void inProgress(TransferProcess process) {
        var dr = process.getDataRequest();
        if (dr != null) {
            var ds = dr.getDataDestination();
            if (ds != null) {
                String correlationId = ds.getProperty(TripleDataPlaneExtension.CORRELATION_HEADER);
                synchronized (openRequests) {
                    if (openRequests.containsKey(correlationId)) {
                        openRequests.put(correlationId, process);
                        openRequests.notifyAll();
                    }
                }
            }
        }
    }

    /**
     * is called when the request has been terminated (successfully?)
     * Most likely, our synchronous wait has already been done/cleaned up
     * but to make everything safe and sure, we wakeup any pending requests again.
     * @param process maybe a process unrelated to this API/controller or already processed which will be ignored
     */
    @Override
    public void ended(TransferProcess process) {
        var dr = process.getDataRequest();
        if (dr != null) {
            var ds = dr.getDataDestination();
            if (ds != null) {
                String correlationId = ds.getProperty(TripleDataPlaneExtension.CORRELATION_HEADER);
                synchronized (openRequests) {
                    if (openRequests.containsKey(correlationId)) {
                        openRequests.put(correlationId, process);
                        openRequests.notifyAll();
                    }
                }
            }
        }
    }

    /**
     * is called when the request has been interrupted.
     * We need to wakeup any pending requests to produce the final response.
     * @param process maybe a process unrelated to this API/controller which will be ignored
     */
    @Override
    public void error(TransferProcess process) {
        var dr = process.getDataRequest();
        if (dr != null) {
            var ds = dr.getDataDestination();
            if (ds != null) {
                String correlationId = ds.getProperty(TripleDataPlaneExtension.CORRELATION_HEADER);
                synchronized (openRequests) {
                    openRequests.put(correlationId, process);
                    openRequests.notifyAll();
                }
            }
        }
    }

}

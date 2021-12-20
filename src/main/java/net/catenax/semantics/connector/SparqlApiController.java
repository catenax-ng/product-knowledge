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
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.DataAddress;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.DataRequest;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.TransferProcess;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.TransferProcessStates;

import java.net.URI;
import java.util.Map;
import java.util.UUID;

/**
 * SPARQL over HTTP synchronous API controller
 * which simply delegates to the internal IDS backplane
 * by "simulating" an ordinary artifact request
 * who is "magically" injected the response
 */
@Path("/sparql")
public class SparqlApiController implements TransferProcessListener {

    public static final String AGREEMENT_HEADER="catenax-security-token";
    public static final String CONNECTOR_HEADER="catenax-caller-connector";
    public static final String CONNECTOR_CHAIN_DELIMITER=",";
    public static final String CORRELATION_HEADER="catenax-correlation-id";

    protected static final TransferProcess DUMMY_PROCESS=TransferProcess.Builder.newInstance().id("DUMMY_PROCESS").build();

    protected final Monitor monitor;
    protected final ArtifactRequestController idsController;
    protected final Map<String,TransferProcess> openRequests=new java.util.HashMap<>();

    public SparqlApiController(DapsService dapsService,
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
     *
     * @param compartment
     * @param payload
     * @return response
     */
    @GET
    @Path("{compartment: [a-zA-Z0-9_/\\-]+}")
    public Response get(
            @PathParam("compartment") String compartment,
            @QueryParam("query") String payload,
            @Context HttpHeaders httpheaders
    ) {
        return process(compartment, payload, httpheaders);
    }

    /**
     * a post call is done when the query becomes too large
     *
     * @param compartment
     * @param payload
     * @return response
     */
    @POST
    @Path("{compartment: [a-zA-Z0-9_/\\-]+}")
    @Consumes({"application/sparql-query"})
    @Produces({MediaType.APPLICATION_XML})
    public Response post(
            @PathParam("compartment") String compartment,
            //@FormDataParam("header") InputStream headerInputStream,
            //@FormDataParam("payload") String payload
            String payload,
            @Context HttpHeaders httpheaders
    ) {
        return process(compartment, payload, httpheaders);
    }


    /**
     * the actual processing (no matter the method)
     *
     * @param compartment
     * @param payload
     * @param headers
     * @return response
     */
    protected Response process(String compartment, String payload, HttpHeaders headers) {
        String agreementToken=headers.getHeaderString(AGREEMENT_HEADER);
        String issuerConnectors=headers.getHeaderString(CONNECTOR_HEADER);
        String correlationId=headers.getHeaderString(CORRELATION_HEADER);
        String accepts=headers.getHeaderString(HttpHeaders.ACCEPT);
        if(correlationId==null) {
            correlationId= UUID.randomUUID().toString();
        }

        monitor.debug(String.format("Received API query %s accepting %s to asset %s from calling connector(s) %s",correlationId,accepts,compartment,issuerConnectors));

        ArtifactRequestMessageBuilder requestBuilder=new ArtifactRequestMessageBuilder();
        requestBuilder._securityToken_( new DynamicAttributeTokenBuilder()._tokenFormat_(TokenFormat.JWT)._tokenValue_(agreementToken).build());
        try {
            requestBuilder._requestedArtifact_(new URI(compartment));
            String[] connectorChain=issuerConnectors.split(CONNECTOR_CHAIN_DELIMITER);
            requestBuilder._issuerConnector_(new URI(connectorChain[0]));
            requestBuilder._correlationMessage_(new URI(correlationId));
            ArtifactRequestMessage request = requestBuilder.build();
            Map<String, Object> destinationMap = new java.util.HashMap<>();
            destinationMap.put("type","sparql");
            destinationMap.put("keyName","compartment");
            request.setProperty("dataspaceconnector-data-destination",destinationMap);

            Map<String, String> properties = new java.util.HashMap<>();
            properties.put("compartment",compartment);
            properties.put(CORRELATION_HEADER,correlationId);
            properties.put(AGREEMENT_HEADER,agreementToken);
            properties.put(CONNECTOR_HEADER,issuerConnectors);
            //properties.put(HttpHeaders.ACCEPT,accepts);
            properties.put(SparqlDataflowController.DESTINATION_PROPERTY_QUERY,payload);
            destinationMap.put("properties",properties);

            synchronized(openRequests) {
                if (openRequests.containsKey(correlationId)) {
                    return Response.status(Response.Status.CONFLICT.getStatusCode(),
                            String.format("A request with correlation id %s is already in progress. Maybe an illegal recursive call chain has been constructed.",
                                    correlationId)).build();
                } else {
                    openRequests.put(correlationId, DUMMY_PROCESS);
                }
            }

            var idsResponse=idsController.request(request);

            if(idsResponse.getStatus()!=200) {
                return Response.status(idsResponse.getStatus(),"Artifact request could not be successfully registered.").build();
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
                    return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode(),process.getErrorDetail()).build();
                } else {
                    String body=process.getDataRequest().getDataDestination().getProperty(SparqlDataflowController.DESTINATION_PROPERTY_RESPONSE);
                    monitor.debug(body);
                    return Response.ok(body,
                            MediaType.APPLICATION_XML_TYPE).build();
                }
            }
        } catch(Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode(),e.getMessage()).build();
        }
    }

    @Override
    public void created(TransferProcess process) {
        String correlationId=process.getDataRequest().getDataDestination().getProperty(CORRELATION_HEADER);
        synchronized (openRequests) {
            if(openRequests.containsKey(correlationId)) {
                openRequests.put(correlationId, process);
            }
        }
    }

    @Override
    public void inProgress(TransferProcess process) {
        String correlationId=process.getDataRequest().getDataDestination().getProperty(CORRELATION_HEADER);
        synchronized (openRequests) {
            if(openRequests.containsKey(correlationId)) {
                openRequests.put(correlationId, process);
                openRequests.notifyAll();
            }
        }
    }

    @Override
    public void ended(TransferProcess process) {
        String correlationId=process.getDataRequest().getDataDestination().getProperty(CORRELATION_HEADER);
        synchronized (openRequests) {
            if(openRequests.containsKey(correlationId)) {
                openRequests.put(correlationId, process);
                openRequests.notifyAll();
            }
        }
    }

    @Override
    public void error(TransferProcess process) {
        String correlationId=process.getDataRequest().getDataDestination().getProperty(CORRELATION_HEADER);
        synchronized (openRequests) {
            if(openRequests.containsKey(correlationId)) {
                openRequests.put(correlationId, process);
                openRequests.notifyAll();
            }
        }
    }


}

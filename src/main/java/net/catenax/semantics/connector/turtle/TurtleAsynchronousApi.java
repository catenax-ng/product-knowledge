/*
 * Copyright (c) 2021-2022 T-Systems International GmbH (Catena-X Consortium)
 *
 * See the AUTHORS file(s) distributed with this work for additional
 * information regarding authorship.
 *
 * See the LICENSE file(s) distributed with this work for
 * additional information regarding license terms.
 */
package net.catenax.semantics.connector.turtle;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.HttpHeaders;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import net.catenax.semantics.connector.policy.CrossConnectorPolicy;
import net.catenax.semantics.connector.TripleDataPlaneExtension;
import net.catenax.semantics.triples.SparqlHelper;
import org.eclipse.dataspaceconnector.ids.spi.daps.DapsService;
import org.eclipse.dataspaceconnector.ids.spi.policy.IdsPolicyService;
import org.eclipse.dataspaceconnector.policy.engine.PolicyEvaluationResult;
import org.eclipse.dataspaceconnector.spi.asset.AssetIndex;
import org.eclipse.dataspaceconnector.spi.asset.DataAddressResolver;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.policy.PolicyRegistry;
import org.eclipse.dataspaceconnector.spi.security.Vault;
import org.eclipse.dataspaceconnector.spi.transfer.TransferProcessListener;
import org.eclipse.dataspaceconnector.spi.transfer.TransferProcessManager;
import org.glassfish.jersey.media.multipart.FormDataParam;

import java.io.File;
import java.io.IOException;
import java.util.Map;

/**
 * Asynchronous turtle upload API data plane controller
 * which does an internal update to graph and then
 * delegates to any pending subscription.
 * - catenax-connector-context: should be a list of connector-urn#asset with which
 *   to perform a union of the target data
 * - catenax-security-token: a (federated) token containing all relevant agreement claims and signed
 *   by all relevant connectors
 * - catenax-correlation-id (optional): a unique request id which serves to do a lineage analysis
 *   in case of problems.
 */
@Path("/turtle")
public class TurtleAsynchronousApi implements TransferProcessListener {

    /**
     * logging service
     */
    protected final Monitor monitor;
    protected final DataAddressResolver resolver;
    protected final AssetIndex assetIndex;
    protected final IdsPolicyService policyService;
    protected final PolicyRegistry policyRegistry;
    protected final DapsService dapsService;
    protected final String connectorId;
    protected final TurtleAsynchronousDataflow turtleFlow;
    protected final SparqlHelper internalService;

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
    public TurtleAsynchronousApi(TurtleAsynchronousDataflow turtleflow,
                                 DataAddressResolver resolver,
                                 DapsService dapsService,
                                 AssetIndex assetIndex,
                                 TransferProcessManager processManager,
                                 IdsPolicyService policyService,
                                 PolicyRegistry policyRegistry,
                                 Vault vault,
                                 Monitor monitor,
                                 SparqlHelper internalService,
                                 String connectorId) {
        this.turtleFlow=turtleflow;
        this.monitor = monitor;
        this.resolver=resolver;
        this.connectorId=connectorId;
        this.assetIndex=assetIndex;
        this.policyService=policyService;
        this.dapsService=dapsService;
        this.policyRegistry=policyRegistry;
        this.internalService=internalService;
    }

    /**
     * A post call is done when the query becomes too large.
     * The expected body is of media type "application/sparql-query".
     * The result will be XML (default) or JSON.
     * @param asset The asset usually points to a database (and a graph therein that is associated to an access policy)
     * @param turtle A valid turtle file
     * @param httpHeaders the headers of the request
     * @return the response object contains the result binding (in case of success) or an encoded string with error details (in case of failure).
     */
    @POST
    @Path("{asset: [a-zA-Z0-9_/\\-]+}")
    @Consumes({MediaType.MULTIPART_FORM_DATA})
    @Produces({ MediaType.TEXT_HTML })
    public Response post(
            @PathParam("asset") String asset,
            @FormDataParam("file") File turtle,
            @FormDataParam("graph") String graph,
            @Context HttpHeaders httpHeaders
    ) {
        return process(asset, turtle, graph, httpHeaders);
    }

    /**
     * Implements the actual
     * request initiation and synchronisation
     * (no matter the HTTP method used)
     * @param asset The asset usually points to a database (and a graph therein that is associated to an access policy)
     * @param turtle A valid turtle file
     * @param headers the headers of the request
     * @return the response object contains the result binding (in case of success) or an encoded string with error details (in case of failure).
     */
    protected Response process(String asset, File turtle, String graph, HttpHeaders headers) {
        var assetName=asset+"#"+graph;

        String agreementToken=headers.getHeaderString(TripleDataPlaneExtension.AGREEMENT_HEADER);
        String issuerConnectors=headers.getHeaderString(TripleDataPlaneExtension.CONNECTOR_HEADER);
        String correlationId=headers.getHeaderString(TripleDataPlaneExtension.CORRELATION_HEADER);

        String type = "INSERT";

        // logging
        monitor.debug(String.format("Received API query %s to asset %s from calling connector(s) %s",correlationId,assetName,issuerConnectors));

        var verificationResult = dapsService.verifyAndConvertToken(agreementToken);
        if(!verificationResult.valid()) {
            return fail(MediaType.TEXT_HTML,Response.Status.UNAUTHORIZED,String.format("Access must be authenticated.",assetName));
        }
        var assetObject = assetIndex.findById(assetName);
        if(assetObject==null) {
            return fail(MediaType.TEXT_HTML,Response.Status.NOT_FOUND,String.format("Asset %s does not exist.",assetName));
        }
        var policy = policyRegistry.resolvePolicy(assetObject.getPolicyId());
        if(policy==null) {
            return fail(MediaType.TEXT_HTML,Response.Status.NOT_ACCEPTABLE,String.format("Policy %s for asset %s is not active.",assetObject.getPolicyId(),assetName));
        }

        PolicyEvaluationResult result = CrossConnectorPolicy.evaluatePolicy(policyService,assetName,
                Map.of(TripleDataPlaneExtension.REQUEST_TYPE,"INSERT"),policy,issuerConnectors, correlationId, verificationResult);

        if(!result.valid()) {
            return fail(MediaType.TEXT_HTML,Response.Status.FORBIDDEN,String.format("Policy %s of asset %s not verified",policy.getUid(),assetName));
        }

        var address= resolver.resolveForAsset(assetName);
        var assetEndpoint = address.getProperty(TripleDataPlaneExtension.ASSET_ENDPOINT_PROPERTY).toString()+"upload";

        String extendedIssuerConnectors=issuerConnectors;
        if(!extendedIssuerConnectors.startsWith(connectorId)) {
            extendedIssuerConnectors=connectorId+";"+extendedIssuerConnectors;
        }

        try {
            String response=internalService.uploadTurtle(assetEndpoint,graph,turtle,correlationId,extendedIssuerConnectors,agreementToken);

            monitor.debug(String.format("Performed a successful integration to asset %s graph %s",assetEndpoint,graph));

            // trigger events
            turtleFlow.triggerEvent(assetName,turtle,issuerConnectors,correlationId);

            // and return the result
            return Response.ok(response,MediaType.TEXT_HTML_TYPE).build();
        } catch (IOException e) {
            return fail(MediaType.TEXT_HTML,Response.Status.INTERNAL_SERVER_ERROR,e.getMessage());
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
        } else if(mediaType==MediaType.TEXT_HTML) {
            detail=String.format("<html><body><h1>Error</h1><p>%s</p></body></html>",detail);
        }
        return Response.status(status.getStatusCode(),detail).build();
    }

}

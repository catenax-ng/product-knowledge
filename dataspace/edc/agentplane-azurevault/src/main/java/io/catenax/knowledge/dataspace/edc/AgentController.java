//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.Response.ResponseBuilder;
import jakarta.ws.rs.core.Response.Status;
import jakarta.ws.rs.core.Context;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.HashMap;
import java.util.Map;

import org.apache.jena.fuseki.Fuseki;
import org.apache.jena.fuseki.metrics.MetricsProviderRegistry;
import org.apache.jena.fuseki.server.DataAccessPoint;
import org.apache.jena.fuseki.server.DataAccessPointRegistry;
import org.apache.jena.fuseki.server.DataService;
import org.apache.jena.fuseki.server.OperationRegistry;
import org.apache.jena.fuseki.servlets.HttpAction;
import org.apache.jena.fuseki.system.ActionCategory;
import org.apache.jena.sparql.core.DatasetGraph;
import org.apache.jena.sparql.core.DatasetGraphFactory;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;

/**
 * The Agent Controller provides an API endpoint
 * with which the EDC tenant can issue queries and execute
 * skills in interaction with local resources and the complete
 * Dataspace.
 * It is currently implemented on top of an Apache Fuseki Engine using
 * a memory store.
 * TODO deal with skill and graph assets
 * TODO exchange store
 * TODO perform agreements and route service via connector requests
 * TODO use a synchronized data catalogue for the default graph asset
 */
@Path("/agent")
public class AgentController {

    // EDC services
    private final Monitor monitor;
    private final AgreementController agreementController;

    // map EDC monitor to SLF4J (better than the builtin MonitorProvider)
    private final MonitorWrapper monitorWrapper;

    // some state to set when interacting with Fuseki
    private boolean verbose=true;
    private long count=-1;
    
    // the actual Fuseki engine components
    private final SparqlQueryProcessor processor;
    OperationRegistry operationRegistry= OperationRegistry.createEmpty();
    DataAccessPointRegistry dataAccessPointRegistry=new DataAccessPointRegistry(MetricsProviderRegistry.get().getMeterRegistry());

    // we need a single data access point (with its default graph)
    private DataAccessPoint api;
    
    // temporary local skill store
    private Map<String,String> skills=new HashMap<String,String>();
            
    /** 
     * creates a new agent controller 
     */
    public AgentController(Monitor monitor, AgreementController agreementController, AgentConfig config) {
        this.monitor = monitor;
        this.monitorWrapper=new MonitorWrapper(getClass().getName(),monitor);
        this.agreementController = agreementController;
        this.processor=new SparqlQueryProcessor();
        final DatasetGraph dataset = DatasetGraphFactory.createTxnMem();
        // read file with ontology, share this dataset with the catalogue sync procedure
        DataService.Builder dataService = DataService.newBuilder(dataset);
        DataService service=dataService.build();
        api=new DataAccessPoint(config.getAccessPoint(), service);
        dataAccessPointRegistry.register(api);
        monitor.debug(String.format("Activating data service %s under access point %s",service,api));
        service.goActive();
    }

    @Override
    public String toString() {
        return super.toString()+"/agent";
    }

    /**
     * wraps a response to a previous servlet API
     * @param jakartaResponse
     * @return wrapped/adapted response
     */
    public javax.servlet.http.HttpServletResponse getJavaxResponse(HttpServletResponse jakartaResponse) {
        return IJakartaWrapper.javaxify(jakartaResponse,javax.servlet.http.HttpServletResponse.class,monitor);
    }

    /**
     * wraps a request to a previous servlet API
     * @param jakartaRequest
     * @return wrapped/adapted request
     */
    public javax.servlet.http.HttpServletRequest getJavaxRequest(HttpServletRequest jakartaRequest) {
        return IJakartaWrapper.javaxify(jakartaRequest,javax.servlet.http.HttpServletRequest.class,monitor);
    }

    /**
     * endpoint for posting a query
     * @param request context
     * @param response context
     * @param asset can be a a named graph for executing a query or a skill asset
     * @return response
     */
    @POST
    @Consumes({"application/sparql-query"})
    public Response postQuery(@Context HttpServletRequest request,@Context HttpServletResponse response, @QueryParam("asset") String asset) {
        monitor.debug(String.format("Received a POST request %s for asset %s",request,asset));
        return executeQuery(request,response,asset);
    }

    /**
     * endpoint for getting a query
     * @param request context
     * @param response context
     * @param asset can be a a named graph for executing a query or a skill asset
     * @return response
     */
    @GET
    public Response getQuery(@Context HttpServletRequest request,@Context HttpServletResponse response, @QueryParam("asset") String asset) {
        monitor.debug(String.format("Received a GET request %s for asset %s",request,asset));
        return executeQuery(request,response,asset);
    }

    /**
     * the actual execution is done by delegating to the Fuseki engine
     * @param request http request
     * @param response http response
     * @param asset target graph
     * @return a response
     */
    public Response executeQuery(HttpServletRequest request,HttpServletResponse response, String asset) {
        String skill=skills.get(asset);

        // Should we check whether this already has been done? the context should be quite static
        request.getServletContext().setAttribute(Fuseki.attrVerbose, Boolean.valueOf(verbose));
        request.getServletContext().setAttribute(Fuseki.attrOperationRegistry, operationRegistry);
        request.getServletContext().setAttribute(Fuseki.attrNameRegistry, dataAccessPointRegistry);

        AgentHttpAction action=new AgentHttpAction(++count, monitorWrapper, getJavaxRequest(request), getJavaxResponse(response), skill);
        action.setRequest(api, api.getDataService());
        processor.execute(action); 

        // kind of redundant, but javaxrs likes it this way
        return Response.ok().build();   
    }

    /**
     * endpoint for posting a skill
     * @param query mandatory query
     * @param asset can be a a named graph for executing a query or a skill asset
     * @return response
     */
    @POST
    @Path("/skill")
    @Consumes({"application/sparql-query"})
    public Response postSkill(String query, @QueryParam("asset") String asset) {
        monitor.debug(String.format("Received a POST skill request %s %s ",asset,query));
        ResponseBuilder rb;
        if(skills.put(asset,query)!=null) {
            rb=Response.ok();
        } else {
            rb=Response.status(Status.CREATED);
        }
        return rb.build();
    }

    /**
     * endpoint for getting a skill
     * @param asset can be a a named graph for executing a query or a skill asset
     * @return response
     */
    @GET
    @Path("/skill")
    @Produces({"application/sparql-query"})
    public Response getSkill(@QueryParam("asset") String asset) {
        monitor.debug(String.format("Received a GET skill request %s",asset));
        ResponseBuilder rb;
        String query=skills.get(asset);
        if(query==null) {
            rb = Response.status(Status.NOT_FOUND);
        } else {
            rb = Response.ok(query);
        }
        return rb.build();
    }
}

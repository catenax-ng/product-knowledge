//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.http;

import io.catenax.knowledge.dataspace.edc.*;
import io.catenax.knowledge.dataspace.edc.service.DataManagement;
import io.catenax.knowledge.dataspace.edc.sparql.SparqlQueryProcessor;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.Response.ResponseBuilder;
import jakarta.ws.rs.core.Response.Status;
import jakarta.ws.rs.core.Context;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import okhttp3.*;
import org.apache.jena.fuseki.Fuseki;
import org.apache.jena.fuseki.metrics.MetricsProviderRegistry;
import org.apache.jena.fuseki.server.DataAccessPoint;
import org.apache.jena.fuseki.server.DataAccessPointRegistry;
import org.apache.jena.fuseki.server.DataService;
import org.apache.jena.fuseki.server.OperationRegistry;
import org.apache.jena.sparql.core.DatasetGraph;
import org.apache.jena.sparql.core.DatasetGraphFactory;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.types.domain.edr.EndpointDataReference;

import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * The Agent Controller provides an API endpoint
 * with which the EDC tenant can issue queries and execute
 * skills in interaction with local resources and the complete
 * Dataspace.
 * It is currently implemented using a single query language (SparQL) 
 * on top of an Apache Fuseki Engine using a memory store (for local
 * graphs=assets).
 * TODO deal with skill and graph assets
 * TODO exchange fixed store by configurable options
 * TODO perform agreements and route service via connector requests
 * TODO implement a synchronized data catalogue for the default graph asset
 */
@Path("/agent")
public class AgentController {

    // EDC services
    private final Monitor monitor;
    private final AgreementController agreementController;
    private final OkHttpClient client;
    private final AgentConfig config;

    // map EDC monitor to SLF4J (better than the builtin MonitorProvider)
    private final MonitorWrapper monitorWrapper;

    // some state to set when interacting with Fuseki
    private long count=-1;
    
    // the actual Fuseki engine components
    private final SparqlQueryProcessor processor;
    OperationRegistry operationRegistry= OperationRegistry.createEmpty();
    DataAccessPointRegistry dataAccessPointRegistry=new DataAccessPointRegistry(MetricsProviderRegistry.get().getMeterRegistry());

    // we need a single data access point (with its default graph)
    final private DataAccessPoint api;
    
    // temporary local skill store
    final private Map<String,String> skills=new HashMap<>();
            
    /** 
     * creates a new agent controller 
     */
    public AgentController(Monitor monitor, AgreementController agreementController, AgentConfig config, OkHttpClient client) {
        this.monitor = monitor;
        this.monitorWrapper=new MonitorWrapper(getClass().getName(),monitor);
        this.agreementController = agreementController;
        this.client=client;
        this.config=config;
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

    /**
     * render nicely
     */
    @Override
    public String toString() {
        return super.toString()+"/agent";
    }

    /**
     * wraps a response to a previous servlet API
     * @param jakartaResponse new servlet object
     * @return wrapped/adapted response
     */
    public javax.servlet.http.HttpServletResponse getJavaxResponse(HttpServletResponse jakartaResponse) {
        return IJakartaWrapper.javaxify(jakartaResponse,javax.servlet.http.HttpServletResponse.class,monitor);
    }

    /**
     * wraps a request to a previous servlet API
     * @param jakartaRequest new servlet object
     * @return wrapped/adapted request
     */
    public javax.servlet.http.HttpServletRequest getJavaxRequest(HttpServletRequest jakartaRequest) {
        return IJakartaWrapper.javaxify(jakartaRequest,javax.servlet.http.HttpServletRequest.class,monitor);
    }

    /**
     * endpoint for posting a query
     * @param request context
     * @param response context
     * @param asset can be a named graph for executing a query or a skill asset
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
     * @param asset can be a named graph for executing a query or a skill asset
     * @return response
     */
    @GET
    public Response getQuery(@Context HttpServletRequest request,@Context HttpServletResponse response, @QueryParam("asset") String asset) {
        monitor.debug(String.format("Received a GET request %s for asset %s",request,asset));
        return executeQuery(request,response,asset);
    }

    public static Pattern SKILL_PATTERN=Pattern.compile("((?<url>[^#]+)#)?(?<skill>(urn:(cx|artifact):)?Skill:.*)");
    public static Pattern GRAPH_PATTERN=Pattern.compile("((?<url>[^#]+)#)?(?<graph>(urn:(cx|artifact):)?Graph:.*)");

    /**
     * the actual execution is done by delegating to the Fuseki engine
     * @param request http request
     * @param response http response
     * @param asset target graph
     * @return a response
     */
    public Response executeQuery(HttpServletRequest request,HttpServletResponse response, String asset) {
        String skill=null;
        String graph=null;
        String remoteUrl=null;

        if(asset!=null) {
            Matcher matcher=GRAPH_PATTERN.matcher(asset);
            if(matcher.matches()) {
                remoteUrl=matcher.group("url");
                graph=matcher.group("graph");
            } else {
                matcher=SKILL_PATTERN.matcher(asset);
                if(!matcher.matches()) {
                    return Response.status(Response.Status.BAD_REQUEST).build();
                }
                remoteUrl=matcher.group("url");
                graph=matcher.group("skill");
            }
        }

        if(remoteUrl!=null) {
            return executeQueryRemote(request,response,remoteUrl,skill,graph);
        }

        // exchange skill against text
        skill=skills.get(asset);

        // Should we check whether this already has been done? the context should be quite static
        request.getServletContext().setAttribute(Fuseki.attrVerbose, config.isSparqlVerbose());
        request.getServletContext().setAttribute(Fuseki.attrOperationRegistry, operationRegistry);
        request.getServletContext().setAttribute(Fuseki.attrNameRegistry, dataAccessPointRegistry);

        AgentHttpAction action=new AgentHttpAction(++count, monitorWrapper, getJavaxRequest(request), getJavaxResponse(response), skill, graph);
        action.setRequest(api, api.getDataService());
        processor.execute(action); 

        // kind of redundant, but javax.ws.rs likes it this way
        return Response.ok().build();   
    }

    /**
     * the actual execution is done by delegating to the Dataspace
     * @param request http request
     * @param response http response
     * @param remoteUrl remote connector
     * @param skill target skill
     * @param graph target graph
     * @return a response
     */
    public Response executeQueryRemote(HttpServletRequest request,HttpServletResponse response, String remoteUrl, String skill, String graph)  {
        String asset = skill != null ? skill : graph;
        EndpointDataReference endpoint = agreementController.get(asset);
        if(endpoint==null) {
            try {
                endpoint=agreementController.createAgreement(remoteUrl,asset);
            } catch(IOException e) {
                throw new InternalServerErrorException(String.format("Could not get an agreement from connector %s to asset %s because of %s",remoteUrl,asset,e),e);
            }
        }
        if(endpoint==null) {
            throw new InternalServerErrorException(String.format("Could not get an agreement from connector %s to asset %s",remoteUrl,asset));
        }
        if("GET".equals(request.getMethod())) {
            try {
                response.getOutputStream().print(sendGETRequest(endpoint, "", request));
            } catch(IOException e) {
                throw new InternalServerErrorException(String.format("Could not delegate remote get call to connector %s asset %s because of %s",remoteUrl,asset,e),e);
            }
        } else if("POST".equals(request.getMethod())) {
            try {
                response.getOutputStream().print(sendPOSTRequest(endpoint, "", request));
            } catch(IOException e) {
                throw new InternalServerErrorException(String.format("Could not delegate remote post call to connector %s asset %s because of %s",remoteUrl,asset,e),e);
            }
        }
        return Response.ok().build();
    }

    /**
     * route a get request
     * @param dataReference the encoded call embedding
     * @param subUrl protocol-specific part
     * @param original request to route
     * @return string body
     * @throws IOException in case something strange happens
     */
    public String sendGETRequest(EndpointDataReference dataReference, String subUrl, HttpServletRequest original) throws IOException {
        var url = getUrl(dataReference.getEndpoint(), subUrl, original);

        var request = new Request.Builder()
                .url(url)
                .addHeader(Objects.requireNonNull(dataReference.getAuthKey()), Objects.requireNonNull(dataReference.getAuthCode()))
                .build();

        return sendRequest(request);
    }

    /**
     * route a post request
     * @param dataReference the encoded call embedding
     * @param subUrl protocol-specific part
     * @param original request to route
     * @return string body
     * @throws IOException in case something strange happens
     */
    public String sendPOSTRequest(EndpointDataReference dataReference, String subUrl, HttpServletRequest original) throws IOException {
        var url = getUrl(dataReference.getEndpoint(), subUrl, original);

        var request = new Request.Builder()
                .url(url)
                .addHeader(Objects.requireNonNull(dataReference.getAuthKey()), Objects.requireNonNull(dataReference.getAuthCode()))
                .addHeader("Content-Type", original.getContentType())
                .post(RequestBody.create(original.getInputStream().readAllBytes(), MediaType.parse(original.getContentType())))
                .build();

        return sendRequest(request);
    }

    /**
     * filter particular parameteres
     * @param key parameter key
     * @return whether to filter the parameter
     */
    protected boolean allowParameter(String key) {
        return !"asset".equals(key);
    }

    /**
     * computes the url to target the given data plane
     * @param connectorUrl data plane url
     * @param subUrl sub-path to use
     * @param original request to route
     * @return typed url
     */
    protected HttpUrl getUrl(String connectorUrl, String subUrl, HttpServletRequest original) throws UnsupportedEncodingException {
        var url = connectorUrl;

        if (subUrl != null && !subUrl.isEmpty()) {
            url = url + "/" + subUrl;
        }

        HttpUrl.Builder httpBuilder = Objects.requireNonNull(HttpUrl.parse(url)).newBuilder();
        for (Map.Entry<String, String[]> param : original.getParameterMap().entrySet()) {
            for (String value : param.getValue()) {
                if(allowParameter(param.getKey())) {
                    String recode = HttpUtils.urlEncodeParameter(value);
                    httpBuilder = httpBuilder.addQueryParameter(param.getKey(), recode);
                }
            }
        }

        return httpBuilder.build();
    }

    private String sendRequest(Request request) throws IOException {
        var response = client.newCall(request).execute();
        var body = response.body();

        if (!response.isSuccessful() || body == null) {
            monitor.severe(String.format("Data plane responded with error: %s %s", response.code(), body != null ? body.string() : ""));
            throw new InternalServerErrorException(String.format("Data plane responded with error status code %s", response.code()));
        }

        var bodyString = body.string();
        monitor.info("Data plane responded correctly: " + URLEncoder.encode(bodyString, DataManagement.URL_ENCODING));
        return bodyString;
    }

    /**
     * endpoint for posting a skill
     * @param query mandatory query
     * @param asset can be a named graph for executing a query or a skill asset
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
     * @param asset can be a named graph for executing a query or a skill asset
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

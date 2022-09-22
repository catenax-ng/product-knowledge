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
import java.net.URLEncoder;
import java.util.Map;

import okhttp3.*;
import org.apache.http.HttpStatus;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.types.domain.edr.EndpointDataReference;

import java.util.Objects;
import java.util.regex.Matcher;

/**
 * The Agent Controller provides an API endpoint
 * with which the EDC tenant can issue queries and execute
 * skills in interaction with local resources and the complete
 * Dataspace.
 * It is currently implemented using a single query language (SparQL) 
 * on top of an Apache Fuseki Engine using a memory store (for local
 * graphs=assets).
 * TODO deal with remote skills
 * TODO exchange fixed store by configurable options
 * TODO implement a synchronized data catalogue for the default graph asset
 * TODO generalize sub-protocols from SparQL
 */
@Path("/agent")
public class AgentController {

    // EDC services
    protected final Monitor monitor;
    protected final AgreementController agreementController;
    protected final OkHttpClient client;
    protected final AgentConfig config;
    protected final SkillStore skillStore;

    // the actual Fuseki engine components
    private final SparqlQueryProcessor processor;

    /** 
     * creates a new agent controller 
     * @param monitor logging subsystem
     * @param agreementController agreement controller for remote skill/queries
     * @param config configuration
     * @param client http client
     * @param processor sparql processor
     */
    public AgentController(Monitor monitor, AgreementController agreementController, AgentConfig config, OkHttpClient client, SparqlQueryProcessor processor, SkillStore skillStore) {
        this.monitor = monitor;
        this.agreementController = agreementController;
        this.client=client;
        this.config=config;
        this.processor=processor;
        this.skillStore=skillStore;
    }

    /**
     * render nicely
     */
    @Override
    public String toString() {
        return super.toString()+"/agent";
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
            Matcher matcher=AgentExtension.GRAPH_PATTERN.matcher(asset);
            if(matcher.matches()) {
                remoteUrl=matcher.group("url");
                graph=matcher.group("graph");
            } else {
                matcher=skillStore.matchSkill(asset);
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

        try {
            // exchange skill against text
            skill = skillStore.get(asset).orElse(null);

            processor.execute(request,response,skill,graph);
            // kind of redundant, but javax.ws.rs likes it this way
            return Response.ok().build();
        } catch(WebApplicationException e) {
            return HttpUtils.respond(request,e.getResponse().getStatus(),e.getMessage(),e.getCause());
        }
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
            } catch(WebApplicationException e) {
                return HttpUtils.respond(request, e.getResponse().getStatus(),String.format("Could not get an agreement from connector %s to asset %s",remoteUrl,asset),e.getCause());
            }
        }
        if(endpoint==null) {
            return HttpUtils.respond(request,HttpStatus.SC_FORBIDDEN,String.format("Could not get an agreement from connector %s to asset %s",remoteUrl,asset),null);
        }
        if("GET".equals(request.getMethod())) {
            try {
                response.getOutputStream().print(sendGETRequest(endpoint, "", request));
            } catch(IOException e) {
                return HttpUtils.respond(request, HttpStatus.SC_INTERNAL_SERVER_ERROR,String.format("Could not delegate remote GET call to connector %s asset %s",remoteUrl,asset),e);
            }
        } else if("POST".equals(request.getMethod())) {
            try {
                response.getOutputStream().print(sendPOSTRequest(endpoint, "", request));
            } catch(IOException e) {
                return HttpUtils.respond(request, HttpStatus.SC_INTERNAL_SERVER_ERROR,String.format("Could not delegate remote POST call to connector %s asset %s",remoteUrl,asset),e);
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

        monitor.debug(String.format("About to delegate GET %s",url));

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

        String contentType=original.getContentType();

        monitor.debug(String.format("About to delegate POST %s with content type %s",url,contentType));

        var request = new Request.Builder()
                .url(url)
                .addHeader(Objects.requireNonNull(dataReference.getAuthKey()), Objects.requireNonNull(dataReference.getAuthCode()))
                .addHeader("Content-Type", original.getContentType())
                .post(RequestBody.create(original.getInputStream().readAllBytes(), MediaType.parse(contentType)))
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

        if(original.getHeader("Accept")!=null) {
            httpBuilder = httpBuilder.addQueryParameter("cx_accept", HttpUtils.urlEncodeParameter(original.getHeader("Accept")));
        } else {
            httpBuilder = httpBuilder.addQueryParameter("cx_accept", HttpUtils.urlEncodeParameter("application/json"));
        }

        return httpBuilder.build();
    }

    /**
     * generic sendRequest method which extracts the result string of textual responses
     * @param request predefined request
     * @return string obtained in body
     * @throws IOException in case something goes wrong
     */
    protected String sendRequest(Request request) throws IOException {
        try(var response = client.newCall(request).execute()) {
            var body = response.body();

            if (!response.isSuccessful() || body == null) {
                monitor.severe(String.format("Data plane responded with error: %s %s", response.code(), body != null ? body.string() : ""));
                throw new InternalServerErrorException(String.format("Data plane responded with error status code %s", response.code()));
            }

            var bodyString = body.string();
            monitor.info("Data plane responded correctly: " + URLEncoder.encode(bodyString, DataManagement.URL_ENCODING));
            return bodyString;
        }
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
        if(skillStore.put(asset,query)!=null) {
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
        String query=skillStore.get(asset).orElse(null);
        if(query==null) {
            rb = Response.status(Status.NOT_FOUND);
        } else {
            rb = Response.ok(query);
        }
        return rb.build();
    }
}

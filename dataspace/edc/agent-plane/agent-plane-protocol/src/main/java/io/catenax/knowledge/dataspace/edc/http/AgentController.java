//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.http;

import io.catenax.knowledge.dataspace.edc.*;
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
import java.util.Map;

import okhttp3.*;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpStatus;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.types.domain.edr.EndpointDataReference;

import java.util.Objects;
import java.util.Optional;
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
 * TODO generalize sub-protocols from SparQL
 */
@Path("/agent")
public class AgentController {

    // EDC services
    protected final Monitor monitor;
    protected final IAgreementController agreementController;
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
    public AgentController(Monitor monitor, IAgreementController agreementController, AgentConfig config, OkHttpClient client, SparqlQueryProcessor processor, SkillStore skillStore) {
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
     * endpoint for posting a sparql query (maybe as a stored skill with a bindingset)
     * @param request context
     * @param response context
     * @param asset can be a named graph for executing a query or a skill asset
     * @return response
     */
    @POST
    @Consumes({"application/sparql-query","application/sparql-results+json"})
    public Response postSparqlQuery(@Context HttpServletRequest request,@Context HttpServletResponse response, @QueryParam("asset") String asset) {
        monitor.debug(String.format("Received a SparQL POST request %s for asset %s",request,asset));
        return executeQuery(request,response,asset);
    }

    /**
     * endpoint for posting a url-encoded form-based query
     * this is the default mode for graphdb which
     * sends the actual query language and other params together
     * with the query text in the body and expects a
     * special content disposition in the response header which
     * marks the body as a kind of file attachement.
     * @param request context
     * @param response context
     * @param asset can be a named graph for executing a query or a skill asset
     * @return response compatible with graphdb convention
     */
    @POST
    @Consumes({"application/x-www-form-urlencoded"})
    public Response postFormQuery(@Context HttpServletRequest request,@Context HttpServletResponse response, @QueryParam("asset") String asset) {
        monitor.debug(String.format("Received a Form-based POST request %s for asset %s",request,asset));
        Response result= executeQuery(request,response,asset);
        response.addHeader("Content-Disposition","attachement; filename=query-result.srjs");
        return result;
    }

    /**
     * endpoint for posting a url-encoded form-based query
     * this is the default mode for graphdb which
     * sends the actual query language and other params together
     * with the query text in the body and expects a
     * special content disposition in the response header which
     * marks the body as a kind of file attachement.
     * @param request context
     * @param response context
     * @param asset can be a named graph for executing a query or a skill asset
     * @return response compatible with graphdb convention
     */
    @POST
    @Path("/repositories/AGENT")
    @Consumes({"application/x-www-form-urlencoded"})
    public Response postFormRepositoryQuery(@Context HttpServletRequest request,@Context HttpServletResponse response, @QueryParam("asset") String asset) {
        monitor.debug(String.format("Received a Form-based POST repository request %s for asset %s",request,asset));
        Response result= executeQuery(request,response,asset);
        response.addHeader("Content-Disposition","attachement; filename=query-result.srjs");
        return result;
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
     * 2nd endpoint for getting a query
     * @param request context
     * @param response context
     * @param asset can be a named graph for executing a query or a skill asset
     * @return response
     */
    @GET
    @Path("/repositories/AGENT")
    public Response getRepositoryQuery(@Context HttpServletRequest request,@Context HttpServletResponse response, @QueryParam("asset") String asset) {
        monitor.debug(String.format("Received a GET repository request %s for asset %s",request,asset));
        return executeQuery(request,response,asset);
    }

    /**
     * check import status
     * @param request context
     * @return response
     */
    @GET
    @Path("/repositories/AGENT/import/active")
    public Response getRepositoryImportQuery(@Context HttpServletRequest request) {
        monitor.debug(String.format("Received a GET repository import active request %s",request));
        return Response.status(406,"Not Acceptable (HTTP status 406)").build();
    }

    /**
     * check size
     * @param request context
     * @return response
     */
    @GET
    @Path("/rest/repositories/AGENT/size")
    public Response getRestRepositorySizeQuery(@Context HttpServletRequest request) {
        monitor.debug(String.format("Received a GET rest repository size request %s",request));
        return Response.ok("{\n" +
                "    \"inferred\": 70,\n" +
                "    \"total\": 70,\n" +
                "    \"explicit\": 0\n" +
                "}").type(jakarta.ws.rs.core.MediaType.APPLICATION_JSON_TYPE).build();
    }

    /**
     * check size
     * @param request context
     * @return response
     */
    @GET
    @Path("/repositories/AGENT/size")
    public Response getRepositorySizeQuery(@Context HttpServletRequest request) {
        monitor.debug(String.format("Received a GET repository size request %s",request));
        return Response.ok("0" ).type(jakarta.ws.rs.core.MediaType.APPLICATION_JSON_TYPE).build();
    }

    /**
     * check import status
     * @param request context
     * @return response
     */
    @GET
    @Path("/rest/repositories/AGENT/import/active")
    public Response getRestRepositoryImportQuery(@Context HttpServletRequest request) {
        monitor.debug(String.format("Received a GET rest repository import active request %s",request));
        return Response.ok("0").type(jakarta.ws.rs.core.MediaType.APPLICATION_JSON_TYPE).build();
    }

    /**
     * return version info for graphdb/fedx integration
     * @param request context
     * @return version string
     */
    @GET
    @Path("/rest/info/version")
    public String getVersion(@Context HttpServletRequest request) {
        monitor.debug(String.format("Received a GET Version request %s",request));
        return "0.8.1";
    }

    /**
     * return protocol info for graphdb/fedx integration
     * @param request context
     * @return protocol string
     */
    @GET
    @Path("/protocol")
    public String getProtocol(@Context HttpServletRequest request) {
        monitor.debug(String.format("Received a GET Protocol request %s",request));
        return "12";
    }

    /**
     * return version info for graphdb/fedx integration
     * @param request context
     * @return version string
     */
    @GET
    @Path("/rest/locations/id")
    public String getId(@Context HttpServletRequest request) {
        monitor.debug(String.format("Received a GET Id request %s",request));
        return "Catena-X Knowledge Agent";
    }

    /**
     * return repositories for graphdb/fedx integration
     * @param request context
     * @return single repo as json
     */
    @GET
    @Path("/rest/repositories")
    public String getRestRepositories(@Context HttpServletRequest request) {
        monitor.debug(String.format("Received a GET Rest Repositories request %s",request));
        String url=request.getRequestURI();
        url=url.substring(0,url.length()-18);
        return "[\n" +
                "    {\n" +
                "        \"id\": \"AGENT\",\n" +
                "        \"title\": \"Catena-X Knowledge Agent Dataspace Endpoint\",\n" +
                "        \"uri\": \""+url+"\",\n" +
                "        \"externalUrl\": \""+url+"\",\n" +
                "        \"local\": false,\n" +
                "        \"type\": \"fuseki\",\n" +
                "        \"sesameType\": \"cx:AgentController\",\n" +
                "        \"location\": \"Catena-X Dev Dataspace\",\n" +
                "        \"readable\": true,\n" +
                "        \"writable\": true,\n" +
                "        \"unsupported\": false,\n" +
                "        \"state\": \"RUNNING\"\n" +
                "    }\n" +
                "]";
    }

    /**
     * return repositories for graphdb/fedx integration
     * @param request context
     * @return single repo as csv
     */
    @GET
    @Path("/repositories")
    public Response getRepositories(@Context HttpServletRequest request) {
        monitor.debug(String.format("Received a GET Repositories request %s",request));
        String url=request.getRequestURI();
        url=url.substring(0,url.length()-13);
        ResponseBuilder builder=Response.ok("uri,id,title,readable,writable\n"+url+",AGENT,Catena-X Knowledge Agent Dataspace Endpoint,true,true\n");
        builder.type("text/csv;charset=UTF-8");
        builder.header("Content-Disposition","attachment; filename=repositories.csv");
        return builder.build();
    }

    /**
     * return repositories for graphdb/fedx integration
     * @param request context
     * @return single repo as csv
     */
    @GET
    @Path("/repositories/AGENT/namespaces")
    public Response getNamespaces(@Context HttpServletRequest request) {
        monitor.debug(String.format("Received a GET Namespaces request %s",request));
        ResponseBuilder builder=Response.ok("prefix,namespace\n" +
                "rdf,http://www.w3.org/1999/02/22-rdf-syntax-ns#\n" +
                "owl,http://www.w3.org/2002/07/owl#\n" +
                "xsd,http://www.w3.org/2001/XMLSchema#\n" +
                "rdfs,http://www.w3.org/2000/01/rdf-schema#\n" +
                "cx,https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#\n");
        builder.type("text/csv;charset=UTF-8");
        builder.header("Content-Disposition","attachment; filename=namespaces.csv");
        return builder.build();
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
            if( asset!=null ) {
                if(skillStore.isSkill(asset)) {
                    Optional<String> skillOption = skillStore.get(asset);
                    if (skillOption.isPresent()) {
                        skill = skillOption.get();
                    } else {
                        return HttpUtils.respond(request, Status.NOT_FOUND.getStatusCode(), "The requested skill is not registered.", null);
                    }
                }
            }

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
                sendGETRequest(endpoint, "", request,response);
            } catch(IOException e) {
                return HttpUtils.respond(request, HttpStatus.SC_INTERNAL_SERVER_ERROR,String.format("Could not delegate remote GET call to connector %s asset %s",remoteUrl,asset),e);
            }
        } else if("POST".equals(request.getMethod())) {
            try {
                sendPOSTRequest(endpoint, "", request,response);
            } catch(IOException e) {
                return HttpUtils.respond(request, HttpStatus.SC_INTERNAL_SERVER_ERROR,String.format("Could not delegate remote POST call to connector %s asset %s",remoteUrl,asset),e);
            }
        } else {
            return HttpUtils.respond(request, HttpStatus.SC_METHOD_NOT_ALLOWED,String.format("%s calls to connector %s asset %s are not allowed",request.getMethod(),remoteUrl,asset),null);
        }
        return Response.ok().build();
    }

    /**
     * route a get request
     * @param dataReference the encoded call embedding
     * @param subUrl protocol-specific part
     * @param original request to route
     * @param response response to fill in
     * @throws IOException in case something strange happens
     */
    public void sendGETRequest(EndpointDataReference dataReference, String subUrl, HttpServletRequest original, HttpServletResponse response) throws IOException {
        var url = getUrl(dataReference.getEndpoint(), subUrl, original);

        monitor.debug(String.format("About to delegate GET %s",url));

        var requestBuilder = new Request.Builder()
                .url(url)
                .addHeader(Objects.requireNonNull(dataReference.getAuthKey()), Objects.requireNonNull(dataReference.getAuthCode()));

        var request = requestBuilder.build();

        sendRequest(request,response);
    }

    /**
     * route a post request
     * @param dataReference the encoded call embedding
     * @param subUrl protocol-specific part
     * @param original request to route
     * @param response response to fill
     * @throws IOException in case something strange happens
     */
    public void sendPOSTRequest(EndpointDataReference dataReference, String subUrl, HttpServletRequest original, HttpServletResponse response) throws IOException {
        var url = getUrl(dataReference.getEndpoint(), subUrl, original);

        String contentType=original.getContentType();

        monitor.debug(String.format("About to delegate POST %s with content type %s",url,contentType));

        var requestBuilder = new Request.Builder()
                .url(url)
                .addHeader(Objects.requireNonNull(dataReference.getAuthKey()), Objects.requireNonNull(dataReference.getAuthCode()))
                .addHeader("Content-Type", contentType);

        requestBuilder.post(RequestBody.create(original.getInputStream().readAllBytes(), MediaType.parse(contentType)));

        var request = requestBuilder.build();

        sendRequest(request,response);
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

        // EDC public api slash problem
        if(!url.endsWith("/")) {
            url = url + "/";
        }

        if (subUrl != null && !subUrl.isEmpty()) {
            url = url + subUrl;
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
     * @param origResponse response to provide
     * @throws IOException in case something goes wrong
     */
    protected void sendRequest(Request request, HttpServletResponse origResponse) throws IOException {
        try(var response = client.newCall(request).execute()) {

            if(!response.isSuccessful()) {
                monitor.warning(String.format("Data plane call was not successful: %s", response.code()));
            }

            origResponse.setStatus(response.code());

            for(String header : response.headers().names()) {
                for(String value : response.headers().values(header)) {
                    origResponse.addHeader(header,value);
                }
            }

            var body = response.body();

            if (body != null) {
                IOUtils.copy(body.byteStream(), origResponse.getOutputStream());
            }
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

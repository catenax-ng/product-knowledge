//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.http;

import com.fasterxml.jackson.core.type.TypeReference;
import io.catenax.knowledge.dataspace.edc.*;
import io.catenax.knowledge.dataspace.edc.sparql.CatenaxWarning;
import io.catenax.knowledge.dataspace.edc.sparql.SparqlQueryProcessor;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.List;
import java.util.Map;

import okhttp3.HttpUrl;
import okhttp3.OkHttpClient;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpStatus;
import org.eclipse.edc.spi.monitor.Monitor;
import org.eclipse.edc.spi.types.TypeManager;
import org.eclipse.edc.spi.types.domain.edr.EndpointDataReference;

import java.util.Objects;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * The Agent Controller exposes a REST API endpoint
 * with which the EDC tenant can issue queries and execute
 * skills in interaction with local resources and the complete
 * Dataspace (the so-called Matchmaking Agent that is also hit by
 * incoming Agent transfers).
 * TODO deal with remote (textual) skills
 * TODO exchange fixed memory store by configurable options
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

    // the actual Matchmaking Agent is a Fuseki engine
    protected final SparqlQueryProcessor processor;
    protected final TypeManager typeManager;
    public final static TypeReference<List<CatenaxWarning>> warningTypeReference = new TypeReference<>(){};

    /** 
     * creates a new agent controller 
     * @param monitor logging subsystem
     * @param agreementController agreement controller for remote skill/queries
     * @param config configuration
     * @param client http client
     * @param processor sparql processor
     */
    public AgentController(Monitor monitor, IAgreementController agreementController, AgentConfig config, OkHttpClient client, SparqlQueryProcessor processor, SkillStore skillStore, TypeManager typeManager) {
        this.monitor = monitor;
        this.agreementController = agreementController;
        this.client=client;
        this.config=config;
        this.processor=processor;
        this.skillStore=skillStore;
        this.typeManager=typeManager;
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
     * @param asset can be a named graph for executing a query or a skill asset
     * @return response
     */
    @POST
    @Consumes({"application/sparql-query","application/sparql-results+json"})
    public Response postSparqlQuery(@QueryParam("asset") String asset,
                                    @Context HttpHeaders headers,
                                    @Context HttpServletRequest request,
                                    @Context HttpServletResponse response,
                                    @Context UriInfo uri
    ) {
        monitor.debug(String.format("Received a SparQL POST request %s for asset %s",request,asset));
        return executeQuery(asset, headers, request, response, uri);
    }

    /**
     * endpoint for posting a url-encoded form-based query
     * this is the default mode for graphdb which
     * sends the actual query language and other params together
     * with the query text in the body and expects a
     * special content disposition in the response header which
     * marks the body as a kind of file attachement.
     * @param asset can be a named graph for executing a query or a skill asset
     * @return response compatible with graphdb convention
     */
    @POST
    @Consumes({"application/x-www-form-urlencoded"})
    public Response postFormQuery(@QueryParam("asset") String asset,
                                  @Context HttpHeaders headers,
                                  @Context HttpServletRequest request,
                                  @Context HttpServletResponse response,
                                  @Context UriInfo uri) {
        monitor.debug(String.format("Received a Form-based POST request %s for asset %s",request,asset));
        Response result= executeQuery(asset, headers, request, response, uri);
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
     * @param asset can be a named graph for executing a query or a skill asset
     * @return response compatible with graphdb convention
     */
    @POST
    @Path("/repositories/AGENT")
    @Consumes({"application/x-www-form-urlencoded"})
    public Response postFormRepositoryQuery(@QueryParam("asset") String asset,
                                            @Context HttpHeaders headers,
                                            @Context HttpServletRequest request,
                                            @Context HttpServletResponse response,
                                            @Context UriInfo uri) {
        monitor.debug(String.format("Received a Form-based POST repository request %s for asset %s",request,asset));
        Response result= executeQuery(asset, headers, request, response, uri);
        response.addHeader("Content-Disposition","attachement; filename=query-result.srjs");
        return result;
    }

    /**
     * endpoint for getting a query
     * @param asset can be a named graph for executing a query or a skill asset
     * @return response
     */
    @GET
    public Response getQuery(@QueryParam("asset") String asset,
                             @Context HttpHeaders headers,
                             @Context HttpServletRequest request,
                             @Context HttpServletResponse response,
                             @Context UriInfo uri) {
        monitor.debug(String.format("Received a GET request %s for asset %s",request,asset));
        return executeQuery(asset, headers, request, response, uri);
    }

    /**
     * 2nd endpoint for getting a query
     * @param asset can be a named graph for executing a query or a skill asset
     * @return response
     */
    @GET
    @Path("/repositories/AGENT")
    public Response getRepositoryQuery(@QueryParam("asset") String asset,
                                       @Context HttpHeaders headers,
                                       @Context HttpServletRequest request,
                                       @Context HttpServletResponse response,
                                       @Context UriInfo uri) {
        monitor.debug(String.format("Received a GET repository request %s for asset %s",request,asset));
        return executeQuery(asset, headers, request, response, uri);
    }

    /**
     * check import status
     * @return response
     */
    @GET
    @Path("/repositories/AGENT/import/active")
    public Response getRepositoryImportQuery(
            @Context HttpHeaders headers,
            @Context HttpServletRequest request,
            @Context HttpServletResponse response,
            @Context UriInfo uri) {
        monitor.debug(String.format("Received a GET repository import active request %s",request));
        return Response.status(406,"Not Acceptable (HTTP status 406)").build();
    }

    /**
     * check size
     * @return response
     */
    @GET
    @Path("/rest/repositories/AGENT/size")
    public Response getRestRepositorySizeQuery(
            @Context HttpHeaders headers,
            @Context HttpServletRequest request,
            @Context HttpServletResponse response,
            @Context UriInfo uri) {
        monitor.debug(String.format("Received a GET rest repository size request %s",request));
        return Response.ok("{\n" +
                "    \"inferred\": 70,\n" +
                "    \"total\": 70,\n" +
                "    \"explicit\": 0\n" +
                "}").type(jakarta.ws.rs.core.MediaType.APPLICATION_JSON_TYPE).build();
    }

    /**
     * check size
     * @return response
     */
    @GET
    @Path("/repositories/AGENT/size")
    public Response getRepositorySizeQuery(
            @Context HttpHeaders headers,
            @Context HttpServletRequest request,
            @Context HttpServletResponse response,
            @Context UriInfo uri) {
        monitor.debug(String.format("Received a GET repository size request %s",request));
        return Response.ok("0" ).type(jakarta.ws.rs.core.MediaType.APPLICATION_JSON_TYPE).build();
    }

    /**
     * check import status
     * @return response
     */
    @GET
    @Path("/rest/repositories/AGENT/import/active")
    public Response getRestRepositoryImportQuery(
            @Context HttpHeaders headers,
            @Context HttpServletRequest request,
            @Context HttpServletResponse response,
            @Context UriInfo uri) {
        monitor.debug(String.format("Received a GET rest repository import active request %s",request));
        return Response.ok("0").type(jakarta.ws.rs.core.MediaType.APPLICATION_JSON_TYPE).build();
    }

    /**
     * return version info for graphdb/fedx integration
     * @return version string
     */
    @GET
    @Path("/rest/info/version")
    public String getVersion(
            @Context HttpHeaders headers,
            @Context HttpServletRequest request,
            @Context HttpServletResponse response,
            @Context UriInfo uri) {
        monitor.debug(String.format("Received a GET Version request %s",request));
        return "0.8.4";
    }

    /**
     * return protocol info for graphdb/fedx integration
     * @return protocol string
     */
    @GET
    @Path("/protocol")
    public String getProtocol(
            @Context HttpHeaders headers,
            @Context HttpServletRequest request,
            @Context HttpServletResponse response,
            @Context UriInfo uri) {
        monitor.debug(String.format("Received a GET Protocol request %s",request));
        return "12";
    }

    /**
     * return version info for graphdb/fedx integration
     * @return version string
     */
    @GET
    @Path("/rest/locations/id")
    public String getId(
            @Context HttpHeaders headers,
            @Context HttpServletRequest request,
            @Context HttpServletResponse response,
            @Context UriInfo uri) {
        monitor.debug(String.format("Received a GET Id request %s",request));
        return "Catena-X Knowledge Agent";
    }

    /**
     * return repositories for graphdb/fedx integration
     * @return single repo as json
     */
    @GET
    @Path("/rest/repositories")
    public String getRestRepositories(
            @Context HttpHeaders headers,
            @Context HttpServletRequest request,
            @Context HttpServletResponse response,
            @Context UriInfo uri) {
        monitor.debug(String.format("Received a GET Rest Repositories request %s",request));
        String url=uri.toString();
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
     * @return single repo as csv
     */
    @GET
    @Path("/repositories")
    public Response getRepositories(
            @Context HttpHeaders headers,
            @Context HttpServletRequest request,
            @Context HttpServletResponse response,
            @Context UriInfo uri) {
        monitor.debug(String.format("Received a GET Repositories request %s",request));
        String url=uri.toString();
        url=url.substring(0,url.length()-13);
        Response.ResponseBuilder builder=Response.ok("uri,id,title,readable,writable\n"+url+",AGENT,Catena-X Knowledge Agent Dataspace Endpoint,true,true\n");
        builder.type("text/csv;charset=UTF-8");
        builder.header("Content-Disposition","attachment; filename=repositories.csv");
        return builder.build();
    }

    /**
     * return repositories for graphdb/fedx integration
     * @return single repo as csv
     */
    @GET
    @Path("/repositories/AGENT/namespaces")
    public Response getNamespaces(
            @Context HttpHeaders headers,
            @Context HttpServletRequest request,
            @Context HttpServletResponse response,
            @Context UriInfo uri) {
        monitor.debug(String.format("Received a GET Namespaces request %s",request));
        Response.ResponseBuilder builder=Response.ok("prefix,namespace\n" +
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
     * @param asset target graph
     * @return a response
     */
    public Response executeQuery(String asset, HttpHeaders headers, HttpServletRequest request, HttpServletResponse response, UriInfo uri) {
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
                skill=matcher.group("skill");
            }
        }

        if(remoteUrl!=null) {
            return executeQueryRemote(remoteUrl,skill,graph, headers, request, response, uri);
        }

        try {
            // exchange skill against text
            if( asset!=null ) {
                if(skillStore.isSkill(asset)) {
                    Optional<String> skillOption = skillStore.get(asset);
                    if (skillOption.isPresent()) {
                        skill = skillOption.get();
                    } else {
                        return HttpUtils.respond(monitor,headers, HttpStatus.SC_NOT_FOUND, "The requested skill is not registered.", null);
                    }
                }
            }

            processor.execute(request,response,skill,graph);
            // kind of redundant, but javax.ws.rs likes it this way
            return Response.status(response.getStatus()).build();
        } catch(WebApplicationException e) {
            return HttpUtils.respond(monitor,headers,e.getResponse().getStatus(),e.getMessage(),e.getCause());
        }
    }

    /**
     * the actual execution is done by delegating to the Dataspace
     * @param remoteUrl remote connector
     * @param skill target skill
     * @param graph target graph
     * @return a response
     */
    public Response executeQueryRemote(String remoteUrl, String skill, String graph, HttpHeaders headers, HttpServletRequest request, HttpServletResponse response, UriInfo uri)  {
        String asset = skill != null ? skill : graph;
        EndpointDataReference endpoint = agreementController.get(asset);
        if(endpoint==null) {
            try {
                endpoint=agreementController.createAgreement(remoteUrl,asset);
            } catch(WebApplicationException e) {
                return HttpUtils.respond(monitor,headers, e.getResponse().getStatus(),String.format("Could not get an agreement from connector %s to asset %s",remoteUrl,asset),e.getCause());
            }
        }
        if(endpoint==null) {
            return HttpUtils.respond(monitor,headers,HttpStatus.SC_FORBIDDEN,String.format("Could not get an agreement from connector %s to asset %s",remoteUrl,asset),null);
        }
        if("GET".equals(request.getMethod())) {
            try {
                sendGETRequest(endpoint, "", headers, response, uri);
            } catch(IOException e) {
                return HttpUtils.respond(monitor,headers, HttpStatus.SC_INTERNAL_SERVER_ERROR,String.format("Could not delegate remote GET call to connector %s asset %s",remoteUrl,asset),e);
            }
        } else if("POST".equals(request.getMethod())) {
            try {
                sendPOSTRequest(endpoint, "", headers, request, response, uri);
            } catch(IOException e) {
                return HttpUtils.respond(monitor,headers, HttpStatus.SC_INTERNAL_SERVER_ERROR,String.format("Could not delegate remote POST call to connector %s asset %s",remoteUrl,asset),e);
            }
        } else {
            return HttpUtils.respond(monitor,headers, HttpStatus.SC_METHOD_NOT_ALLOWED,String.format("%s calls to connector %s asset %s are not allowed",request.getMethod(),remoteUrl,asset),null);
        }
        return Response.status(response.getStatus()).build();
    }

    /**
     * route a get request
     * @param dataReference the encoded call embedding
     * @param subUrl protocol-specific part
     * @throws IOException in case something strange happens
     */
    public void sendGETRequest(EndpointDataReference dataReference, String subUrl, HttpHeaders headers, HttpServletResponse response, UriInfo uri) throws IOException {
        var url = getUrl(dataReference.getEndpoint(), subUrl, headers, uri);

        monitor.debug(String.format("About to delegate GET %s",url));

        var requestBuilder = new okhttp3.Request.Builder()
                .url(url)
                .addHeader(Objects.requireNonNull(dataReference.getAuthKey()), Objects.requireNonNull(dataReference.getAuthCode()));

        var newRequest = requestBuilder.build();

        sendRequest(newRequest, response);
    }

    /**
     * route a post request
     * @param dataReference the encoded call embedding
     * @param subUrl protocol-specific part
     * @throws IOException in case something strange happens
     */
    public void sendPOSTRequest(EndpointDataReference dataReference, String subUrl, HttpHeaders headers, HttpServletRequest request, HttpServletResponse response, UriInfo uri) throws IOException {
        var url = getUrl(dataReference.getEndpoint(), subUrl, headers, uri);

        String contentType=request.getContentType();
        okhttp3.MediaType parsedContentType=okhttp3.MediaType.parse(contentType);

        monitor.debug(String.format("About to delegate POST %s with content type %s",url,contentType));

        var requestBuilder = new okhttp3.Request.Builder()
                .url(url)
                .addHeader(Objects.requireNonNull(dataReference.getAuthKey()), Objects.requireNonNull(dataReference.getAuthCode()))
                .addHeader("Content-Type", contentType);

        requestBuilder.post(okhttp3.RequestBody.create(request.getInputStream().readAllBytes(),parsedContentType));

        var newRequest = requestBuilder.build();

        sendRequest(newRequest, response);
    }

    protected static Pattern PARAMETER_KEY_ALLOW = Pattern.compile("^(?!asset$)[^&?=]+$");
    protected static Pattern PARAMETER_VALUE_ALLOW = Pattern.compile("^[^&?=]+$");

    /**
     * computes the url to target the given data plane
     * @param connectorUrl data plane url
     * @param subUrl sub-path to use
     * @param headers containing additional info that we need to wrap into a transfer request
     * @return typed url
     */
    protected HttpUrl getUrl(String connectorUrl, String subUrl, HttpHeaders headers, UriInfo uri) throws UnsupportedEncodingException {
        var url = connectorUrl;

        // EDC public api slash problem
        if(!url.endsWith("/")) {
            url = url + "/";
        }

        if (subUrl != null && !subUrl.isEmpty()) {
            url = url + subUrl;
        }

        HttpUrl.Builder httpBuilder = Objects.requireNonNull(okhttp3.HttpUrl.parse(url)).newBuilder();
        for (Map.Entry<String, List<String>> param : uri.getQueryParameters().entrySet()) {
            String key=param.getKey();
            if(PARAMETER_KEY_ALLOW.matcher(key).matches()) {
                for (String value : param.getValue()) {
                    if(PARAMETER_VALUE_ALLOW.matcher(value).matches()) {
                        String recodeKey = HttpUtils.urlEncodeParameter(key);
                        String recodeValue = HttpUtils.urlEncodeParameter(value);
                        httpBuilder = httpBuilder.addQueryParameter(recodeKey, recodeValue);
                    }
                }
            }
        }

        List<MediaType> mediaTypes=headers.getAcceptableMediaTypes();
        if(mediaTypes.isEmpty() || mediaTypes.stream().anyMatch(MediaType.APPLICATION_JSON_TYPE::isCompatible)) {
            httpBuilder = httpBuilder.addQueryParameter("cx_accept", HttpUtils.urlEncodeParameter("application/json"));
        } else {
            String mediaParam=mediaTypes.stream().map(MediaType::toString).collect(Collectors.joining(", "));
            mediaParam=HttpUtils.urlEncodeParameter(mediaParam);
            httpBuilder.addQueryParameter("cx_accept",mediaParam);
        }
        return httpBuilder.build();
    }

    /**
     * generic sendRequest method which extracts the result string of textual responses
     * @param request predefined request
     * @throws IOException in case something goes wrong
     */
    protected void sendRequest(okhttp3.Request request, HttpServletResponse response) throws IOException {
        try(var myResponse = client.newCall(request).execute()) {

            if(!myResponse.isSuccessful()) {
                monitor.warning(String.format("Data plane call was not successful: %s", myResponse.code()));
            }

            response.setStatus(myResponse.code());

            Optional<List<CatenaxWarning>> warnings=Optional.empty();

            for(String header : myResponse.headers().names()) {
                for(String value : myResponse.headers().values(header)) {
                    if(header.equals("cx_warnings")) {
                        warnings=Optional.of(typeManager.getMapper().readValue(value,warningTypeReference ));
                    } else if(!header.equals("Content-Length")) {
                        response.addHeader(header, value);
                    }
                }
            }

            var body = myResponse.body();

            if (body != null) {
                okhttp3.MediaType contentType=body.contentType();
                InputStream inputStream=new BufferedInputStream(body.byteStream());
                inputStream.mark(2);
                byte[] boundaryBytes=new byte[2];
                String boundary="";
                if(inputStream.read(boundaryBytes)>0) {
                    boundary = new String(boundaryBytes);
                }
                inputStream.reset();
                if("--".equals(boundary)) {
                    if(contentType!=null) {
                        int boundaryIndex;
                        boundaryIndex=contentType.toString().indexOf(";boundary=");
                        if(boundaryIndex>=0) {
                            boundary=boundary+contentType.toString().substring(boundaryIndex+10);
                        }
                    }
                    StringBuilder nextPart=null;
                    String embeddedContentType=null;
                    BufferedReader reader=new BufferedReader(new InputStreamReader(inputStream));
                    for(String line = reader.readLine(); line!=null; line=reader.readLine()) {
                        if(boundary.equals(line)) {
                            if(nextPart!=null && embeddedContentType!=null) {
                                if(embeddedContentType.equals("application/cx-warnings+json")) {
                                    List<CatenaxWarning> nextWarnings=typeManager.readValue(nextPart.toString(),warningTypeReference);
                                    if(warnings.isPresent()) {
                                        warnings.get().addAll(nextWarnings);
                                    } else {
                                        warnings=Optional.of(nextWarnings);
                                    }
                                } else {
                                    inputStream=new ByteArrayInputStream(nextPart.toString().getBytes());
                                    contentType=okhttp3.MediaType.parse(embeddedContentType);
                                }
                            }
                            nextPart=new StringBuilder();
                            String contentLine=reader.readLine();
                            if(contentLine!=null && contentLine.startsWith("Content-Type: ")) {
                                embeddedContentType=contentLine.substring(14);
                            } else {
                                embeddedContentType=null;
                            }
                        } else if(nextPart!=null) {
                            nextPart.append(line);
                            nextPart.append("\n");
                        }
                    }
                    reader.close();
                    if(nextPart!=null && embeddedContentType!=null) {
                        if(embeddedContentType.equals("application/cx-warnings+json")) {
                            List<CatenaxWarning> nextWarnings=typeManager.readValue(nextPart.toString(), warningTypeReference);
                            if(warnings.isPresent()) {
                                warnings.get().addAll(nextWarnings);
                            } else {
                                warnings=Optional.of(nextWarnings);
                            }
                        } else {
                            inputStream=new ByteArrayInputStream(nextPart.toString().getBytes());
                            contentType=okhttp3.MediaType.parse(embeddedContentType);
                        }
                    }
                }
                warnings.ifPresent(catenaxWarnings -> response.addHeader("cx_warnings", typeManager.writeValueAsString(catenaxWarnings)));
                if(contentType!=null) {
                    response.setContentType(contentType.toString());
                }
                IOUtils.copy(inputStream, response.getOutputStream());
                inputStream.close();
                //response.getOutputStream().close();
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
        Response.ResponseBuilder rb;
        if(skillStore.put(asset,query)!=null) {
            rb=Response.ok();
        } else {
            rb=Response.status(HttpStatus.SC_CREATED);
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
        Response.ResponseBuilder rb;
        String query=skillStore.get(asset).orElse(null);
        if(query==null) {
            rb = Response.status(HttpStatus.SC_NOT_FOUND);
        } else {
            rb = Response.ok(query);
        }
        return rb.build();
    }
}

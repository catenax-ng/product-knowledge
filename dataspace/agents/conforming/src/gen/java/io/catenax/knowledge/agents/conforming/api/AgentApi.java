//
// Conforming Agent Implementation
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.conforming.api;

import io.catenax.knowledge.agents.conforming.model.CxWarning;
import io.catenax.knowledge.agents.conforming.model.XmlResultset;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.headers.Header;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;

import io.catenax.knowledge.agents.conforming.model.JsonResultset;

import java.util.List;

import javax.ws.rs.core.*;
import javax.ws.rs.*;

@Path("/")
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.JavaJerseyServerCodegen", date = "2023-03-23T11:28:11.277776230Z[GMT]")public abstract class AgentApi  {

    @Context public SecurityContext securityContext;
    @Context public Application application;
    @Context public HttpHeaders headers;
    @Context public Request request;
    @Context public Response response;
    @Context public UriInfo uri;

    @GET
    @Produces({ "application/sparql-results+json",
                "application/sparql-results+xml"
    })
    @Operation(summary = "Invoke a Skill or Query (Simple)", description = "", tags={ "agent" })
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The SparQL query has been processed successfully.",
                    content = {
                            @Content(mediaType = "application/sparql-results+json", schema = @Schema(implementation = JsonResultset.class)),
                            @Content(mediaType = "application/sparql-results+xml", schema = @Schema(implementation = XmlResultset.class))
            }),
            @ApiResponse(responseCode = "203", description = "The SparQL query has been processed successfully but warnings did occur.",
                    headers = { @Header(name="cx_warnings",schema=@Schema(type="array",implementation=CxWarning.class))},
                     content = {
                        @Content(mediaType = "application/sparql-results+json", schema = @Schema(implementation = JsonResultset.class)),
                        @Content(mediaType = "application/sparql-results+xml", schema = @Schema(implementation = XmlResultset.class))
            }),
            @ApiResponse(responseCode = "400", description = "Bad request or malformed SPARQL"),
            @ApiResponse(responseCode = "500", description = "Fatal error")
    })
    public abstract Response getAgent(
            @Parameter(in = ParameterIn.QUERY, description = "The Target Asset of the Query (targets the complete dataspace if empty)")
            @QueryParam("asset") String asset,
            @Parameter(in = ParameterIn.QUERY, description = "The Query language (fixed: SPARQL)")
            @QueryParam("queryLn") String queryLn,
            @Parameter(in = ParameterIn.QUERY, description = "The SPARQL query")
            @QueryParam("query") String query,
            @Parameter(in = ParameterIn.QUERY, description = "A sample bound parameter 'vin' which opens a new input tuple")
            @QueryParam("(vin") String _vin,
            @Parameter(in = ParameterIn.QUERY, description = "A sample multi-bound parameter 'troubleCode' which closes the tuple")
            @QueryParam("troubleCode") List<String> troubleCode)
    throws NotFoundException;

    @POST
    @Consumes({ "application/sparql-results+json", "application/sparql-results+xml", "application/sparql-query" })
    @Produces({ "application/sparql-results+json", "application/sparql-results+xml" })
    @Operation(summary = "Invoke a Skill or Query (Flexible)", description = "", tags={ "agent" })
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The SparQL query has been processed successfully.",
                    content = {
                            @Content(mediaType = "application/sparql-results+json", schema = @Schema(implementation = JsonResultset.class)),
                            @Content(mediaType = "application/sparql-results+xml", schema = @Schema(implementation = XmlResultset.class))
                    }),
            @ApiResponse(responseCode = "203", description = "The SparQL query has been processed successfully but warnings did occur.",
                    headers = { @Header(name="cx_warnings",schema=@Schema(type="array",implementation=CxWarning.class))},
                    content = {
                            @Content(mediaType = "application/sparql-results+json", schema = @Schema(implementation = JsonResultset.class)),
                            @Content(mediaType = "application/sparql-results+xml", schema = @Schema(implementation = XmlResultset.class))
                    }),
            @ApiResponse(responseCode = "400", description = "Bad request or malformed SPARQL"),
            @ApiResponse(responseCode = "500", description = "Fatal error")
    })
    public abstract Response postAgent(
            @Parameter(in = ParameterIn.DEFAULT, description = "The body either contains the query or a binding data set when a skill is invoked" ,required=true)
            Object body,
            @Parameter(in = ParameterIn.QUERY, description = "The Target Asset of the Query (targets the complete dataspace if empty)")
            @QueryParam("asset") String asset,
            @Parameter(in = ParameterIn.QUERY, description = "The Query language (fixed: SPARQL)")
            @QueryParam("queryLn") String queryLn,
            @Parameter(in = ParameterIn.QUERY, description = "The SPARQL query")
            @QueryParam("query") String query,
            @Parameter(in = ParameterIn.QUERY, description = "A sample bound parameter 'vin' which opens a new input tuple")
            @QueryParam("(vin") String _vin,
            @Parameter(in = ParameterIn.QUERY, description = "A sample multi-bound parameter 'troubleCode' which closes the tuple")
            @QueryParam("troubleCode") List<String> troubleCode)
    throws NotFoundException;

    @POST
    @Path("/skill")
    @Consumes({ "application/sparql-query" })
    @Operation(summary = "Register a Skill", description = "", tags={ "agent" })
    @ApiResponses(value = { 
        @ApiResponse(responseCode = "200", description = "Skill has been registered"),
        @ApiResponse(responseCode = "204", description = "Skill has been updated"),
        @ApiResponse(responseCode = "400", description = "Bad request or malformed SPARQL"),
        @ApiResponse(responseCode = "500", description = "Fatal error") })
    public abstract Response postSkill(
            @Parameter(in = ParameterIn.DEFAULT, description = "The body either contains the parameterized query" ,required=true)
            String body,
            @Parameter(in = ParameterIn.QUERY, description = "The Target Asset of the Query (targets the complete dataspace if empty)",required=true)
            @QueryParam("asset") String asset)
    throws NotFoundException;

}

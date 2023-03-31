//
// Conforming Agent Implementation
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.conforming;

import io.catenax.knowledge.agents.conforming.api.AgentApi;

import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicReference;

import io.catenax.knowledge.agents.conforming.api.NotFoundException;

import javax.ws.rs.core.*;
import javax.validation.constraints.*;

public class ConformingAgent extends AgentApi {

    public static String emptyJson="{\n" +
            "    \"head\": {\n" +
            "        \"vars\": [\n" +
            "        ]\n" +
            "    },\n" +
            "    \"results\": {\n" +
            "        \"bindings\": [\n" +
            "        ]\n" +
            "    }\n" +
            "}";

    public static String simpleJson="{\n" +
            "    \"head\": {\n" +
            "        \"vars\": [\n" +
            "            \"subject\",\n" +
            "            \"predicate\",\n" +
            "            \"object\"\n" +
            "        ]\n" +
            "    },\n" +
            "    \"results\": {\n" +
            "        \"bindings\": [\n" +
            "            {\n" +
            "                \"subject\": {\n" +
            "                    \"type\": \"uri\",\n" +
            "                    \"value\": \"urn:cx:AnonymousSerializedPart#GB4711\"\n" +
            "                },\n" +
            "                \"predicate\": {\n" +
            "                    \"type\": \"uri\",\n" +
            "                    \"value\": \"https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#hasPartType\"\n" +
            "                },\n" +
            "                \"object\": {\n" +
            "                    \"type\": \"literal\",\n" +
            "                    \"value\": \"engine control module\",\n" +
            "                    \"datatype\": \"http://www.w3.org/2001/XMLSchema#string\",\n" +
            "                    \"xml:lang\": \"http://www.w3.org/2001/XMLSchema#string\"\n" +
            "                }\n" +
            "            }\n" +
            "        ]\n" +
            "    }\n" +
            "}";

    public static String emptyXml="<?xml version=\"1.0\"?>\n" +
            "<sparql xmlns=\"http://www.w3.org/2005/sparql-results#\">\n" +
            "    <head>\n" +
            "    </head>\n" +
            "    <results>\n" +
            "    </results>\n" +
            "</sparql>";

    public static String simpleXml="<?xml version=\"1.0\"?>\n" +
            "<sparql xmlns=\"http://www.w3.org/2005/sparql-results#\">\n" +
            "    <head>\n" +
            "        <variable name=\"subject\"/>\n" +
            "        <variable name=\"predicate\"/>\n" +
            "        <variable name=\"object\"/>\n" +
            "    </head>\n" +
            "    <results>\n" +
            "        <result>\n" +
            "            <binding name=\"subject\">\n" +
            "                <uri>urn:cx:AnonymousSerializedPart#GB4711</uri>\n" +
            "            </binding>\n" +
            "            <binding name=\"predicate\">\n" +
            "                <uri>https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#hasPartType</uri>\n" +
            "            </binding>\n" +
            "            <binding name=\"object\">\n" +
            "                <literal xml:lang=\"en\" datatype=\"http://www.w3.org/2001/XMLSchema#string\">engine control module</literal>\n" +
            "            </binding>\n" +
            "        </result>\n" +
            "    </results>\n" +
            "</sparql>";
    public static MediaType srj = MediaType.valueOf("application/sparql-results+json");
    public static MediaType srx = MediaType.valueOf("application/sparql-results+xml");
    public static MediaType sq = MediaType.valueOf("application/sparql-query");

    public boolean useSimple=true;
    public int status=200;
    public String warnings = "[]";

    protected MediaType getDefaultResultType() {
        if(headers.getHeaderString("Accept")!=null) {
            String[] compartments = headers.getHeaderString("Accept").split(",");
            for (String compartment : compartments) {
                String[] qualifiers = compartment.split(";");
                try {
                    MediaType wantedEncoding = MediaType.valueOf(qualifiers[0]);
                    if (wantedEncoding.isCompatible(srj)) {
                        return srj;
                    } else if (wantedEncoding.isCompatible(srx)) {
                        return srx;
                    }
                } catch(IllegalArgumentException iae) {
                }
            }
            return null;
        }
        return srj;
    }

    /** produces a standard response */
    protected Map<String,byte[]> computeBody(MediaType resultType) {
        String target;
        if(useSimple) {
            if(resultType.isCompatible(srj)) {
                target=simpleJson;
            } else {
                target=simpleXml;
            }
        } else {
            if(resultType.isCompatible(srj)) {
                target=emptyJson;
            } else {
                target=emptyXml;
            }
        }
        return Map.of(resultType.toString(),target.getBytes());
    }

    /** produces a standard response */
    protected Response.ResponseBuilder compute(MediaType resultType) {
        AtomicReference<Response.ResponseBuilder> response= new AtomicReference<>(Response.status(status));
        Map<String,byte[]> body=computeBody(resultType);
        body.entrySet().forEach( result -> {
                    response.set(response.get().type(result.getKey()).entity(result.getValue()));
                });
        return response.get();
    }

    protected Response annotate(Response.ResponseBuilder builder) {
        return builder.header("cx_warnings",warnings).build();
    }

    @Override
    public Response getAgent(String asset, String queryLn, String query, String _vin, List<String> troubleCode) throws NotFoundException {
        MediaType resultType=getDefaultResultType();
        if(resultType==null) {
            return annotate(Response.status(400,"KA-BIND/KA-MATCH: Only supports application/sparql-results+json|xml compatible Accept header"));
        }
        return annotate(compute(resultType));
    }

    @Override
    public Response postAgent(Object body, String asset,  String queryLn, String query, String _vin,  List<String> troubleCode) throws NotFoundException {
        MediaType resultType=getDefaultResultType();
        if(resultType==null) {
            return annotate(Response.status(400,"KA-BIND/KA-MATCH: Only supports application/sparql-results+json|xml compatible Accept header"));
        }
        MediaType bodyType=MediaType.valueOf(headers.getHeaderString("Content-Type"));
        if(!bodyType.isCompatible(sq) && !bodyType.isCompatible(srj) && !bodyType.isCompatible(srx)) {
            return annotate(Response.status(400,"KA-BIND/KA-MATCH postAgent only accepts application/sparql-query|results+json|xml in body."));
        }
        return annotate(compute(resultType));
    }

    @Override
    public Response postSkill(String body,  @NotNull String asset) throws NotFoundException {
        MediaType bodyType=MediaType.valueOf(headers.getHeaderString("Content-Type"));
        if(!bodyType.isCompatible(sq)) {
            return Response.status(400,"KA-BIND/KA-MATCH postSkill only accepts application/sparql-query|results+json|xml in body.").build();
        }
        return Response.ok().build();
    }
}

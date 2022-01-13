/*
 * Copyright (c) 2021-2022 T-Systems International GmbH (Catena-X Consortium)
 *
 * See the AUTHORS file(s) distributed with this work for additional
 * information regarding authorship.
 *
 * See the LICENSE file(s) distributed with this work for
 * additional information regarding license terms.
 */
package net.catenax.semantics.triples;

import jakarta.ws.rs.core.HttpHeaders;
import net.catenax.semantics.LoggerMonitor;
import net.catenax.semantics.connector.TripleDataPlaneExtension;
import okhttp3.*;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;

import java.io.File;
import java.io.IOException;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * A helper class to deal with parsing/evaluating/delegating Sparql and Turtle Queries to
 * internal services.
 */
public class SparqlHelper {

    /**
     * Media Types
     */
    public final static okhttp3.MediaType SPARQL_QUERY_MEDIATYPE = okhttp3.MediaType.parse("application/sparql-query");
    public final static okhttp3.MediaType TURTLE_MEDIATYPE = okhttp3.MediaType.parse("text/turtle");

    /**
     * three different sparql commands
     */
    public static enum SparqlCommand {
        INSERT,
        DELETE,
        SELECT
    }

    /**
     * a regular expression to extract the command of the query
     */
    protected final static Pattern COMMAND_PATTERN=Pattern.compile("(?<Command>SELECT|INSERT|DELETE)[^;]*WHERE\\s*\\{[^;]*\\}");

    /**
     * a regular expression to extract the (graph, service, logic) contexts
     * out of a sparql query
     */
    protected final static Pattern CONTEXT_PATTERN=Pattern.compile("(?<Open>(?<Context>(?<Type>GRAPH|SERVICE|FROM|INTO)\\s*\\<(?<Urn>[^\\>]+)\\>)?\\s*\\{)|(?<Close>\\})");

    /**
     * logging facility
     */
    protected final Monitor monitor;


    /**
     * we got an http client to call out
     */
    protected final OkHttpClient httpClient;


    /**
     * create a new SparQL Helper in the runtime
     * @param monitor the actual runtime monitor interface
     */
    public SparqlHelper(Monitor monitor) {
        this.monitor=monitor;
        //  TODO do we need to manipulate the call timeout?
        this.httpClient= new OkHttpClient.Builder().build();
    }

    /**
     * create a new SparQL Helper for test purposes
     * use a default monitor/logger
     */
    public SparqlHelper() {
        this(new LoggerMonitor());
    }

    /**
     * analyse query command inside a given graph
     * @param query the SparQL query
     * @return detected command
     */
    public SparqlCommand analyseCommand(String query) {
        Matcher matcher=COMMAND_PATTERN.matcher(query);
        if(!matcher.find()) {
            return null;
        } else {
            return SparqlCommand.valueOf(matcher.group(1));
        }
    }

    /**
     * analyse query context inside a given graph
     * @param graph target graph of the query
     * @param query the SparQL query
     * @return a set of graphs which build the (joined) contexts of the query, we do not account graphs in remote services to these.
     */
    public Set<String> analyseContext(String graph, String query) {

        int depth=0;
        Set<String> context=new java.util.HashSet<String>();
        context.add(graph);
        int serviceDepth=-1;

        monitor.debug(String.format("Analysing the query starting with context %s at depth %d",String.join(";",context),depth));

        // Analysing the query
        Matcher matcher=CONTEXT_PATTERN.matcher(query);
        while(matcher.find()) {
            //monitor.info(matcher.group(0));
            if(matcher.group(1)!=null) {

                String newContext=matcher.group(2);

                // check whether we enter a new service context
                if(newContext!=null && serviceDepth<0) {
                    String type=matcher.group(3);
                    // maybe an explicit service annotation
                    if("SERVICE".equals(type)) {
                        serviceDepth=depth;
                    } else {
                        String target=matcher.group(4);
                        // or an implicit from/into clause where the IRI is a remote protocol
                        if(("FROM".equals(type) || "INTO".equals(type)) && target.startsWith("http")) {
                            serviceDepth=depth;
                        } else {
                            // otherwise this annotation should be a graph which we add
                            context.add(target);
                        }
                    }
                }
                depth++;
            } else if(matcher.group(5)!=null) {
                if(depth<=0) {
                    throw new RuntimeException("Too much closing parentheses.");
                }
                depth--;
                if(depth==serviceDepth) {
                    serviceDepth=-1;
                }
            } else {
                throw new RuntimeException("Regular expression problem.");
            }
            monitor.debug(String.format("Iterated at %d-%d to context %s at depth %d",matcher.start(),matcher.end(),String.join(";",context),depth));
        }

        if(depth!=0) {
            throw new RuntimeException("Too much opening parentheses.");
        }
        return context;
    }

    /**
     * perform a (synchronous) query against a given endpoint
     * @param endpoint uri of the internal service (may contain a graph as a parameter)
     * @param query a valid sparql query (TODO should be checked to avoid injection attacks)
     * @param correlationId associated message/request id of the calling context to be forwarded by the engine in case of federation
     * @param issuer calling connector context that is to be forwarded by the engine in case of federation
     * @param agreementToken token that is to be forwarded by the engine in case of federation
     * @param accepts response media type (_/xml or _/json)
     * @return response body as a (xml|json) string if successful
     * @throws IOException if unsuccessful
     */
    public String performQuery(String endpoint, String query, String correlationId, String issuer, String agreementToken, String accepts) throws IOException {
        RequestBody formBody = RequestBody.create(query,SPARQL_QUERY_MEDIATYPE);

        Request request = new Request.Builder()
                .url(endpoint)
                .addHeader(TripleDataPlaneExtension.CORRELATION_HEADER,correlationId)
                .addHeader(TripleDataPlaneExtension.CONNECTOR_HEADER,issuer)
                .addHeader(TripleDataPlaneExtension.AGREEMENT_HEADER,agreementToken)
                .addHeader(HttpHeaders.ACCEPT,accepts)
                .post(formBody)
                .build();

        try(Response response = httpClient.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new IOException(String.format("Sparql query failed. Got an unsuccessful response status %d", response.code()));
            }
            // Get response body
            String responseBody = response.body().string();
            return responseBody;
        } finally {
        }
    }

    /**
     * perform a (synchronous) upload against a given endpoint
     * @param endpoint uri of the internal service
     * @param graph name of the target graph
     * @param turtle the turtle file (TODO should be checked to avoid injection attacks)
     * @param correlationId  associated message/request id of the calling context to be forwarded by the engine in case of federation
     * @param issuer calling connector context that is to be forwarded by the engine in case of federation
     * @param agreementToken token that is to be forwarded by the engine in case of federation
     * @return response body as (html) string if successful
     * @throws IOException if unsuccessful
     */
    public String uploadTurtle(String endpoint, String graph, File turtle, String correlationId, String issuer, String agreementToken) throws IOException {
        RequestBody formBody = new MultipartBody.Builder().setType(MultipartBody.FORM)
                .addFormDataPart("file", turtle.getName(), RequestBody.create(TURTLE_MEDIATYPE, turtle))
                .addFormDataPart("graph",graph)
                .build();

        Request request = new Request.Builder()
                .url(endpoint)
                .addHeader(TripleDataPlaneExtension.CORRELATION_HEADER,correlationId)
                .addHeader(TripleDataPlaneExtension.CONNECTOR_HEADER,issuer)
                .addHeader(TripleDataPlaneExtension.AGREEMENT_HEADER,agreementToken)
                .post(formBody)
                .build();

        try (Response response = httpClient.newCall(request).execute()) {

            if (!response.isSuccessful())
                throw new IOException(String.format("Turtle upload failed. Got an unsuccessful response status %d", response.code()));

            // Get response body
            String responseBody = response.body().string();
            return responseBody;
        } finally {
        }
    }

    /**
     * run context analysis of a sample query, output and assert the result
     * @param args command line args are ignored
     */
    public static void main(String[] args) {
        Set<String> ref=new SparqlHelper().analyseContext("urn:x-arq:DefaultGraph","PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>\n" +
                "PREFIX bamm: <urn:bamm:io.openmanufacturing:meta-model:1.0.0#>\n" +
                "\n" +
                "SELECT ?aspect\n" +
                "WHERE {\n" +
                "    {\n" +
                "        SERVICE <http://localhost:8182/api/sparql/hub> { \n" +
                "            {?aspect rdf:type bamm:Aspect .}\n" +
                "    UNION\n" +
                "    {\n" +
                "        GRAPH <urn:tenant1:PrivateGraph> { \n" +
                "            ?aspect rdf:type bamm:Aspect .\n" +
                "        }\n" +
                "    }\n" +
                "        }\n" +
                "    }\n" +
                "    UNION\n" +
                "    {\n" +
                "        SERVICE <http://localhost:8183/api/sparql/hub> { \n" +
                "            {?aspect rdf:type bamm:Aspect .}\n" +
                "    UNION\n" +
                "    {\n" +
                "        GRAPH <urn:tenant2:PrivateGraph> { \n" +
                "            ?aspect rdf:type bamm:Aspect .\n" +
                "        }\n" +
                "    }\n" +
                "        }\n" +
                "    }\n" +
                "    UNION\n" +
                "    {\n" +
                "        GRAPH <urn:tenant1:PropagateGraph> { \n" +
                "            ?aspect rdf:type bamm:Aspect .\n" +
                "        }\n" +
                "    }\n" +
                "    UNION\n" +
                "    {\n" +
                "        GRAPH <urn:tenant2:PropagateGraph> { \n" +
                "            ?aspect rdf:type bamm:Aspect .\n" +
                "        }\n" +
                "    }\n" +
                "}\n" +
                "\n");
        System.out.println(String.join(";",ref));
        assert ref.contains("urn:x-arq:DefaultGraph");
        assert ref.contains("urn:tenant1:PropagateGraph");
        assert ref.contains("urn:tenant2:PropagateGraph");
        assert !ref.contains("http://localhost:8182/api/sparql/hub");
        assert !ref.contains("http://localhost:8183/api/sparql/hub");
        assert !ref.contains("urn:tenant1:PrivateGraph");
        assert !ref.contains("urn:tenant1:PrivateGraph");
    }

}

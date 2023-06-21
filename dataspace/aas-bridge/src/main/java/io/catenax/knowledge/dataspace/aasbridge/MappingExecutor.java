package io.catenax.knowledge.dataspace.aasbridge;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.google.common.base.Charsets;
import com.google.common.io.CharStreams;
import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import org.eclipse.digitaltwin.aas4j.exceptions.TransformationException;
import org.eclipse.digitaltwin.aas4j.mapping.model.MappingSpecification;
import org.eclipse.digitaltwin.aas4j.transform.GenericDocumentTransformer;

import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Executors;

import static java.time.temporal.ChronoUnit.SECONDS;

public class MappingExecutor {
    //Client config

    private final GenericDocumentTransformer transformer;
    private final URI providerSparqlEndpoint;

    private final String credentials;
    private final int timeoutSeconds;
    private final int fixedThreadPoolSize;


    public MappingExecutor(URI sparqlEndpoint, String credentials, int timeoutSeconds, int fixedThreadPoolSize) {
        this.transformer = new GenericDocumentTransformer();
        this.providerSparqlEndpoint = sparqlEndpoint;
        this.credentials = credentials;
        this.timeoutSeconds = timeoutSeconds;
        this.fixedThreadPoolSize = fixedThreadPoolSize;
    }

    public AssetAdministrationShellEnvironment executeMapping(String query, MappingSpecification mappingSpecification) {
        try {
            InputStream queryResult = executeQuery(query).get();
            transformer.execute(queryResult, mappingSpecification);


        } catch (URISyntaxException | InterruptedException | ExecutionException | IOException e) {
            throw new RuntimeException(e);
        } catch (TransformationException e) {
            throw new RuntimeException(e);
        }


        // execute query
        // parse, convert to xml
        // parse mapping
        // execute

        return null;
    }

    /**
     * @param queryResourcePath the relative path to the sparql query starting at the resources folder
     * @return xml structure of the query response
     * @throws URISyntaxException
     * @throws IOException
     */
    public CompletableFuture<InputStream> executeQuery(String queryResourcePath) throws URISyntaxException, IOException {
        InputStream stream = MappingExecutor.class.getResourceAsStream(queryResourcePath);
        if (stream != null) {
            try (InputStreamReader reader = new InputStreamReader(stream, Charsets.UTF_8)) {
                String query = CharStreams.toString(reader);
                HttpRequest.BodyPublisher bodyPublisher = HttpRequest.BodyPublishers.ofString(query);
                HttpRequest.Builder requestBuilder = HttpRequest.newBuilder().uri(providerSparqlEndpoint).POST(bodyPublisher).header("Content-Type", "application/sparql-query").header("Accept", "application/xml").timeout(Duration.of(timeoutSeconds, SECONDS));

                if (credentials != null && !credentials.isEmpty()) {
                    requestBuilder = requestBuilder.header("Authorization", credentials);
                }

                HttpRequest request = requestBuilder.build();

                return HttpClient.newBuilder().executor(Executors.newFixedThreadPool(fixedThreadPoolSize)).build().sendAsync(request, HttpResponse.BodyHandlers.ofString()).thenApply(res -> {
                    if (res.statusCode() >= 200 && res.statusCode() < 300) {
                        return res.body();
                    } else {
                        throw new RuntimeException("Sparql-Request failed with " + res.statusCode() + res.body());
                    }
                }).thenApply(body -> new ByteArrayInputStream(body.getBytes()));
            }
        } else {
            throw new RuntimeException("query resource stream is empty!");
        }

    }
}


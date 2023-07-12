package io.catenax.knowledge.dataspace.aasbridge;

import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import org.eclipse.digitaltwin.aas4j.exceptions.TransformationException;
import org.eclipse.digitaltwin.aas4j.mapping.model.MappingSpecification;
import org.eclipse.digitaltwin.aas4j.transform.GenericDocumentTransformer;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.time.Duration;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

import static java.time.temporal.ChronoUnit.SECONDS;

public class MappingExecutor {
    //Client config

    private final GenericDocumentTransformer transformer;
    private final URI sparqlEndpoint;

    private final String credentials;
    private final int timeoutSeconds;
    private final HttpClient client;

    private List<MappingConfiguration> mappings;

    public MappingExecutor(URI sparqlEndpoint, String credentials, int timeoutSeconds, int fixedThreadPoolSize, List<MappingConfiguration> mappings) {
        this.mappings = mappings;
        this.transformer = new GenericDocumentTransformer();
        this.sparqlEndpoint = URI.create(sparqlEndpoint.toString());
        this.credentials = credentials;
        this.timeoutSeconds = timeoutSeconds;
        this.client = HttpClient.newBuilder().executor(Executors.newFixedThreadPool(fixedThreadPoolSize)).build();
    }

    /**
     * @return the resulting AAS Environment contains multiple AAS with a single submodel each.
     */
    public AssetAdministrationShellEnvironment executeGetAllMappings() {
        List<AssetAdministrationShellEnvironment> envs = mappings.stream()
                .map(m -> {
                    try {
                        return executeMapping(Files.readString(m.getGetAllQuery().toPath()), m.getMappingSpecification());
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                }).collect(Collectors.toList());

        return AasUtils.mergeAasEnvs(envs);
    }

    public AssetAdministrationShellEnvironment executeMapping(String query, MappingSpecification specification) {
        try {
            InputStream queryResult = executeQuery(query).get();
            return transformer.execute(queryResult, specification);
        } catch (URISyntaxException | InterruptedException | ExecutionException | IOException |
                 TransformationException ex) {
            throw new RuntimeException(ex);
        }
    }

    public List<MappingConfiguration> getMappings() {
        return mappings;
    }

    /**
     * @param query the string containing the (if necessary parametrized) query, probably loaded from resources
     * @return xml structure of the query response
     * @throws URISyntaxException
     * @throws IOException
     */
    CompletableFuture<InputStream> executeQuery(String query) throws URISyntaxException, IOException {

        HttpRequest.BodyPublisher bodyPublisher = HttpRequest.BodyPublishers.ofString(query);
        HttpRequest.Builder requestBuilder = HttpRequest.newBuilder()
                .uri(sparqlEndpoint)
                .POST(bodyPublisher)
                .header("Content-Type", "application/sparql-query")
                .header("Accept", "application/xml")
                .timeout(Duration.of(timeoutSeconds, SECONDS));

        if (credentials != null && !credentials.isEmpty()) {
            requestBuilder = requestBuilder.header("Authorization", credentials);
        }

        HttpRequest request = requestBuilder.build();

        return client.sendAsync(request, HttpResponse.BodyHandlers.ofString()).thenApply(res -> {
            if (res.statusCode() >= 200 && res.statusCode() < 300) {
                return res.body();
            } else {
                throw new RuntimeException("Sparql-Request failed with " + res.statusCode() + res.body());
            }
        }).thenApply(body -> new ByteArrayInputStream(body.getBytes()));
    }


}



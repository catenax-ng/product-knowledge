package io.catenax.knowledge.dataspace.aasbridge;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.google.common.base.Charsets;
import com.google.common.io.CharStreams;
import com.sun.xml.bind.v2.util.QNameMap;
import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import org.eclipse.digitaltwin.aas4j.exceptions.TransformationException;
import org.eclipse.digitaltwin.aas4j.mapping.MappingSpecificationParser;
import org.eclipse.digitaltwin.aas4j.mapping.model.MappingSpecification;
import org.eclipse.digitaltwin.aas4j.transform.GenericDocumentTransformer;

import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Duration;
import java.util.AbstractMap;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

import static java.time.temporal.ChronoUnit.SECONDS;

public class MappingExecutor {
    //Client config

    private final GenericDocumentTransformer transformer;
    private final URI providerSparqlEndpoint;

    private final String credentials;
    private final int timeoutSeconds;
    private final int fixedThreadPoolSize;

    private Map<File, MappingSpecification> queryMappingAssignment;


    public MappingExecutor(URI sparqlEndpoint, String credentials, int timeoutSeconds, int fixedThreadPoolSize) {
        this.queryMappingAssignment = getMappingsFromResources();

        this.transformer = new GenericDocumentTransformer();
        this.providerSparqlEndpoint = sparqlEndpoint;
        this.credentials = credentials;
        this.timeoutSeconds = timeoutSeconds;
        this.fixedThreadPoolSize = fixedThreadPoolSize;



    }

    private Map<File, MappingSpecification> getMappingsFromResources() {
        try {
            return Files.walk(Path.of("src/main/resources/selectQueries/"))
                    .filter(obj -> !obj.endsWith("selectQueries"))
                    .map(obj -> {
                        String mappingFileFolder = obj.getParent().getParent().toString() + "/mappingSpecifications/";
                        String mappingFileName = obj.getFileName().toString().split("-")[0] + "-mapping.json";
                        try {
                            MappingSpecification spec =
                                    new MappingSpecificationParser().loadMappingSpecification(mappingFileFolder+mappingFileName);
                            return new AbstractMap.SimpleEntry<>(obj, spec);
                        } catch (IOException e) {
                            throw new RuntimeException(e);
                        }
                    })
                    .collect(Collectors.toMap(e -> e.getKey().toFile(), e -> e.getValue()));

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * @param queryFile    file holding the respective sparql-query
     * @param mappingSpecification mapping specification to apply a query result to a submodel template
     * @return the resulting AAS Environment contains multiple AAS with a single submodel each.
     */
    public AssetAdministrationShellEnvironment executeMapping(File queryFile, MappingSpecification mappingSpecification) {
        try {
            InputStream queryResult = executeQuery(queryFile).get();
            transformer.execute(queryResult, mappingSpecification);

        } catch (URISyntaxException | InterruptedException | ExecutionException | IOException |
                 TransformationException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    /**
     * @param queryFile the file containing the query, probably loaded from resources
     * @return xml structure of the query response
     * @throws URISyntaxException
     * @throws IOException
     */
    public CompletableFuture<InputStream> executeQuery(File queryFile) throws URISyntaxException, IOException {
        String query = Files.readAllLines(queryFile.toPath()).get(0);

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

}



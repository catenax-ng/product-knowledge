package io.catenax.knowledge.dataspace.aasbridge;

import de.fraunhofer.iosb.ilt.faaast.service.model.asset.AssetIdentification;
import de.fraunhofer.iosb.ilt.faaast.service.model.asset.GlobalAssetIdentification;
import de.fraunhofer.iosb.ilt.faaast.service.model.asset.SpecificAssetIdentification;
import io.adminshell.aas.v3.model.*;
import org.eclipse.digitaltwin.aas4j.exceptions.TransformationException;
import org.eclipse.digitaltwin.aas4j.mapping.model.MappingSpecification;
import org.eclipse.digitaltwin.aas4j.transform.GenericDocumentTransformer;
import org.eclipse.rdf4j.query.resultio.helpers.QueryResultCollector;
import org.eclipse.rdf4j.query.resultio.sparqlxml.SPARQLResultsXMLParser;

import java.io.ByteArrayInputStream;
import java.io.File;
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
import java.util.Objects;
import java.util.Set;
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
        Set<AssetAdministrationShellEnvironment> envs = mappings.stream()
                .map(m -> {
                    try {
                        return executeMapping(Files.readString(m.getGetAllQuery().toPath()), m.getMappingSpecification());
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                }).collect(Collectors.toSet());

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

    /**
     * @param query the string containing the (if necessary parametrized) query, probably loaded from resources
     * @return xml structure of the query response
     * @throws URISyntaxException
     * @throws IOException
     */
    protected CompletableFuture<InputStream> executeQuery(String query) throws URISyntaxException, IOException {

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


    public Identifiable queryIdentifiableById(Identifier identifier, Class<? extends Identifiable> type) {
        if (type.isAssignableFrom(Submodel.class)) {
            String submodelSemanticId = identifier.getIdentifier().split("/")[0];
            MappingConfiguration mapping = mappings.stream()
                    .filter(m -> m.getSemanticId().equals(submodelSemanticId))
                    .findFirst().orElseThrow();
            String parametrized = parametrizeQuery(mapping.getGetOneQueryTemplate(), identifier.getIdentifier().split("/")[1]);
            return executeMapping(parametrized, mapping.getMappingSpecification())
                    .getSubmodels()
                    .get(0); //should only be one
            // maybe separate by cd, sm, aas later
        } else if (type.isAssignableFrom(AssetAdministrationShell.class)) {

            // check for existence of submodels
            // create new AAS maybe (maybe even here)
        } else if (type.isAssignableFrom(ConceptDescription.class)) {
            // execute all conceptDescriptionMappings on startup
            // keep in memory, never update, just query
        } else {
            throw new RuntimeException(String.format("Identifiable %s is neither AAS, Submodel or CD", identifier.getIdentifier()));
        }

        return null;
    }


    // may return an aas with assetId global even when queried as specific
    public List<AssetAdministrationShell> queryAllShells(String idShort, List<AssetIdentification> assetIds) throws InterruptedException {
        String candidates = assetIds.stream().map(id -> {
                    if (id.getClass().isAssignableFrom(GlobalAssetIdentification.class)) {
                        GlobalAssetIdentification gaid = (GlobalAssetIdentification) id;
                        return gaid.getReference().getKeys().get(0).getValue();
                    } else if (id.getClass().isAssignableFrom(SpecificAssetIdentification.class)) {
                        SpecificAssetIdentification said = (SpecificAssetIdentification) id;
                        return said.getValue();
                    } else {
                        throw new IllegalArgumentException("can't fetch AAS since id is neither global nor specific");
                    }
                })
                .reduce("", (first, second) -> first + "<" + second + "> ");

        Set<AssetAdministrationShellEnvironment> envsWithRespectiveAssetId = mappings.parallelStream()
                .map(m -> {
                    File template = m.getGetOneQueryTemplate();
                    String query = parametrizeQuery(template, candidates);
                    try {
                        InputStream in = executeQuery(query).get();
                        String result = new String(in.readAllBytes());
                        if (queryResultEmpty(result)) {
                            return null;
                        }
                        return transformer.execute(new ByteArrayInputStream(result.getBytes()), m.getMappingSpecification());
                    } catch (URISyntaxException | IOException | ExecutionException | InterruptedException |
                             TransformationException e) {
                        throw new RuntimeException(e);
                    }
                })
                .filter(Objects::nonNull)
                .filter(env->env.getAssetAdministrationShells().get(0).getIdShort().equals(idShort)) // assuming only 1 AAS per env
                .collect(Collectors.toSet());

        return envsWithRespectiveAssetId.stream()
                .flatMap(env->env.getAssetAdministrationShells().stream())
                .collect(Collectors.toList());




        /*
        SPARQLResultsXMLParser parser = new SPARQLResultsXMLParser();
        QueryResultCollector handler = new QueryResultCollector();
        parser.setTupleQueryResultHandler(handler);
        List<BindingSet> results = candidateIds.parallelStream()
                .flatMap(id ->
                        mappings.stream()
                                .map(MappingConfiguration::getGetOneQueryTemplate)
                                .map(t -> parametrizeQuery(t, id))
                                .map(p -> {
                                    try {
                                        return executeQuery(p);
                                    } catch (URISyntaxException e) {
                                        throw new RuntimeException(e);
                                    } catch (IOException e) {
                                        throw new RuntimeException(e);
                                    }
                                })
                )
                .flatMap(f -> {
                    try {
                        parser.parseQueryResult(f.get());
                        return handler.getBindingSets().stream();
                    } catch (IOException | InterruptedException | ExecutionException e) {
                        throw new RuntimeException(e);
                    }
                })
                .filter(bs -> !bs.isEmpty())
                // transform only where results found
                // merge envs by globalassetid
                .collect(Collectors.toList());
        if (results.isEmpty()) {
            throw new ResourceNotFoundException("no resource found matching any of the supplied ids AND idShort " + idShort);
        }
        else {
            SPARQLResultsXMLWriter writer = new SPARQLResultsXMLWriter();
            results.stream()
                    .map(r->)
            return transformer.execute()
        }
        // filter matching for idshort if present
        // get AAS
         */
    }

    private boolean queryResultEmpty(String result) {
        SPARQLResultsXMLParser parser = new SPARQLResultsXMLParser();
        QueryResultCollector handler = new QueryResultCollector();
        parser.setTupleQueryResultHandler(handler);
        try{
            parser.parseQueryResult(new ByteArrayInputStream(result.getBytes()));
            return handler.getBindingSets().isEmpty();
        } catch (IOException e) {
            throw new RuntimeException("Couldn't parse the query result provided",e);
        }
    }


    public List<Submodel> queryAllSubmodels(String idShort, Reference semanticId) {
        if (semanticId == null) {
            return executeGetAllMappings().getSubmodels();
        } else {

            MappingConfiguration mappingConfiguration = mappings.stream()
                    .filter(m -> m.getSemanticId().equals(semanticId.getKeys().get(0).getValue()))
                    .findFirst().orElseThrow();
            try {
                String query = Files.readString(mappingConfiguration.getGetAllQuery().toPath());
                return executeMapping(query, mappingConfiguration.getMappingSpecification())
                        .getSubmodels();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            // maybe remove the conceptdescriptions and aas-part from mappings

        }
    }

    private String parametrizeQuery(File queryTemplate, String parameter) {
        try {
            return String.format(Files.readString(queryTemplate.toPath()), parameter);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
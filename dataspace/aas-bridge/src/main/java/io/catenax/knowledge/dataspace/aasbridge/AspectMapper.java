//
// Knowledge Agent AAS Bridge
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.aasbridge;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.base.Charsets;
import com.google.common.io.CharStreams;
import io.adminshell.aas.v3.dataformat.DeserializationException;
import io.adminshell.aas.v3.dataformat.xml.XmlDeserializer;
import io.adminshell.aas.v3.model.*;
import io.adminshell.aas.v3.model.impl.*;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import static java.time.temporal.ChronoUnit.SECONDS;

/**
 * Base class for all submodel mapping lggic
 */
public abstract class AspectMapper {
    protected final String providerSparqlEndpoint;
    protected final AssetAdministrationShellEnvironment aasTemplate;

    public AssetAdministrationShellEnvironment getAasInstances() {
        return aasInstances;
    }

    protected AssetAdministrationShellEnvironment aasInstances;
    protected final HttpClient client;
    protected final long timeoutSeconds;
    private final String credentials;

    public AspectMapper(String providerSparqlEndpoint, String aasResourcePath, String credentials, HttpClient client, long timeOutSeconds) throws IOException, DeserializationException {
        this.providerSparqlEndpoint = providerSparqlEndpoint;
        this.client = client;
        this.credentials = credentials;
        this.timeoutSeconds = timeOutSeconds;

        try(InputStream stream = AspectMapper.class.getResourceAsStream(aasResourcePath))
        {
            if(stream!=null) {
                try (InputStreamReader reader = new InputStreamReader(stream, Charsets.UTF_8)) {
                    String aasTemplate = CharStreams.toString(reader);
                    this.aasTemplate = new XmlDeserializer().read(aasTemplate);
                }
            } else {
                this.aasTemplate = null;
            }
        }
    }

    public CompletableFuture<ArrayNode> executeQuery(String queryResourcePath) throws URISyntaxException, IOException {
        try(InputStream stream = AspectMapper.class.getResourceAsStream(queryResourcePath)) {
            if(stream!=null) {
                try (InputStreamReader reader = new InputStreamReader(stream, Charsets.UTF_8)) {
                    String query = CharStreams.toString(reader);
                    HttpRequest.BodyPublisher bodyPublisher = HttpRequest.BodyPublishers.ofString(query);
                    HttpRequest.Builder requestBuilder = HttpRequest.newBuilder()
                            .uri(new URI(providerSparqlEndpoint))
                            .POST(bodyPublisher)
                            .header("Content-Type", "application/sparql-query")
                            .header("Accept", "application/json")
                            .timeout(Duration.of(timeoutSeconds, SECONDS));

                    if (credentials != null && !credentials.isEmpty()) {
                        requestBuilder = requestBuilder.header("Authorization", credentials);
                    }

                    HttpRequest request = requestBuilder.build();

                    return client
                            .sendAsync(request, HttpResponse.BodyHandlers.ofString())
                            .thenApply(res -> {
                                if (res.statusCode() >= 200 && res.statusCode() < 300) {
                                    return res.body();
                                } else {
                                    throw new RuntimeException("Sparql-Request failed with " + res.statusCode() + res.body());
                                }
                            })
                            .thenApply(body -> {
                                try {
                                    return new ObjectMapper().readValue(body, ArrayNode.class);
                                } catch (JsonProcessingException e) {
                                    throw new RuntimeException("No proper json response string!" + e);
                                }
                            });
                }
            } else {
                return CompletableFuture.completedFuture(null);
            }

        }
    }

    public static String getRandomIRI() {
        return "urn:uuid:"+UUID.randomUUID();
    }

    protected AssetAdministrationShellEnvironment instantiateAas() {
        AssetAdministrationShellEnvironment clone = AasUtils.cloneAasEnv(aasTemplate);
        Submodel smClone = AasUtils.cloneReferable(aasTemplate.getSubmodels().get(0), Submodel.class);
        smClone.setKind(ModelingKind.INSTANCE);
        String smId=getRandomIRI();
        smClone.setIdentification(new DefaultIdentifier.Builder()
                .idType(IdentifierType.IRI)
                .identifier(smId)
                .build());

        clone.setAssets(new ArrayList<>());
        clone.setSubmodels(new ArrayList<>(List.of(
                smClone
        )));
        String aasId=getRandomIRI();
        String aasIdShort= Base64.getEncoder().encodeToString(aasId.getBytes());
        clone.setAssetAdministrationShells(new ArrayList<>(List.of(
                new DefaultAssetAdministrationShell.Builder()
                        .identification(new DefaultIdentifier.Builder()
                                .idType(IdentifierType.IRI)
                                .identifier(aasId)
                                .build())
                        .idShort(aasIdShort)
                        .submodels(clone.getSubmodels().stream().map(sm->
                            new DefaultReference.Builder()
                                    .key(new DefaultKey.Builder()
                                            .type(KeyElements.SUBMODEL)
                                            .idType(KeyType.IRI)
                                            .value(smId)
                                            .build())
                                    .build()
                        ).collect(Collectors.toList()))
                        .build()
        )));
        return clone;
    }

    protected String getValueByMatch(Property property, ObjectNode queryResponse) {
        String idShort = property.getIdShort();
        return StreamSupport.stream(Spliterators.spliteratorUnknownSize(queryResponse.fields(), 0), false)
                .filter(e -> e.getKey().equals(idShort)).findFirst()
                .orElseThrow(() -> new RuntimeException("no json key found for idShort " + idShort))
                .getValue().asText();
    }

    protected String getValueByKey(ObjectNode queryResponse, String responseKey) {
        return queryResponse.get(responseKey).asText();
    }

    protected void setProperty(SubmodelElementCollection smec, String propertyIdShort, String value) {
        smec.getValues()
                .stream().filter(sme -> sme.getClass().equals(DefaultProperty.class)).map(sme -> (Property) sme).filter(p -> p.getIdShort().equals(propertyIdShort))
                .findFirst().orElseThrow(() -> new RuntimeException("could not find property " + propertyIdShort + " in SMEC " + smec.getIdShort()))
                .setValue(value);
    }

    protected void setProperty(Submodel sm, String propertyIdShort, String value) {
        sm.getSubmodelElements()
                .stream().map(sme -> (Property) sme).filter(sme -> sme.getIdShort().equals(propertyIdShort))
                .findFirst().orElseThrow(() -> new RuntimeException("could not find property " + propertyIdShort + " in SM " + sm.getIdShort()))
                .setValue(value);
    }

    protected void setGlobalAssetId(AssetAdministrationShell aas, ObjectNode queryResponse, String globalAssetIdKey) {
        aas.setAssetInformation(new DefaultAssetInformation.Builder()
                .globalAssetId(new DefaultReference.Builder()
                        .key(new DefaultKey.Builder()
                                .type(KeyElements.ASSET)
                                .idType(KeyType.CUSTOM)
                                .value(queryResponse.get(globalAssetIdKey).asText())
                                .build())
                        .build())
                .build());
    }



}


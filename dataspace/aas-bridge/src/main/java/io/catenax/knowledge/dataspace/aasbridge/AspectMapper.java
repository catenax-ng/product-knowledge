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
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Spliterators;
import java.util.UUID;
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
        String aasTemplate = CharStreams.toString(new InputStreamReader(AspectMapper.class.getResourceAsStream(aasResourcePath), Charsets.UTF_8));
        this.providerSparqlEndpoint = providerSparqlEndpoint;
        this.aasTemplate = new XmlDeserializer().read(aasTemplate);
        this.client = client;
        this.credentials = credentials;
        this.timeoutSeconds = timeOutSeconds;
    }

    public CompletableFuture<ArrayNode> executeQuery(String queryResourcePath) throws URISyntaxException, IOException {
        String query = CharStreams.toString(new InputStreamReader(AspectMapper.class.getResourceAsStream(queryResourcePath), Charsets.UTF_8));
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

    protected AssetAdministrationShellEnvironment instantiateAas() {
        AssetAdministrationShellEnvironment clone = AasUtils.cloneAasEnv(aasTemplate);
        Submodel smClone = AasUtils.cloneReferable(aasTemplate.getSubmodels().get(0), Submodel.class);
        smClone.setKind(ModelingKind.INSTANCE);
        smClone.setIdentification(new DefaultIdentifier.Builder()
                .idType(IdentifierType.CUSTOM)
                .identifier(UUID.randomUUID().toString())
                .build());

        clone.setAssets(new ArrayList<>());
        clone.setSubmodels(new ArrayList<>(List.of(
                smClone
        )));
        clone.setAssetAdministrationShells(new ArrayList<>(List.of(
                new DefaultAssetAdministrationShell.Builder()
                        .identification(new DefaultIdentifier.Builder()
                                .idType(IdentifierType.CUSTOM)
                                .identifier(UUID.randomUUID().toString())
                                .build())
                        .submodels(clone.getSubmodels().stream().map(sm->
                            new DefaultReference.Builder()
                                    .key(new DefaultKey.Builder()
                                            .type(KeyElements.SUBMODEL)
                                            .idType(KeyType.CUSTOM)
                                            .value(sm.getIdentification().getIdentifier())
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


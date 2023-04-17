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
import io.adminshell.aas.v3.dataformat.SerializationException;
import io.adminshell.aas.v3.dataformat.json.JsonDeserializer;
import io.adminshell.aas.v3.dataformat.json.JsonSerializer;
import io.adminshell.aas.v3.dataformat.xml.XmlDeserializer;
import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import io.adminshell.aas.v3.model.ModelingKind;
import io.adminshell.aas.v3.model.Property;
import io.adminshell.aas.v3.model.Referable;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Spliterators;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Executors;
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
        this.timeoutSeconds=timeOutSeconds;
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

        if(credentials!=null && !credentials.isEmpty()) {
           requestBuilder=requestBuilder.header("Authorization", credentials);
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


    protected AssetAdministrationShellEnvironment instantiateAas()
    {
        JsonSerializer jsonSerializer = new JsonSerializer();
        JsonDeserializer jsonDeserializer = new JsonDeserializer();

        AssetAdministrationShellEnvironment clone;
        try {
            clone = jsonDeserializer.read(jsonSerializer.write(aasTemplate));
        } catch (DeserializationException | SerializationException e) {
            throw new RuntimeException(e);
        }
        clone.setAssetAdministrationShells(new ArrayList<>());
        clone.setAssets(new ArrayList<>());
        clone.getSubmodels().forEach(smt -> smt.setKind(ModelingKind.INSTANCE));
        return clone;
    }


    protected <T extends Referable> T cloneReferable(T original, Class<T> clazz){
        JsonSerializer jsonSerializer = new JsonSerializer();
        JsonDeserializer jsonDeserializer = new JsonDeserializer();

        try {
            return jsonDeserializer.readReferable(jsonSerializer.write((Referable) original), clazz);
        } catch (DeserializationException | SerializationException e) {
            throw new RuntimeException(e);
        }
    }

    protected String findValueInProperty(Property property, ObjectNode queryResponse) {
        String idShort = property.getIdShort();
        return StreamSupport.stream(Spliterators.spliteratorUnknownSize(queryResponse.fields(),0),false)
                .filter(e->e.getKey().equals(idShort)).findFirst()
                .orElseThrow(()->new RuntimeException("no json key found for idShort " + idShort))
                .getValue().asText();
    }

    protected String findValueInProperty(ObjectNode queryResponse, String responseKey){
        return queryResponse.get(responseKey).asText();
    }

}


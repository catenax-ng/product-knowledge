package io.catenax.knowledge.dataspace.aasbridge;

import io.adminshell.aas.v3.dataformat.DeserializationException;
import io.adminshell.aas.v3.dataformat.xml.XmlDeserializer;
import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import io.adminshell.aas.v3.model.ModelingKind;
import io.adminshell.aas.v3.model.SubmodelElement;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Duration;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Executors;
import java.util.function.Predicate;

import static java.time.temporal.ChronoUnit.SECONDS;

public class AspectMapper {
    protected String providerSparqlEndpoint;
    protected AssetAdministrationShellEnvironment aasTemplate;
    protected HttpClient client;
    private String credentials = System.getenv("PROVIDER3_CREDENTIAL_BASIC");

    public AspectMapper(String providerSparqlEndpoint, Path aasPath) throws IOException, DeserializationException {
        this.providerSparqlEndpoint = providerSparqlEndpoint;
        this.aasTemplate = new XmlDeserializer().read(Files.readString(aasPath));
        this.client = HttpClient.newBuilder().executor(Executors.newFixedThreadPool(5)).build();
    }

    public AspectMapper(String providerSparqlEndpoint, AssetAdministrationShellEnvironment aasEnv) {
        this.providerSparqlEndpoint = providerSparqlEndpoint;
        this.aasTemplate = aasEnv;
    }

    public CompletableFuture<String> executeQuery(String query) throws URISyntaxException {
        HttpRequest.BodyPublisher bodyPublisher = HttpRequest.BodyPublishers.ofString(query);
        HttpRequest request = HttpRequest.newBuilder()
                .uri(new URI(providerSparqlEndpoint))
                .POST(bodyPublisher)
                .header("Content-Type", "application/sparql-query")
                .header("Accept", "application/json")
                .header("Authorization", credentials)
                .timeout(Duration.of(10, SECONDS))
                .build();

        return client
                .sendAsync(request, HttpResponse.BodyHandlers.ofString())
                .thenApply(res -> {
                    if(res.statusCode()==200){
                        return res.body();
                    }else{
                        throw new RuntimeException("Sparql-Request failed with " + res.statusCode());
                    }
                });
    }


    public AssetAdministrationShellEnvironment parametrizeAas(){
        aasTemplate.getSubmodels().forEach(smt -> smt.setKind(ModelingKind.INSTANCE));
        return aasTemplate;
    };


    public String getProviderSparqlEndpoint() {
        return providerSparqlEndpoint;
    }

    public AssetAdministrationShellEnvironment getAasTemplate() {
        return aasTemplate;
    }

    protected HttpClient getClient() {
        return this.client;
    }
}


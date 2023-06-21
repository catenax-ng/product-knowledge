package io.catenax.knowledge.dataspace.aasbridge;

import okhttp3.mockwebserver.MockResponse;
import okhttp3.mockwebserver.MockWebServer;
import org.jetbrains.annotations.NotNull;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.ExecutionException;

import static org.junit.jupiter.api.Assertions.assertEquals;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class MappingExecutorTest {

    private final String MOCK_URL = "/oem-edc-data/BPNL00000003COJN/api/agent" +
            "?OemProviderAgent=" +
            URLEncoder.encode("http://oem-provider-agent:8082/sparql", StandardCharsets.ISO_8859_1);

    void executeMapping() {

    }


    @ParameterizedTest
    @ValueSource(strings = {"MaterialForRecycling", "PartAsPlanned", "PartSiteInformation", "SingleLevelBomAsPlanned"})
    void executeQuery(String aspectName) throws IOException, URISyntaxException, ExecutionException, InterruptedException {
        MockWebServer mockWebServer = instantiateMockServer(aspectName);
        MappingExecutor executor = new MappingExecutor(
                new URI(mockWebServer.url(MOCK_URL).toString()),
                System.getProperty("PROVIDER_CREDENTIAL_BASIC"),
                3,
                5 );

        InputStream inputStream = executor.executeQuery("/selectQueries/select" + aspectName + ".rq").get();
        String result = new String(inputStream.readAllBytes());
        assertEquals(result, getMockResponseBody(aspectName));
    }

    private MockWebServer instantiateMockServer(String aspectName) throws IOException, URISyntaxException {
        MockWebServer mockServer = new MockWebServer();
        String mockResponseBody = getMockResponseBody(aspectName);
        MockResponse response = new MockResponse()
                .addHeader("Content-Type", "application/xml; charset=utf-8")
                .setBody(mockResponseBody)
                .setResponseCode(200);
        mockServer.url(MOCK_URL).toString();
        mockServer.enqueue(response);

        return mockServer;
    }

    private String getMockResponseBody(String aspectName) throws IOException {
        String mockResponseBody = new String(getClass().getClassLoader()
                .getResourceAsStream("sparqlResponseXml/"+ aspectName +"-sparql-results.xml")
                .readAllBytes());
        return mockResponseBody;
    }
}
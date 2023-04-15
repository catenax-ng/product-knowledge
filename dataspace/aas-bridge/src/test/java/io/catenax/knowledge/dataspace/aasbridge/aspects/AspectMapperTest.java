//
// Knowledge Agent AAS Bridge
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.aasbridge.aspects;

import okhttp3.mockwebserver.MockResponse;
import okhttp3.mockwebserver.MockWebServer;

import java.net.http.HttpClient;

/**
 * Base test class for all mapping logic based on a Sparql Mock
 */
public abstract class AspectMapperTest {

    protected MockWebServer mockWebServer;
    protected HttpClient client;
    protected String mockResponse="";

    protected long timeoutSeconds=10;

    public void instantiate() throws Exception {
        mockWebServer = new MockWebServer();
        client=HttpClient.newHttpClient();
        MockResponse response=new MockResponse()
                .addHeader("Content-Type", "application/json; charset=utf-8")
                .setBody(mockResponse)
                .setResponseCode(200);
        mockWebServer.enqueue(response);
        mockWebServer.enqueue(response);
    }
}

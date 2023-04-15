//
// Conforming Agent Implementation
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.conforming;

import javax.ws.rs.client.Entity;
import javax.ws.rs.core.Application;
import javax.ws.rs.core.Response;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import io.catenax.knowledge.agents.conforming.api.*;
import io.catenax.knowledge.agents.conforming.api.JsonProvider;
import io.catenax.knowledge.agents.conforming.model.JsonResultset;
import io.catenax.knowledge.agents.conforming.model.JsonResultsetResults;
import io.catenax.knowledge.agents.conforming.model.XmlResultset;
import org.glassfish.jersey.client.ClientConfig;
import org.glassfish.jersey.media.multipart.MultiPartFeature;
import org.glassfish.jersey.media.multipart.internal.MultiPartReaderClientSide;
import org.glassfish.jersey.message.internal.OutboundJaxrsResponse;
import org.glassfish.jersey.test.DeploymentContext;
import org.glassfish.jersey.test.JerseyTest;
import org.glassfish.jersey.server.ResourceConfig;

import org.junit.jupiter.api.Test;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import java.io.IOException;
import java.io.StringReader;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Tests the conforming agents themselves
 * common test setup and tests shared by KA-MATCH and KA-BIND profiles
 */
public abstract class ConformingAgentTest extends JerseyTest {

    protected abstract String getPath();
    protected ObjectMapper objectMapper=new ObjectMapper();


    @Override
    protected void configureClient(ClientConfig config) {
        super.configureClient(config);
        config.register(MultiPartReaderClientSide.class);
    }

    @Override
    protected DeploymentContext configureDeployment() {
        DeploymentContext context =  super.configureDeployment();
        context.getResourceConfig().register(JsonProvider.class);
        context.getResourceConfig().register(XmlProvider.class);
        context.getResourceConfig().register(SparqlProvider.class);
        context.getResourceConfig().packages("org.glassfish.jersey.examples.multipart")
                .register(MultiPartFeature.class);
        return context;
    }

    /**
     * you cannot invoke without query or skill asset definition
     */
    @Test
    public void testUnderspecifiedGet() {
        final Response response = target(getPath()).request().get();
        assertTrue(response.getStatus()>=400 && response.getStatus()<500,"KA-BIND/KA-MATCH: Should not be possible to get information without query or skill asset");
    }

    /**
     * you cannot invoke without query or skill asset definition
     */
    @Test
    public void testUnderspecifiedPost() {
        final Response response = target(getPath()).request().post(Entity.entity("","application/sparql-results+json"));
        assertTrue(response.getStatus()>=400 && response.getStatus()<500, "KA-BIND/KA-MATCH: Should not be possible to post information without query or skill asset");
    }

    /**
     * you can always get with a simple sparql
     */
    @Test
    public void testBindGet() throws IOException {
        Response response =target(getPath())
                .queryParam("query","SELECT%20%3Fsubject%20%3Fpredicate%20%3Fobject%20WHERE%20%7B%20%3Fsubject%20<cx:test>%20%3Fobject.%7D")
                .request()
                .get();
        assertTrue(response.getStatus()>=200 && response.getStatus()<300,"Successful get json request");
        testJsonResultSet(response);
    }

    /**
     * you can always get with a simple sparql
     */
    @Test
    public void testBindGetXml() throws IOException, ParserConfigurationException, SAXException {
        Response response = target(getPath())
                .queryParam("query","SELECT%20%3Fsubject%20%3Fpredicate%20%3Fobject%20WHERE%20%7B%20%3Fsubject%20<cx:test>%20%3Fobject.%7D")
                .request()
                .accept("application/sparql-results+xml")
                .get();
        assertTrue(response.getStatus()>=200 && response.getStatus()<300,"Successful get xml request");
        testXmlResultSet(response);
    }

    protected String getEntity(Response response) {
        return response.readEntity(String.class);
    }

    protected int getNumberVars() {
        return 3;
    }

    protected void testJsonResultSet(Response response) throws IOException {
        String content = getEntity(response);
        JsonNode node=objectMapper.readTree(content);
        assertEquals(getNumberVars(),node.get("head").get("vars").size(),"Got three variables");
        assertEquals(1,node.get("results").get("bindings").size(),"got one result");
        assertEquals(getNumberVars(),node.get("results").get("bindings").get(0).size(),"got 3 bindings");
    }

    protected void testXmlResultSet(Response response) throws IOException {
        DocumentBuilder builder= null;
        try {
            builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
        } catch (ParserConfigurationException e) {
            throw new IOException("Could not get Xml parser",e);
        }
        String content = getEntity(response);
        Document document= null;
        try {
            document = builder.parse(new InputSource(new StringReader(content)));
        } catch (SAXException e) {
            throw new IOException("Cannot parse XML",e);
        }
        assertEquals(getNumberVars(),((Element) document.getDocumentElement().getElementsByTagName("head").item(0)).getElementsByTagName("variable").getLength(),"Got three variables");
        assertEquals(1,((Element) document.getDocumentElement().getElementsByTagName("results").item(0)).getElementsByTagName("result").getLength(),"got one result");
        assertEquals(getNumberVars(),((Element)((Element) document.getDocumentElement().getElementsByTagName("results").item(0)).getElementsByTagName("result").item(0)).getElementsByTagName("binding").getLength(),"got 3 bindings");
    }

    /**
     * you can always get with a simple sparql
     */


}
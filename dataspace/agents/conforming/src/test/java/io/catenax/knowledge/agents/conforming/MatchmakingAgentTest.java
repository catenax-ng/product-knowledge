//
// Conforming Agent Implementation
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.conforming;

import com.fasterxml.jackson.databind.JsonNode;
import io.catenax.knowledge.agents.conforming.model.JsonResultset;
import org.glassfish.jersey.server.ResourceConfig;
import org.junit.jupiter.api.Test;

import javax.ws.rs.client.Entity;
import javax.ws.rs.core.Application;
import javax.ws.rs.core.Response;

import java.io.IOException;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Tests the standard matchmaking agent. this is not a test for conformance! +
 * It is rather a test for "exactness" such that the implementation tested can serve
 * as a conformance tool.
 */

public class MatchmakingAgentTest extends ConformingAgentTest {

    @Test
    public void testMatchSkillGet() throws IOException {
        Response response =target(getPath()).queryParam("asset","urn:cx:SkillAsset#Test").request().get();
        assertEquals(200,response.getStatus(),"Successful get json request");
        testJsonResultSet(response);
    }

    @Test
    public void testMatchSkillPost() throws IOException {
        Response response =target(getPath()).queryParam("asset","urn:cx:SkillAsset#Test").request().
                post(Entity.entity(ConformingAgent.emptyJson,"application/sparql-results+json"));
        assertEquals(200,response.getStatus(),"Successful post skill request");
        testJsonResultSet(response);
    }

    @Test
    public void testMatchSkillPostXml() throws IOException {
        Response response =target(getPath()).queryParam("asset","urn:cx:SkillAsset#Test").request()
                .accept("application/sparql-results+xml")
                .post(Entity.entity(ConformingAgent.emptyXml,"application/sparql-results+xml"));
        assertEquals(200,response.getStatus(),"Successful post skill xml request");
        testXmlResultSet(response);
    }

    @Test
    public void testMatchSkillPostJsonXml() throws IOException {
        Response response =target(getPath()).queryParam("asset","urn:cx:SkillAsset#Test").request()
                .accept("application/sparql-results+json")
                .post(Entity.entity(ConformingAgent.emptyXml,"application/sparql-results+xml"));
        assertEquals(200,response.getStatus(),"Successful post skill json request");
        testJsonResultSet(response);
    }

    @Test
    public void testMatchSkillPostXmlJson() throws IOException {
        Response response =target(getPath()).queryParam("asset","urn:cx:SkillAsset#Test").request()
                .accept("application/sparql-results+xml")
                .post(Entity.entity(ConformingAgent.emptyJson,"application/sparql-results+json"));
        assertEquals(200,response.getStatus(),"Successful post skill xml request");
        testXmlResultSet(response);
    }

    @Override
    protected String getPath() {
        return "/match";
    }

    @Override
    protected Application configure() {
        return new ResourceConfig(MatchmakingAgent.class);
    }

}

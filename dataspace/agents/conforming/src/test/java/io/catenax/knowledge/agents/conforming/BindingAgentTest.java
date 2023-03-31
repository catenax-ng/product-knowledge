//
// Conforming Agent Implementation
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.conforming;

import io.catenax.knowledge.agents.conforming.model.JsonResultset;
import org.glassfish.jersey.server.ResourceConfig;
import org.junit.jupiter.api.Test;

import javax.ws.rs.client.Entity;
import javax.ws.rs.core.Application;
import javax.ws.rs.core.Response;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

/**
 * Tests the standard binding agent. this is not a test for conformance! +
 * It is rather a test for "exactness" such that the implementation tested can serve
 * as a conformance tool.
 */
public class BindingAgentTest extends ConformingAgentTest {

    @Test
    public void testSkillGet() {
        final Response response = target(getPath()).queryParam("asset","urn:cx:SkillAsset#Test").request().get();
        assertEquals(400,response.getStatus(),"KA-BIND: Should not be possible to get information without query");
    }

    /**
     * you may not use predicate variables that are not bound
     */
    @Test
    public void testGetUnboundPredicate() {
        final Response response = target(getPath()).queryParam("query","SELECT%20%3Fsubject%20%3Fpredicate%20%3Fobject%20WHERE%20%7B%20%3Fsubject%20%3Fpredicate%20%3Fobject.%7D").request().get();
        assertEquals(400,response.getStatus(),"KA-BIND: Should not be possible to query unbound predicates.");
    }

    /**
     * you may not use object variables in rdf:type queries
     */
    @Test
    public void testGetUnboundRdfTypeObject() {
        final Response response = target(getPath()).queryParam("query","SELECT%20%3Fsubject%20%3Fpredicate%20%3Fobject%20WHERE%20%7B%20%3Fsubject%20%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23type%3E%20%3Fobject.%7D").request().get();
        assertEquals(400,response.getStatus(),"KA-BIND: Should not be possible to query unbound rdf:type objects.");
    }

    /**
     * you may not invoke a skill post
     */
    @Test
    public void testPostSkill() {
        final Response response = target(getPath()+"/skill")
                .queryParam("asset","urn:cx:SkillAsset#Test")
                .request()
                .post(Entity.entity("SELECT%20%3Fsubject%20%3Fpredicate%20%3Fobject%20WHERE%20%7B%20%3Fsubject%20%3Fpredicate%20%3Fobject.%7D","application/sparql-query"));
        assertEquals(404,response.getStatus(),"KA-BIND: Should not be possible to set skills.");
    }

    @Override
    protected String getPath() {
        return "/bind";
    }

    @Override
    protected Application configure() {
        return new ResourceConfig(BindingAgent.class);
    }

}

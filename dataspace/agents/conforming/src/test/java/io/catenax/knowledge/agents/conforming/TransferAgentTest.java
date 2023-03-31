//
// Conforming Agent Implementation
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.conforming;

import org.glassfish.jersey.media.multipart.FormDataMultiPart;
import org.glassfish.jersey.server.ResourceConfig;
import org.junit.jupiter.api.Test;

import javax.ws.rs.client.Entity;
import javax.ws.rs.core.Application;
import javax.ws.rs.core.Response;

import java.io.IOException;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * Tests the standard transfer agent. this is not a test for conformance! +
 * It is rather a test for "exactness" such that the implementation tested can serve
 * as a conformance tool.
 */

public class TransferAgentTest extends MatchmakingAgentTest {

    @Override protected String getEntity(Response response) {
        return response.readEntity(FormDataMultiPart.class).getBodyParts().get(0).getEntityAs(String.class);
    }

    @Override
    protected String getPath() {
        return "/transfer";
    }

    @Override
    protected Application configure() {
        return new ResourceConfig(TransferAgent.class);
    }

}

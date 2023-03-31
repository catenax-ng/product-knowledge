//
// Conforming Agent Implementation
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.conforming;

import io.catenax.knowledge.agents.conforming.api.NotFoundException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;
import java.util.List;

/**
 * Implements a standard matchmaking agent
 */
@Path("/match")
public class MatchmakingAgent extends ConformingAgent {

    @Override
    public Response getAgent(String asset, String queryLn, String query, String _vin, List<String> troubleCode) throws NotFoundException {
        if(query==null && asset==null) {
            return annotate(Response.status(400,"{ \"error\":400, \"reason\":\"KA-MATCH: query or asset parameter must be set\" }"));
        }
        return super.getAgent(asset,queryLn,query,_vin,troubleCode);
    }

    @Override
    public Response postAgent(Object body, String asset, String queryLn, String query, String _vin,  List<String> troubleCode) throws NotFoundException {
        if(body==null && asset == null) {
            return annotate(Response.status(400,"{ \"error\":400, \"reason\":\"KA-BIND: body or asset parameter must be set\" }"));
        }
        return super.postAgent(body, asset, queryLn, query, _vin,troubleCode);
    }
}

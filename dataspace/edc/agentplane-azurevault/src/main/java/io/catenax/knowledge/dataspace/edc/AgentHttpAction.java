//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import org.slf4j.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.jena.fuseki.system.ActionCategory;
import org.apache.jena.fuseki.servlets.HttpAction;


/**
 * HttpAction which may either contain
 * a query or a predefined skill.
 */
public class AgentHttpAction extends HttpAction {
    final String skill;
    final String graphs;
    
    /**
     * creates a new http action
     * @param id call id
     * @param logger the used logging output
     * @param request servlet input
     * @param response servlet output
     * @param skill option skill reference
     */
    public AgentHttpAction(long id, Logger logger, HttpServletRequest request, HttpServletResponse response, String skill, String graphs) {
        super(id, logger, ActionCategory.ACTION, request, response);
        this.skill=skill;
        this.graphs=graphs;
    }
    
    /**
     * @return optional skill
     */
    public String getSkill() {
        return skill;
    }

        /**
     * @return optional skill
     */
    public String getGraphs() {
        return graphs;
    }

}

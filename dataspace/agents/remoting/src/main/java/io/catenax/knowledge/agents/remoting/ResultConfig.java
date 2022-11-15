//
// Application to provide REST APIs as SPARQL services
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.remoting;

import org.eclipse.rdf4j.sail.config.SailConfigException;

import java.util.Map;

/**
 * class to represent a single result description
 * from the config graph of the remoting SAIL repo.
 */
public class ResultConfig {

    /**
     * map of outputs
     */
    protected Map<String, ReturnValueConfig> outputs = new java.util.HashMap<String, ReturnValueConfig>();

    /** prefix for all the output paths */
    String outputProperty=null;
    /** where the id of the result can be found */
    String resultIdProperty=null;

    @Override
    public String toString() {
        return super.toString()+"/service";
    }   

    /**
     * Validates the invocation config
     * @throws SailConfigException
     */
    public void validate(String context) throws SailConfigException {
        if(context==null) {
            throw new SailConfigException("Result Config must have a context");
        }
        for (Map.Entry<String, ReturnValueConfig> arg : outputs.entrySet()) {
            arg.getValue().validate(arg.getKey());
        }
    }
}

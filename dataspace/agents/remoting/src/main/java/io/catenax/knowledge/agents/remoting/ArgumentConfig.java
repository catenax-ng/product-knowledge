package io.catenax.knowledge.agents.remoting;

import org.eclipse.rdf4j.sail.config.SailConfigException;

/**
 * represents the config of an argument
 */
public class ArgumentConfig {
     /** name of the argument */
     protected String argumentName;
     
     public void validate(String context) throws SailConfigException {
         if (argumentName==null || argumentName.length()==0) {
            throw new SailConfigException(String.format("Only support named arguments %s.",context));
         }    
     }
}

//
// Application to provide REST APIs as SPARQL services
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.remoting;

import org.eclipse.rdf4j.sail.Sail;
import org.eclipse.rdf4j.sail.config.SailFactory;
import org.eclipse.rdf4j.sail.config.SailImplConfig;
import org.eclipse.rdf4j.sail.config.SailConfigException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Factory to create remoting sails
 */

public class RemotingSailFactory implements SailFactory {

    /**
     * our logger
     */
    protected Logger logger = LoggerFactory.getLogger(getClass());

    /**
     * hardcoded sail type
     */
    public static final String SAIL_TYPE = "io.catenax.knowledge:Remoting";
    
    /**
     * createst the factory
     */
    public RemotingSailFactory() {
        if(logger.isDebugEnabled()) {
            logger.debug(String.format("Creating a Remoting SAIL factory for SAIL type %s. Usually OSGI configuration has been successful at this point.",SAIL_TYPE));
        }
    }

    @Override
    public String toString() {
        return super.toString()+"/factory";
    }

    /**
     * return the sail type IRI
     */
    @Override
    public String getSailType() {
        return SAIL_TYPE;
    }

    /**
     * provide a SAIL specific configuration implementation
     */
    @Override
    public SailImplConfig getConfig() {
        if(logger.isTraceEnabled()) {
            logger.trace("Creating a Remoting SAIL configuration.");
        }
        return new RemotingSailConfig();
    }

    /**
     * the actual factory method
     */
    @Override
    public Sail getSail(SailImplConfig originalConfig) throws SailConfigException {
        if(logger.isDebugEnabled()) {
            logger.debug("About to creating a Remoting SAIL from configuration "+originalConfig);
        }
        if (!(originalConfig instanceof RemotingSailConfig)) {
            throw new SailConfigException(
                    "Wrong config type: " 
                            + originalConfig.getClass().getCanonicalName() + ". ");
        }
        RemotingSailConfig config = (RemotingSailConfig)originalConfig;
        RemotingSail sail = new RemotingSail(config);
        return sail;
       
    }
}
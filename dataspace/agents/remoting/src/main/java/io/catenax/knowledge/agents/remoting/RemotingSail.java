//
// Application to provide REST APIs as SPARQL services
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.remoting;

import org.eclipse.rdf4j.model.*;

import org.eclipse.rdf4j.sail.helpers.AbstractSail;
import org.eclipse.rdf4j.sail.SailException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Implements a pseudo-storage that is backed by a remote service
 */
public class RemotingSail extends AbstractSail {
    /** the logger */
    protected Logger logger = LoggerFactory.getLogger(getClass());

    /** the remoting target */
    protected RemotingSailConfig config;

    /**
     * creates the remoting sail
     * @param config config of the services
     */
    public RemotingSail(RemotingSailConfig config) {
        this.config=config;
        if(logger.isDebugEnabled()) {
        logger.debug(String.format("Starting remoting inference on config %s",this.config));
       }
    }

    @Override
    public String toString() {
        return super.toString()+"/sail";
    }

    /**
     * exposes a connection to this sail.
     * We may hide state in the connection implementation
     */
    @Override
    protected RemotingSailConnection getConnectionInternal() throws SailException {
        if(logger.isTraceEnabled()) {
            logger.trace(String.format("returning a new remoting connection to config %s",this.config));
        }
        return new RemotingSailConnection(this);
    }

    /**
     * shutdown the sail
     */
    @Override
    protected void shutDownInternal() {
        if(logger.isTraceEnabled()) {
            logger.trace(String.format("shutting down remoting to %s",this.config));
        }
    }

    /**
     * link to the factory
     */
    @Override
    public ValueFactory getValueFactory() {
        return config.vf;
    }

    /**
     * a service is not "writable", only queriable
     */
    @Override
    public boolean isWritable() {
        return false;
    }
}

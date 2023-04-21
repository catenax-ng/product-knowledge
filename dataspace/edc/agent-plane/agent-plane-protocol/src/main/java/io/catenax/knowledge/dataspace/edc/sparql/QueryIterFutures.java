//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.sparql;

import io.catenax.knowledge.dataspace.edc.AgentConfig;
import org.apache.jena.atlas.io.IndentedWriter;
import org.apache.jena.sparql.engine.QueryIterator;
import org.apache.jena.sparql.engine.binding.Binding;
import org.apache.jena.sparql.engine.iterator.QueryIteratorBase;
import org.apache.jena.sparql.serializer.SerializationContext;
import org.apache.jena.sparql.util.Context;
import org.eclipse.edc.spi.monitor.Monitor;

import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

/**
 * A query iterator sitting on a set of future query iterators
 * It will get and produce contextual information in order to collect any
 * errors appearing.
 */
public class QueryIterFutures extends QueryIteratorBase {

    final List<Future<QueryIterator>> futures;
    QueryIterator current;
    final Monitor monitor;
    final AgentConfig config;

    final String sourceTenant;
    final String sourceAsset;
    final String targetTenant;
    final String targetAsset;
    final Context executionContext;

    /**
     * creates a new future iterator
     * @param config agent config
     * @param monitor logging subsystem
     * @param sourceTenant the name/uri of the source tenant
     * @param targetTenant the name/uri of the remote tenant
     * @param sourceAsset the name of the calling/consuming graph
     * @param targetAsset the name of the target/producing graph
     * @param executionContext description of the execution context
     * @param futures list of futures to synchronize on
     */
    public QueryIterFutures(AgentConfig config, Monitor monitor, String sourceTenant, String sourceAsset, String targetTenant, String targetAsset, Context executionContext, List<Future<QueryIterator>> futures) {
        this.futures=futures;
        this.monitor=monitor;
        this.config=config;
        this.sourceAsset=sourceAsset;
        this.sourceTenant=sourceTenant;
        this.targetAsset=targetAsset;
        this.targetTenant=targetTenant;
        this.executionContext=executionContext;
    }

    /**
     * @return whether any service has/will produce any binding
     */
    @Override
    protected boolean hasNextBinding() {
        return (current!=null && current.hasNext()) || hasNextInternalBinding();
    }

    /**
     * move to the next ready-made future (or sync/poll for the next ready-made one in a recursion)
     * @return whether any service has/will produce any binding
     */
    boolean hasNextInternalBinding() {
        if(!futures.isEmpty()) {
            Optional<Future<QueryIterator>> boundFuture=futures.stream().filter(Future::isDone).findFirst();
            try {
                if(boundFuture.isPresent()) {
                    Future<QueryIterator> currentFuture=boundFuture.get();
                    futures.remove(currentFuture);
                    current = currentFuture.get();
                } else {
                    Thread.sleep(config.getNegotiationPollInterval());
                }
            }  catch(InterruptedException e) {
                List<CatenaxWarning> warnings=CatenaxWarning.getOrSetWarnings(executionContext);
                CatenaxWarning newWarning=new CatenaxWarning();
                newWarning.setSourceAsset(sourceAsset);
                newWarning.setSourceTenant(sourceTenant);
                newWarning.setTargetAsset(targetAsset);
                newWarning.setTargetTenant(targetTenant);
                newWarning.setContext(executionContext.toString());
                newWarning.setProblem(String.format("Synchronization on a remote future was interrupted with %s.",e.getMessage()));
                warnings.add(newWarning);
                monitor.warning(newWarning.getProblem());
            } catch(ExecutionException e) {
                List<CatenaxWarning> warnings=CatenaxWarning.getOrSetWarnings(executionContext);
                CatenaxWarning newWarning=new CatenaxWarning();
                newWarning.setSourceAsset(sourceAsset);
                newWarning.setSourceTenant(sourceTenant);
                newWarning.setTargetAsset(targetAsset);
                newWarning.setTargetTenant(targetTenant);
                newWarning.setContext(executionContext.toString());
                newWarning.setProblem(String.format("Accessing a remote future failed because of %s. Ignoring.",e.getCause()));
                warnings.add(newWarning);
                monitor.warning(newWarning.getProblem());
            }
            return hasNextBinding();
        }
        return false;
    }

    @Override
    protected Binding moveToNextBinding() {
        return current.next();
    }

    @Override
    protected void closeIterator() {
        requestCancel();
        if(current!=null) {
            current.close();
            current = null;
        }
    }
    @Override
    protected void requestCancel() {
        futures.forEach( future -> future.cancel(true));
        futures.clear();
    }

    @Override
    public void output(IndentedWriter indentedWriter, SerializationContext serializationContext) {
    }
}

package io.catenax.knowledge.dataspace.edc.service;

import io.catenax.knowledge.dataspace.edc.AgentConfig;
import io.catenax.knowledge.dataspace.edc.rdf.RDFStore;
import org.apache.jena.graph.Node;
import org.apache.jena.graph.NodeFactory;
import org.apache.jena.sparql.core.Quad;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.types.domain.catalog.Catalog;
import org.eclipse.dataspaceconnector.spi.types.domain.contract.offer.ContractOffer;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * A service which keeps a triple store and
 * the associated dataspace in sync
 */
public class DataspaceSynchronizer implements Runnable {

    protected final ScheduledExecutorService service;
    protected final AgentConfig config;
    protected boolean isStarted=false;
    protected final DataManagement dataManagement;
    protected final RDFStore rdfStore;
    protected final Monitor monitor;

    protected final static Node CX_ASSET=NodeFactory.createURI("https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#offersAsset");

    /**
     * creates the synchronizer
     * @param service scheduler
     * @param config edc config
     * @param dataManagement data management service remoting
     * @param rdfStore a triple store for persistance
     * @param monitor logging subsystem
     */
    public DataspaceSynchronizer(ScheduledExecutorService service, AgentConfig config, DataManagement dataManagement, RDFStore rdfStore, Monitor monitor) {
        this.service=service;
        this.config=config;
        this.dataManagement=dataManagement;
        this.rdfStore=rdfStore;
        this.monitor=monitor;
    }

    /**
     * starts the synchronizer
     */
    public synchronized void start() {
        if(!isStarted) {
            isStarted=true;
            long interval=config.getDataspaceSynchronizationInterval();
            String[] connectors=config.getDataspaceSynchronizationConnectors();
            if(interval>0 && connectors!=null && connectors.length>0) {
                monitor.info(String.format("Starting dataspace synchronization on %d connectors with interval %d milliseconds", connectors.length,interval));
                service.schedule(this,interval,TimeUnit.MILLISECONDS);
            }
        }
    }

    /**
     * stops the synchronizer
     */
    public synchronized void shutdown() {
        if(isStarted) {
            monitor.info(String.format("Shutting down dataspace synchronization"));
            isStarted=false;
            service.shutdown();
        }
    }

    /**
     * runs the synchronizer when scheduled
     */
    @Override
    public void run() {
        monitor.debug(String.format("Synchronization run has been started"));
        if(isStarted) {
            for (String remote : config.getDataspaceSynchronizationConnectors()) {
                if(isStarted) {
                    monitor.debug(String.format("About to synchronize remote connector %s", remote));
                    rdfStore.startTx();
                    try {
                        Catalog catalog = dataManagement.getCatalog(remote);
                        monitor.debug(String.format("Found a catalog with %d entries for remote connector %s", catalog.getContractOffers().size(), remote));
                        Node graph = rdfStore.getDefaultGraph();
                        Node connector = NodeFactory.createURI(remote.replace("https", "edcs").replace("http", "edc"));
                        Quad findAssets = Quad.create(graph,connector,CX_ASSET,Node.ANY);
                        Iterator<Quad> assetQuads= rdfStore.getDataSet().find(findAssets);
                        int tupleCount=0;
                        while(assetQuads.hasNext()) {
                            Quad quadAsset=assetQuads.next();
                            Quad findAssetProps = Quad.create(graph,quadAsset.getObject(),Node.ANY,Node.ANY);
                            Iterator<Quad> propQuads=rdfStore.getDataSet().find(findAssetProps);
                            while(propQuads.hasNext()) {
                                Quad quadProp=propQuads.next();
                                rdfStore.getDataSet().delete(quadProp);
                                tupleCount++;
                            }
                            rdfStore.getDataSet().delete(quadAsset);
                            tupleCount++;
                        }
                        monitor.debug(String.format("About to delete %d old tuples.", tupleCount));
                        tupleCount=0;
                        for (ContractOffer offer : catalog.getContractOffers()) {
                            for(Quad quad : convertToQuads(graph,connector,offer)) {
                                tupleCount++;
                                rdfStore.getDataSet().add(quad);
                            }
                        }
                        monitor.debug(String.format("About to add %d new tuples.", tupleCount));
                        rdfStore.commit();
                    } catch (Throwable io) {
                        monitor.warning(String.format("Could not synchronize remote connector %s because of %s. Going ahead.", remote, io));
                        rdfStore.abort();
                    }
                } else {
                    monitor.debug(String.format("Synchronization is no more active. Skipping all connectors starting from %s.",remote));
                    break;
                }
            } // for
            if(isStarted) {
                monitor.debug(String.format("Schedule next synchronization run"));
                service.schedule(this, config.getDataspaceSynchronizationInterval(), TimeUnit.MILLISECONDS);
            } else {
                monitor.debug(String.format("Synchronization is no more active. Disable next run."));
            }
        }
    }

    /**
     * convert a given contract offer into quads
     * @param graph default graph
     * @param connector parent connector hosting the offer
     * @param offer the contract offer
     * @return a collection of quads
     */
    public Collection<Quad> convertToQuads(Node graph, Node connector, ContractOffer offer) {
        List<Quad> quads=new ArrayList<>();
        quads.add(Quad.create(graph,
                connector,
                CX_ASSET,
                NodeFactory.createURI(offer.getAsset().getId())));
        return quads;
    }

}

//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.rdf;

import io.catenax.knowledge.dataspace.edc.AgentConfig;
import io.catenax.knowledge.dataspace.edc.MonitorWrapper;
import org.apache.jena.fuseki.server.DataAccessPoint;
import org.apache.jena.fuseki.server.DataService;
import org.apache.jena.graph.Node;
import org.apache.jena.graph.NodeFactory;
import org.apache.jena.query.TxnType;
import org.apache.jena.riot.Lang;
import org.apache.jena.riot.RDFParser;
import org.apache.jena.riot.lang.StreamRDFCounting;
import org.apache.jena.riot.system.ErrorHandler;
import org.apache.jena.riot.system.ErrorHandlerFactory;
import org.apache.jena.riot.system.StreamRDF;
import org.apache.jena.riot.system.StreamRDFLib;
import org.apache.jena.sparql.core.DatasetGraph;
import org.apache.jena.sparql.core.DatasetGraphFactory;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;

/**
 * a service sitting on a local RDF store/graph
 * (which hosts the ontology and the federated dataspace
 * representation)
 */
public class RDFStore {

    // we need a single data access point (with its default graph)
    protected final DatasetGraph dataset;
    protected final DataAccessPoint api;
    protected final DataService service;
    protected final Monitor monitor;
    protected final AgentConfig config;

    protected final MonitorWrapper monitorWrapper;

    /**
     * create a new RDF store (and initialise with a given ttl file)
     * @param config EDC config
     * @param monitor logging subsystem
     */
    public RDFStore(AgentConfig config, Monitor monitor) {
        this.config=config;
        this.dataset = DatasetGraphFactory.createTxnMem();
        DataService.Builder dataService = DataService.newBuilder(dataset);
        this.service=dataService.build();
        api=new DataAccessPoint(config.getAccessPoint(), service);
        this.monitor=monitor;
        this.monitorWrapper=new MonitorWrapper(getClass().getName(),monitor);
        monitor.debug(String.format("Activating data service %s under access point %s",service,api));
        service.goActive();
        // read file with ontology, share this dataset with the catalogue sync procedure
        if(config.getAssetFile()!=null) {
            startTx();
            StreamRDF dest = StreamRDFLib.dataset(dataset);
            StreamRDF graphDest = StreamRDFLib.extendTriplesToQuads(getDefaultGraph(),dest);
            StreamRDFCounting countingDest = StreamRDFLib.count(graphDest);
            ErrorHandler errorHandler = ErrorHandlerFactory.errorHandlerStd(monitorWrapper);
            RDFParser.create()
                    .errorHandler(errorHandler)
                    .source(config.getAssetFile())
                    .lang(Lang.TTL)
                    .parse(countingDest);
            commit();
            monitor.info(String.format("Initialised asset %s with %d triples from file %s",config.getDefaultAsset(),countingDest.countTriples(),config.getAssetFile()));
        }
    }

    /**
     * @return name of the default graph
     */
    public Node getDefaultGraph() {
        return NodeFactory.createURI(config.getDefaultAsset());
    }

    /**
     * @return access point to the graph
     */
    public DataAccessPoint getDataAccessPoint() {
        return api;
    }

    /**
     * @return dataservice shielding the graph
     */
    public DataService getDataService() {
        return service;
    }

    /**
     * @return the actual graph store
     */
    public DatasetGraph getDataSet() {
        return dataset;
    }

    /**
     * starts a write transaction
     */
    public void startTx() {
        dataset.begin(TxnType.WRITE);
    }

    /**
     * commits the current transaction
     */
    public void commit() {
        dataset.commit();
    }

    /**
     * rollback the current transaction
     */
    public void abort() {
        dataset.abort();
    }
}

//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import dev.failsafe.RetryPolicy;
import io.catenax.knowledge.dataspace.edc.http.AgentController;
import io.catenax.knowledge.dataspace.edc.http.HttpClientFactory;
import io.catenax.knowledge.dataspace.edc.http.transfer.AgentSourceFactory;
import io.catenax.knowledge.dataspace.edc.http.transfer.AgentSourceRequestParamsSupplier;
import io.catenax.knowledge.dataspace.edc.rdf.RDFStore;
import io.catenax.knowledge.dataspace.edc.service.DataspaceSynchronizer;
import io.catenax.knowledge.dataspace.edc.sparql.DataspaceServiceExecutor;
import io.catenax.knowledge.dataspace.edc.sparql.SparqlQueryProcessor;
import io.catenax.knowledge.dataspace.edc.sparql.SparqlQuerySerializerFactory;
import io.catenax.knowledge.dataspace.edc.validation.SwitchingDataPlaneTokenValidatorController;
import org.apache.jena.query.Syntax;
import org.apache.jena.sparql.serializer.*;
import org.apache.jena.sparql.service.ServiceExecutorRegistry;
import org.eclipse.edc.connector.dataplane.http.params.HttpRequestFactory;
import org.eclipse.edc.connector.dataplane.spi.pipeline.DataTransferExecutorServiceContainer;
import org.eclipse.edc.spi.http.EdcHttpClient;
import org.eclipse.edc.web.spi.WebService;
import org.eclipse.edc.spi.monitor.Monitor;
import org.eclipse.edc.spi.security.Vault;
import org.eclipse.edc.runtime.metamodel.annotation.Inject;
import org.eclipse.edc.spi.system.ServiceExtension;
import org.eclipse.edc.spi.system.ServiceExtensionContext;
import okhttp3.OkHttpClient;
import io.catenax.knowledge.dataspace.edc.service.DataManagement;

import org.eclipse.edc.connector.dataplane.spi.pipeline.PipelineService;
import org.eclipse.edc.spi.types.TypeManager;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.regex.Pattern;

/**
 * EDC extension that initializes the Agent subsystem (Agent Sources, Agent Endpoint and Federation Callbacks
 */
public class AgentExtension implements ServiceExtension {

    /**
     * static constants
     */
    protected static final String DEFAULT_CONTEXT_ALIAS = "default";
    protected static final String CALLBACK_CONTEXT_ALIAS = "callback";
    public static Pattern GRAPH_PATTERN=Pattern.compile("((?<url>[^#]+)#)?(?<graph>(urn:(cx|artifact):)?Graph:.*)");


    /**
     * dependency injection part
     */
    @Inject
    protected WebService webService;

    @Inject
    @SuppressWarnings("rawtypes")
    protected RetryPolicy retryPolicy;

    @Inject
    protected PipelineService pipelineService;

    @Inject
    protected Vault vault;

    @Inject
    protected DataTransferExecutorServiceContainer executorContainer;
    @Inject
    private EdcHttpClient edcHttpClient;

    /**
     * refers a scheduler
     * TODO maybe reuse an injected scheduler
     */
    protected ScheduledExecutorService executorService;

    /**
     * data synchronization service
     */
    protected DataspaceSynchronizer synchronizer;

    /**
     * we use our own http client
     */
    protected OkHttpClient httpClient;

    /**
     * @return name of the extension
     */
    @Override
    public String name() {
        return "Knowledge Agents Extension";
    }

    /**
     * runs on extension initialization
     * @param context EDC bootstrap context
     */
    @Override
    public void initialize(ServiceExtensionContext context) {
        Monitor monitor = context.getMonitor();
        
        monitor.debug(String.format("Initializing %s",name()));

        AgentConfig config = new AgentConfig(monitor,context.getConfig());
        httpClient= HttpClientFactory.create(config);
        TypeManager typeManager = context.getTypeManager();

        DataManagement catalogService=new DataManagement(monitor,typeManager,httpClient,config);

        AgreementController agreementController=new AgreementController(monitor,config,catalogService);
        monitor.debug(String.format("Registering agreement controller %s",agreementController));
        webService.registerResource(CALLBACK_CONTEXT_ALIAS, agreementController);

        RDFStore rdfStore=new RDFStore(config,monitor);

        executorService= Executors.newScheduledThreadPool(config.getThreadPoolSize());
        synchronizer=new DataspaceSynchronizer(executorService,config,catalogService,rdfStore,monitor);

        SwitchingDataPlaneTokenValidatorController validatorController=new SwitchingDataPlaneTokenValidatorController(httpClient,config,monitor);
        if(validatorController.isEnabled()) {
            monitor.debug(String.format("Registering switching validator controller %s",validatorController));
            webService.registerResource(DEFAULT_CONTEXT_ALIAS,validatorController);
        }

        // EDC Remoting Support
        ServiceExecutorRegistry reg = new ServiceExecutorRegistry();
        reg.addBulkLink(new DataspaceServiceExecutor(monitor,agreementController,config,httpClient,executorService,typeManager,config));
        //reg.add(new DataspaceServiceExecutor(monitor,agreementController,config,httpClient));

        // Ontop and other deep nesting-afraid providers/optimizers
        // should be supported by not relying on the Fuseki syntax graph
        SparqlQuerySerializerFactory arqQuerySerializerFactory = new SparqlQuerySerializerFactory();
        SerializerRegistry.get().addQuerySerializer(Syntax.syntaxARQ, arqQuerySerializerFactory);
        SerializerRegistry.get().addQuerySerializer(Syntax.syntaxSPARQL_10, arqQuerySerializerFactory);
        SerializerRegistry.get().addQuerySerializer(Syntax.syntaxSPARQL_11, arqQuerySerializerFactory);

        // the actual sparql engine inside the EDC
        SparqlQueryProcessor processor=new SparqlQueryProcessor(reg,monitor,config,rdfStore, typeManager);

        // stored procedure store and transport endpoint
        SkillStore skillStore=new SkillStore();
        AgentController agentController=new AgentController(monitor,agreementController,config,httpClient,processor,skillStore,typeManager);
        monitor.debug(String.format("Registering agent controller %s",agentController));
        webService.registerResource(DEFAULT_CONTEXT_ALIAS, agentController);

        monitor.debug(String.format("Initialized %s",name()));

        HttpRequestFactory httpRequestFactory = new HttpRequestFactory();
        AgentSourceFactory sourceFactory = new AgentSourceFactory(edcHttpClient, new AgentSourceRequestParamsSupplier(vault,typeManager,config,monitor),monitor,httpRequestFactory, processor, skillStore);
        pipelineService.registerFactory(sourceFactory);
    }

    /**
     * start scheduled services
     */
    @Override
    public void start() {
        synchronizer.start();
    }

    /**
     * Signals the extension to release resources and shutdown.
     * stop any schedules services
     */
    @Override
    public void shutdown() {
        synchronizer.shutdown();
    }
}
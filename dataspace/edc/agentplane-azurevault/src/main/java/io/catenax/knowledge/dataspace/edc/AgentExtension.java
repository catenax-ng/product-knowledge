//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import dev.failsafe.RetryPolicy;
import io.catenax.knowledge.dataspace.edc.http.AgentController;
import io.catenax.knowledge.dataspace.edc.sparql.DataspaceServiceExecutor;
import io.catenax.knowledge.dataspace.edc.sparql.SparqlQueryProcessor;
import org.apache.jena.sparql.service.ServiceExecutorRegistry;
import org.eclipse.dataspaceconnector.dataplane.http.pipeline.HttpSinkRequestParamsSupplier;
import org.eclipse.dataspaceconnector.dataplane.spi.pipeline.DataTransferExecutorServiceContainer;
import org.eclipse.dataspaceconnector.spi.WebService;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.security.Vault;
import org.eclipse.dataspaceconnector.spi.system.Inject;
import org.eclipse.dataspaceconnector.spi.system.ServiceExtension;
import org.eclipse.dataspaceconnector.spi.system.ServiceExtensionContext;
import okhttp3.OkHttpClient;
import io.catenax.knowledge.dataspace.edc.service.DataManagement;

import org.eclipse.dataspaceconnector.dataplane.spi.pipeline.PipelineService;
import org.eclipse.dataspaceconnector.spi.types.TypeManager;

/**
 * EDC extension that initializes the Agent subsystem (Agent Sources, Agent Sinks, Agent Endpoint and Federation Callbacks
 */
public class AgentExtension implements ServiceExtension {

    /**
     * static constants
     */
    private static final String DEFAULT_CONTEXT_ALIAS = "default";
    private static final String CALLBACK_CONTEXT_ALIAS = "callback";

    /**
     * dependency injection part
     */
    @Inject
    private WebService webService;

    @Inject
    private OkHttpClient httpClient;

    @Inject
    @SuppressWarnings("rawtypes")
    private RetryPolicy retryPolicy;

    @Inject
    private PipelineService pipelineService;

    @Inject
    private Vault vault;

    @Inject
    private DataTransferExecutorServiceContainer executorContainer;

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
        TypeManager typeManager = context.getTypeManager();

        DataManagement catalogService=new DataManagement(monitor,typeManager,httpClient,config);

        AgreementController agreementController=new AgreementController(monitor,config,catalogService);
        monitor.debug(String.format("Registering agreement controller %s",agreementController));
        webService.registerResource(CALLBACK_CONTEXT_ALIAS, agreementController);

        ServiceExecutorRegistry reg = new ServiceExecutorRegistry();
        reg.add(new DataspaceServiceExecutor(monitor,agreementController,config,httpClient));
        SparqlQueryProcessor processor=new SparqlQueryProcessor(reg,monitor,config);

        AgentController agentController=new AgentController(monitor,agreementController,config,httpClient,processor);
        monitor.debug(String.format("Registering agent controller %s",agentController));
        webService.registerResource(DEFAULT_CONTEXT_ALIAS, agentController);

        monitor.debug(String.format("Initialized %s",name()));

        AgentSourceFactory sourceFactory = new AgentSourceFactory(httpClient, retryPolicy, new AgentSourceRequestParamsSupplier(vault,config,monitor),monitor);
        pipelineService.registerFactory(sourceFactory);

        AgentSinkFactory sinkFactory = new AgentSinkFactory(httpClient, executorContainer.getExecutorService(), 5, monitor, new HttpSinkRequestParamsSupplier(vault));
        pipelineService.registerFactory(sinkFactory);
    }

}
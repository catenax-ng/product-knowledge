//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import dev.failsafe.RetryPolicy;
import org.eclipse.dataspaceconnector.dataplane.http.pipeline.HttpSinkRequestParamsSupplier;
import org.eclipse.dataspaceconnector.dataplane.http.pipeline.HttpSourceRequestParamsSupplier;
import org.eclipse.dataspaceconnector.dataplane.spi.pipeline.DataTransferExecutorServiceContainer;
import org.eclipse.dataspaceconnector.spi.WebService;
import org.eclipse.dataspaceconnector.spi.security.Vault;
import org.eclipse.dataspaceconnector.spi.system.Inject;
import org.eclipse.dataspaceconnector.spi.system.ServiceExtension;
import org.eclipse.dataspaceconnector.spi.system.ServiceExtensionContext;
import okhttp3.OkHttpClient;
import io.catenax.knowledge.dataspace.edc.service.DataManagement;

import org.eclipse.dataspaceconnector.dataplane.spi.pipeline.PipelineService;

/**
 * EDC extension that initializes the Agent subsystem (Agent Sources, Agent Sinks, Agent Endpoint and Federation Callbacks
 */
public class AgentExtension implements ServiceExtension {

    private static final String DEFAULT_CONTEXT_ALIAS = "default";
    private static final String CALLBACK_CONTEXT_ALIAS = "callback";

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

    @Override
    public String name() {
        return "Knowledge Agents Extension";
    }

    @Override
    public void initialize(ServiceExtensionContext context) {
        var monitor = context.getMonitor();
        
        monitor.debug(String.format("Initializing %s",name()));

        var config = new AgentConfig(monitor,context.getConfig());
        var typeManager = context.getTypeManager();

        var catalogService=new DataManagement(monitor,typeManager,httpClient,config);

        var agreementController=new AgreementController(monitor,config,catalogService);
        monitor.debug(String.format("Registering agreement controller %s",agreementController));
        webService.registerResource(CALLBACK_CONTEXT_ALIAS, agreementController);

        var agentController=new AgentController(monitor,agreementController,config,httpClient);
        monitor.debug(String.format("Registering agent controller %s",agentController));
        webService.registerResource(DEFAULT_CONTEXT_ALIAS, agentController);

        monitor.debug(String.format("Initialized %s",name()));

        /*@SuppressWarnings("unchecked") var sourceFactory = new AgentSourceFactory(httpClient, retryPolicy, new HttpSourceRequestParamsSupplier(vault));
        pipelineService.registerFactory(sourceFactory);

        var sinkFactory = new AgentSinkFactory(httpClient, executorContainer.getExecutorService(), 5, monitor, new HttpSinkRequestParamsSupplier(vault));
        pipelineService.registerFactory(sinkFactory);
*/
    }

}
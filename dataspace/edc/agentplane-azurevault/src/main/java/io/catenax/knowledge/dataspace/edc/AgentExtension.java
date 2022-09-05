//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import org.eclipse.dataspaceconnector.spi.WebService;
import org.eclipse.dataspaceconnector.spi.system.Inject;
import org.eclipse.dataspaceconnector.spi.system.ServiceExtension;
import org.eclipse.dataspaceconnector.spi.system.ServiceExtensionContext;

/**
 * EDC extension that initializes the Agent subsystem
 */
public class AgentExtension implements ServiceExtension {

    private static final String DEFAULT_CONTEXT_ALIAS = "default";
    private static final String CALLBACK_CONTEXT_ALIAS = "callback";

    @Inject
    private WebService webService;

    @Override
    public String name() {
        return "Knowledge Agents Extension";
    }

    @Override
    public void initialize(ServiceExtensionContext context) {
        var monitor = context.getMonitor();
        
        monitor.debug(String.format("Initializing %s",name()));

        var config = new AgentConfig(monitor,context.getConfig());

        var agreementController=new AgreementController(monitor,config);
        monitor.debug(String.format("Registering agreement controller %s",agreementController));
        webService.registerResource(CALLBACK_CONTEXT_ALIAS, agreementController);

        var agentController=new AgentController(monitor,agreementController,config);
        monitor.debug(String.format("Registering agent controller %s",agentController));
        webService.registerResource(DEFAULT_CONTEXT_ALIAS, agentController);

        monitor.debug(String.format("Initialized %s",name()));

    }

}
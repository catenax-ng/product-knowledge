//
// EDC Control Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
package io.catenax.knowledge.dataspace.edc;

import org.eclipse.edc.connector.transfer.dataplane.proxy.ConsumerPullTransferProxyResolver;
import org.eclipse.edc.connector.transfer.dataplane.spi.security.DataEncrypter;
import org.eclipse.edc.connector.transfer.dataplane.spi.security.KeyPairWrapper;
import org.eclipse.edc.connector.transfer.spi.edr.EndpointDataReferenceTransformerRegistry;
import org.eclipse.edc.connector.transfer.spi.flow.DataFlowManager;
import org.eclipse.edc.jwt.TokenGenerationServiceImpl;
import org.eclipse.edc.runtime.metamodel.annotation.Extension;
import org.eclipse.edc.runtime.metamodel.annotation.Inject;
import org.eclipse.edc.spi.message.RemoteMessageDispatcherRegistry;
import org.eclipse.edc.spi.system.ServiceExtension;
import org.eclipse.edc.spi.system.ServiceExtensionContext;
import org.eclipse.edc.spi.types.TypeManager;
import java.time.Clock;

import static org.eclipse.edc.connector.transfer.dataplane.TransferDataPlaneConfig.DEFAULT_TOKEN_VALIDITY_SECONDS;
import static org.eclipse.edc.connector.transfer.dataplane.TransferDataPlaneConfig.TOKEN_VALIDITY_SECONDS;

/**
 * Alternative variant of the DataPlaneTransferSyncExtension which
 * annotates the proxy references (and hence the public data addresses) with 
 * their source type (default: HttpData) in order to allow the construction
 * of special sources and sinks which handle sub-protocols.
 * Currently, this extension needs to be registered INSTEAD of the DataPlaneTransferSyncExtension
 * although we may manage to formulate its as an addition in the near future.
 */
@Extension(value = HttpProtocolsExtension.NAME)
public class HttpProtocolsExtension implements ServiceExtension {
    
    public static final String NAME = "Knowledge Agents Http Protocols Extension";

    @Inject
    private RemoteMessageDispatcherRegistry dispatcherRegistry;

    @Inject
    private DataFlowManager dataFlowManager;

    @Inject
    private EndpointDataReferenceTransformerRegistry transformerRegistry;

    @Inject
    private Clock clock;

    @Inject
    private DataEncrypter dataEncrypter;

    @Inject
    private KeyPairWrapper keyPairWrapper;

    @Inject
    private ConsumerPullTransferProxyResolver proxyResolver;

    @Inject
    private TypeManager typeManager;

    @Override
    public String name() {
        return NAME;
    }

    @Override
    public void initialize(ServiceExtensionContext context) {
        var proxyReferenceService = createProxyReferenceService(context, typeManager);
        DataFlowControllerRegistry prioControllerReg=new DataFlowControllerRegistry(context.getMonitor());
        var flowController = new HttpProviderProxyDataFlowController(context.getConnectorId(), proxyResolver, dispatcherRegistry, proxyReferenceService);
        prioControllerReg.registerWithPriority(dataFlowManager,flowController);

        EndpointTransformerRegistry prioTransformerReg=new EndpointTransformerRegistry(context.getMonitor());
        var consumerProxyTransformer = new HttpTransferConsumerProxyTransformer(context.getMonitor(),proxyResolver, proxyReferenceService);
        prioTransformerReg.registerWithPriority(transformerRegistry,consumerProxyTransformer);
    }

    /**
     * Creates service generating {@link org.eclipse.edc.spi.types.domain.edr.EndpointDataReference} corresponding
     * to a http proxy.
     */
    protected HttpTransferProxyReferenceService createProxyReferenceService(ServiceExtensionContext context, TypeManager typeManager) {
        var tokenValiditySeconds = context.getConfig().getLong(TOKEN_VALIDITY_SECONDS, DEFAULT_TOKEN_VALIDITY_SECONDS);
        var tokenGenerationService = new TokenGenerationServiceImpl(keyPairWrapper.get().getPrivate());
        return new HttpTransferProxyReferenceService(context.getMonitor(),tokenGenerationService, typeManager, tokenValiditySeconds, dataEncrypter, clock);
    }

}

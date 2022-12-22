package io.catenax.knowledge.dataspace.edc;

import org.eclipse.dataspaceconnector.spi.message.RemoteMessageDispatcherRegistry;
import org.eclipse.dataspaceconnector.transfer.dataplane.spi.proxy.DataPlaneTransferProxyReferenceService;
import org.eclipse.dataspaceconnector.transfer.dataplane.sync.flow.ProviderDataPlaneProxyDataFlowController;
import org.eclipse.dataspaceconnector.transfer.dataplane.sync.proxy.DataPlaneTransferProxyResolver;

/**
 * Subclass of provider data plane proxy data flow
 * in order to be able to deploy alongside "HttpProxy"
 * TODO implement "HttpProtocolsProxy"
 */
public class HttpProviderProxyDataFlowController extends ProviderDataPlaneProxyDataFlowController {
    
    public HttpProviderProxyDataFlowController(String connectorId,
                                                    DataPlaneTransferProxyResolver proxyResolver,
                                                    RemoteMessageDispatcherRegistry dispatcherRegistry,
                                                    DataPlaneTransferProxyReferenceService proxyReferenceService) {
        super(connectorId,proxyResolver,dispatcherRegistry,proxyReferenceService);
    }
    
}

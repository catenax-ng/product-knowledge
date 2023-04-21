//
// EDC Control Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import org.eclipse.edc.connector.transfer.dataplane.flow.ConsumerPullTransferDataFlowController;
import org.eclipse.edc.spi.message.RemoteMessageDispatcherRegistry;
import org.eclipse.edc.connector.transfer.dataplane.proxy.ConsumerPullTransferProxyResolver;
import org.eclipse.edc.connector.transfer.dataplane.spi.proxy.ConsumerPullTransferEndpointDataReferenceService;
import org.eclipse.edc.connector.transfer.spi.types.DataRequest;
import org.eclipse.edc.spi.types.domain.DataAddress;

/**
 * Subclass of provider data plane proxy data flow
 * in order to be able to deploy "HttpProcols" alongside "HttpProxy"
 */
public class HttpProviderProxyDataFlowController extends ConsumerPullTransferDataFlowController {
    
    /**
     * constructor
     * @param connectorId of the source connector
     * @param proxyResolver helping to find sinks and sources
     * @param dispatcherRegistry where to register dispatch messages
     * @param proxyReferenceService helping to build proxy reference addresses
     */
    public HttpProviderProxyDataFlowController(String connectorId,
                                               ConsumerPullTransferProxyResolver proxyResolver,
                                               RemoteMessageDispatcherRegistry dispatcherRegistry,
                                               ConsumerPullTransferEndpointDataReferenceService proxyReferenceService) {
        super(connectorId,proxyResolver,proxyReferenceService,dispatcherRegistry);
    }

    /**
     * only handle the parallel http-protocols sync transfer not
     * to collide with the usual http-proxy sync.
     */
    @Override
    public boolean canHandle(DataRequest dataRequest, DataAddress contentAddress) {
        return HttpProtocolsConstants.TRANSFER_TYPE.equals(dataRequest.getDestinationType());
    }
    
}

package io.catenax.knowledge.dataspace.edc;

import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.result.Result;
import org.eclipse.dataspaceconnector.spi.transfer.edr.EndpointDataReferenceTransformer;
import org.eclipse.dataspaceconnector.spi.types.domain.DataAddress;
import org.eclipse.dataspaceconnector.spi.types.domain.HttpDataAddress;
import org.eclipse.dataspaceconnector.spi.types.domain.edr.EndpointDataReference;
import org.eclipse.dataspaceconnector.transfer.dataplane.spi.proxy.DataPlaneTransferProxyCreationRequest;
import org.eclipse.dataspaceconnector.transfer.dataplane.spi.proxy.DataPlaneTransferProxyReferenceService;
import org.eclipse.dataspaceconnector.transfer.dataplane.sync.proxy.DataPlaneTransferProxyResolver;
import org.jetbrains.annotations.NotNull;

import static java.lang.String.format;
import static org.eclipse.dataspaceconnector.transfer.dataplane.spi.DataPlaneTransferConstants.CONTRACT_ID;

/**
 * a consumer side proxy transformer which uses the "protocol" field in the EDR
 * to determine the type of HttpAddress (and hence the type of proxies/sinks/sources to build)
 * If registered alongside other transformers, it behaves well (unless the other transformer does not 
 * care about the edr).
 */
public class HttpTransferConsumerProxyTransformer implements EndpointDataReferenceTransformer {

    protected final DataPlaneTransferProxyResolver proxyResolver;
    protected final DataPlaneTransferProxyReferenceService proxyReferenceCreator;
    protected final Monitor monitor;

    /**
     * create a new transformer
     * @param proxyResolver
     * @param proxyCreator
     */
    public HttpTransferConsumerProxyTransformer(Monitor monitor, DataPlaneTransferProxyResolver proxyResolver, DataPlaneTransferProxyReferenceService proxyCreator) {
        this.proxyResolver = proxyResolver;
        this.proxyReferenceCreator = proxyCreator;
        this.monitor=monitor;
    }

    /**
     * access edr extension
     * @param edr
     * @return protocol part
     */
    protected String getProtocol(@NotNull EndpointDataReference edr) {
        return edr.getProperties().get(HttpProtocolsConstants.PROTOCOL_ID);
    }

    /**
     * only responsble for extended edrs
     */
    @Override
    public boolean canHandle(@NotNull EndpointDataReference edr) {
        String protocol=getProtocol(edr);
        var canHandle=(protocol!=null && !protocol.isEmpty());
        monitor.debug(String.format("Checking handability of edr %s with protocol %s delivered %b",edr,protocol,canHandle));
        return canHandle;
    }

    /**
     * create a new data reference from a given edr
     */
    @Override
    public Result<EndpointDataReference> transform(@NotNull EndpointDataReference edr) {
        var address = toHttpDataAddress(edr);
        monitor.debug(String.format("Derived address %s with protocol %s for edr %s",address,address.getType(),edr));
        var contractId = edr.getProperties().get(CONTRACT_ID);
        if (contractId == null) {
            return Result.failure(format("Cannot transform endpoint data reference with id %s as contract id is missing", edr.getId()));
        }
        var proxyUrl = proxyResolver.resolveProxyUrl(address);
        if (proxyUrl.failed()) {
            return Result.failure(format("Failed to resolve proxy url for endpoint data reference %s\n %s", edr.getId(), String.join(",", proxyUrl.getFailureMessages())));
        }
        var builder = DataPlaneTransferProxyCreationRequest.Builder.newInstance()
                .id(edr.getId())
                .contentAddress(address)
                .proxyEndpoint(proxyUrl.getContent())
                .contractId(contractId);
        edr.getProperties().forEach(builder::property);
        return proxyReferenceCreator.createProxyReference(builder.build());
    }

    /**
     * convert edr into a typed dataaddress
     * @param edr
     * @return dataddress
     */
    protected DataAddress toHttpDataAddress(EndpointDataReference edr) {
        DataAddress.Builder addressBuilder= HttpDataAddress.Builder.newInstance()
                .baseUrl(edr.getEndpoint())
                .authKey(edr.getAuthKey())
                .authCode(edr.getAuthCode())
                .proxyBody(Boolean.TRUE.toString())
                .proxyPath(Boolean.TRUE.toString())
                .proxyMethod(Boolean.TRUE.toString())
                .proxyQueryParams(Boolean.TRUE.toString())
                .type(getProtocol(edr));
        return HttpDataAddressBuilder.build(addressBuilder);
    }
}

package io.catenax.knowledge.dataspace.edc;

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

public class HttpTransferConsumerProxyTransformer implements EndpointDataReferenceTransformer {

    private final DataPlaneTransferProxyResolver proxyResolver;
    private final DataPlaneTransferProxyReferenceService proxyReferenceCreator;
    private java.lang.reflect.Field addressField=null;

    public HttpTransferConsumerProxyTransformer(DataPlaneTransferProxyResolver proxyResolver, DataPlaneTransferProxyReferenceService proxyCreator) {
        this.proxyResolver = proxyResolver;
        this.proxyReferenceCreator = proxyCreator;
        try {
            addressField=DataAddress.Builder.class.getField("address");
            addressField.trySetAccessible();
        } catch(SecurityException e) {
        } catch(NoSuchFieldException e) {
        }
    }

    protected String getProtocol(@NotNull EndpointDataReference edr) {
        return edr.getProperties().get(HttpProtocolsConstants.PROTOCOL_ID);
    }

    @Override
    public boolean canHandle(@NotNull EndpointDataReference edr) {
        String protocol=getProtocol(edr);
        return (protocol!=null && !protocol.isEmpty());
    }


    @Override
    public Result<EndpointDataReference> transform(@NotNull EndpointDataReference edr) {
        var address = toHttpDataAddress(edr);
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

    private DataAddress toHttpDataAddress(EndpointDataReference edr) {
        DataAddress.Builder addressBuilder= HttpDataAddress.Builder.newInstance()
                .baseUrl(edr.getEndpoint())
                .authKey(edr.getAuthKey())
                .authCode(edr.getAuthCode())
                .proxyBody(Boolean.TRUE.toString())
                .proxyPath(Boolean.TRUE.toString())
                .proxyMethod(Boolean.TRUE.toString())
                .proxyQueryParams(Boolean.TRUE.toString())
                .type(getProtocol(edr));
        if(addressField!=null) {
            try {
                return (DataAddress) addressField.get(addressBuilder);
            } catch(IllegalAccessException e) {
            } 
        } 
        return addressBuilder.build();
    }
}

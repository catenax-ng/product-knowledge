package io.catenax.knowledge.dataspace.edc;

import static org.eclipse.dataspaceconnector.transfer.dataplane.spi.DataPlaneTransferConstants.CONTRACT_ID;

import jakarta.ws.rs.core.HttpHeaders;
import org.eclipse.dataspaceconnector.spi.jwt.TokenGenerationService;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.result.Result;
import org.eclipse.dataspaceconnector.spi.types.TypeManager;
import org.eclipse.dataspaceconnector.spi.types.domain.edr.EndpointDataReference;
import org.eclipse.dataspaceconnector.transfer.dataplane.spi.proxy.DataPlaneTransferProxyCreationRequest;
import org.eclipse.dataspaceconnector.transfer.dataplane.spi.proxy.DataPlaneTransferProxyReferenceService;
import org.eclipse.dataspaceconnector.transfer.dataplane.sync.proxy.DataPlaneProxyTokenDecorator;
import org.eclipse.dataspaceconnector.transfer.dataplane.spi.security.DataEncrypter;
import org.jetbrains.annotations.NotNull;
import java.time.Clock;
import java.util.Date;
import java.util.HashMap;

import static org.eclipse.dataspaceconnector.transfer.dataplane.spi.DataPlaneTransferConstants.CONTRACT_ID;

/**
 * service to create new proxy references from a given asset
 */
public class HttpTransferProxyReferenceService implements DataPlaneTransferProxyReferenceService {

    protected final TokenGenerationService tokenGenerationService;
    protected final TypeManager typeManager;
    protected final long tokenValiditySeconds;
    protected final DataEncrypter dataEncrypter;
    protected final Clock clock;
    protected final Monitor monitor;

    public HttpTransferProxyReferenceService(Monitor monitor, TokenGenerationService tokenGenerationService, TypeManager typeManager, long tokenValiditySeconds, DataEncrypter dataEncrypter, Clock clock) {
        this.tokenGenerationService = tokenGenerationService;
        this.typeManager = typeManager;
        this.tokenValiditySeconds = tokenValiditySeconds;
        this.dataEncrypter = dataEncrypter;
        this.clock = clock;
        this.monitor=monitor;
    }
    
    /**
     * Creates an {@link EndpointDataReference} targeting public API of the provided Data Plane so that it is used
     * as a proxy to query the data from the data source. Make sure that the protocol is taken over from the content address type
     */
    @Override
    public Result<EndpointDataReference> createProxyReference(@NotNull DataPlaneTransferProxyCreationRequest request) {
        var encryptedDataAddress = dataEncrypter.encrypt(typeManager.writeValueAsString(request.getContentAddress()));
        var decorator = new DataPlaneProxyTokenDecorator(Date.from(clock.instant().plusSeconds(tokenValiditySeconds)), request.getContractId(), encryptedDataAddress);
        var tokenGenerationResult = tokenGenerationService.generate(decorator);
        if (tokenGenerationResult.failed()) {
            return Result.failure(tokenGenerationResult.getFailureMessages());
        }

        var props = new HashMap<>(request.getProperties());
        var contractId=request.getContractId();
        props.put(CONTRACT_ID, contractId);
        // CGJ expose the sub-protocol (standard: HttpData)
        // for clients to set the request type correctly
        var sourceType=request.getContentAddress().getType();
        props.put(HttpProtocolsConstants.PROTOCOL_ID, sourceType);

        monitor.debug(String.format("Put source type %s into proxy reference for contract %s",sourceType,contractId));

        var builder = EndpointDataReference.Builder.newInstance()
                .id(request.getId())
                .endpoint(request.getProxyEndpoint())
                .authKey(HttpHeaders.AUTHORIZATION)
                .authCode(tokenGenerationResult.getContent().getToken())
                .properties(props);
        return Result.success(builder.build());
    }
}

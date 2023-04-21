//
// EDC Control Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import jakarta.ws.rs.core.HttpHeaders;
import org.eclipse.edc.connector.transfer.dataplane.proxy.ConsumerPullTransferTokenDecorator;
import org.eclipse.edc.connector.transfer.dataplane.spi.proxy.ConsumerPullTransferEndpointDataReferenceCreationRequest;
import org.eclipse.edc.connector.transfer.dataplane.spi.proxy.ConsumerPullTransferEndpointDataReferenceService;
import org.eclipse.edc.connector.transfer.dataplane.spi.security.DataEncrypter;
import org.eclipse.edc.jwt.spi.TokenGenerationService;
import org.eclipse.edc.spi.monitor.Monitor;
import org.eclipse.edc.spi.result.Result;
import org.eclipse.edc.spi.types.TypeManager;
import org.eclipse.edc.spi.types.domain.edr.EndpointDataReference;
import org.jetbrains.annotations.NotNull;

import java.time.Clock;
import java.util.Date;
import java.util.HashMap;

import static org.eclipse.edc.connector.transfer.dataplane.spi.TransferDataPlaneConstants.CONTRACT_ID;

/**
 * service to create new proxy references from a given asset
 */
public class HttpTransferProxyReferenceService implements ConsumerPullTransferEndpointDataReferenceService {

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
    public Result<EndpointDataReference> createProxyReference(@NotNull ConsumerPullTransferEndpointDataReferenceCreationRequest request) {
        var encryptedDataAddress = dataEncrypter.encrypt(typeManager.writeValueAsString(request.getContentAddress()));
        var decorator = new ConsumerPullTransferTokenDecorator(Date.from(clock.instant().plusSeconds(tokenValiditySeconds)), request.getContractId(), encryptedDataAddress);
        var tokenGenerationResult = tokenGenerationService.generate(decorator);
        if (tokenGenerationResult.failed()) {
            return Result.failure(tokenGenerationResult.getFailureMessages());
        }

        var props = new HashMap<>(request.getProperties());
        props.put(CONTRACT_ID, request.getContractId());

        // CGJ expose the sub-protocol (standard: HttpData)
        // for clients to set the request type correctly
        var sourceType=request.getContentAddress().getType();
        props.put(HttpProtocolsConstants.PROTOCOL_ID, sourceType);

        var builder = EndpointDataReference.Builder.newInstance()
                .id(request.getId())
                .endpoint(request.getProxyEndpoint())
                .authKey(HttpHeaders.AUTHORIZATION)
                .authCode(tokenGenerationResult.getContent().getToken())
                .properties(props);
        return Result.success(builder.build());
    }
}

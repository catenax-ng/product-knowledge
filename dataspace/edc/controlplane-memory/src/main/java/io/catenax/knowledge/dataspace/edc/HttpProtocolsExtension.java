package io.catenax.knowledge.dataspace.edc;

import org.eclipse.dataspaceconnector.core.jwt.TokenGenerationServiceImpl;
import org.eclipse.dataspaceconnector.core.jwt.TokenValidationRulesRegistryImpl;
import org.eclipse.dataspaceconnector.core.jwt.TokenValidationServiceImpl;
import org.eclipse.dataspaceconnector.dataplane.selector.client.DataPlaneSelectorClient;
import org.eclipse.dataspaceconnector.runtime.metamodel.annotation.EdcSetting;
import org.eclipse.dataspaceconnector.runtime.metamodel.annotation.Extension;
import org.eclipse.dataspaceconnector.runtime.metamodel.annotation.Inject;
import org.eclipse.dataspaceconnector.spi.WebService;
import org.eclipse.dataspaceconnector.spi.contract.negotiation.store.ContractNegotiationStore;
import org.eclipse.dataspaceconnector.spi.message.RemoteMessageDispatcherRegistry;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.security.PrivateKeyResolver;
import org.eclipse.dataspaceconnector.spi.security.Vault;
import org.eclipse.dataspaceconnector.spi.system.ServiceExtension;
import org.eclipse.dataspaceconnector.spi.system.ServiceExtensionContext;
import org.eclipse.dataspaceconnector.spi.system.configuration.Config;
import org.eclipse.dataspaceconnector.spi.transfer.edr.EndpointDataReferenceTransformerRegistry;
import org.eclipse.dataspaceconnector.spi.transfer.flow.DataFlowManager;
import org.eclipse.dataspaceconnector.spi.types.TypeManager;
import org.eclipse.dataspaceconnector.transfer.dataplane.spi.proxy.DataPlaneTransferProxyReferenceService;
import org.eclipse.dataspaceconnector.transfer.dataplane.spi.security.DataEncrypter;
import org.eclipse.dataspaceconnector.transfer.dataplane.sync.api.DataPlaneTokenValidationApiController;
import org.eclipse.dataspaceconnector.transfer.dataplane.sync.flow.ProviderDataPlaneProxyDataFlowController;
import org.eclipse.dataspaceconnector.transfer.dataplane.sync.proxy.DataPlaneTransferConsumerProxyTransformer;
import org.eclipse.dataspaceconnector.transfer.dataplane.sync.proxy.DataPlaneTransferProxyReferenceServiceImpl;
import org.eclipse.dataspaceconnector.transfer.dataplane.sync.proxy.DataPlaneTransferProxyResolverImpl;
import org.eclipse.dataspaceconnector.transfer.dataplane.sync.security.PublicKeyParser;
import org.eclipse.dataspaceconnector.transfer.dataplane.sync.validation.ContractValidationRule;
import org.eclipse.dataspaceconnector.transfer.dataplane.sync.validation.ExpirationDateValidationRule;

import java.security.KeyPair;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.time.Clock;
import java.util.Objects;

import static org.eclipse.dataspaceconnector.transfer.dataplane.sync.DataPlaneTransferSyncConfig.DATA_PROXY_TOKEN_VALIDITY_SECONDS;
import static org.eclipse.dataspaceconnector.transfer.dataplane.sync.DataPlaneTransferSyncConfig.DEFAULT_DATA_PROXY_TOKEN_VALIDITY_SECONDS;
import static org.eclipse.dataspaceconnector.transfer.dataplane.sync.DataPlaneTransferSyncConfig.TOKEN_SIGNER_PRIVATE_KEY_ALIAS;
import static org.eclipse.dataspaceconnector.transfer.dataplane.sync.DataPlaneTransferSyncConfig.TOKEN_VERIFIER_PUBLIC_KEY_ALIAS;

import org.eclipse.dataspaceconnector.spi.transfer.edr.EndpointDataReferenceReceiverRegistry;
import dev.failsafe.RetryPolicy;
import okhttp3.OkHttpClient;

import java.util.Map;

import org.eclipse.dataspaceconnector.receiver.http.HttpEndpointDataReferenceReceiver;

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

    @EdcSetting
    protected static final String DPF_SELECTOR_STRATEGY = "edc.transfer.client.selector.strategy";
    protected static final String API_CONTEXT_ALIAS = "validation";
    @Inject
    protected DataPlaneSelectorClient selectorClient;

    @Inject
    protected ContractNegotiationStore contractNegotiationStore;

    @Inject
    protected RemoteMessageDispatcherRegistry dispatcherRegistry;

    @Inject
    protected WebService webService;

    @Inject
    protected DataFlowManager dataFlowManager;

    @Inject
    protected EndpointDataReferenceTransformerRegistry transformerRegistry;

    @Inject
    protected Vault vault;

    @Inject
    protected Clock clock;

    @Inject
    protected PrivateKeyResolver privateKeyResolver;

    @Inject
    protected DataEncrypter dataEncrypter;

    @Inject
    protected EndpointDataReferenceReceiverRegistry receiverRegistry;

    @Inject
    protected OkHttpClient httpClient;
    @Inject
    @SuppressWarnings("rawtypes")
    protected RetryPolicy retryPolicy;

    @Override
    public String name() {
        return NAME;
    }

    @Override
    public void initialize(ServiceExtensionContext context) {
        var keyPair = createKeyPair(context);
        var selectorStrategy = context.getSetting(DPF_SELECTOR_STRATEGY, "random");

        var proxyResolver = new DataPlaneTransferProxyResolverImpl(selectorClient, selectorStrategy);

        var controller = createTokenValidationApiController(keyPair.getPublic(), dataEncrypter, context.getTypeManager());
        webService.registerResource(API_CONTEXT_ALIAS, controller);

        var proxyReferenceService = createProxyReferenceService(context, keyPair.getPrivate(), dataEncrypter);
        var flowController = new HttpProviderProxyDataFlowController(context.getConnectorId(), proxyResolver, dispatcherRegistry, proxyReferenceService);
        dataFlowManager.register(flowController);

        var consumerProxyTransformer = new HttpTransferConsumerProxyTransformer(context.getMonitor(),proxyResolver, proxyReferenceService);
        transformerRegistry.registerTransformer(consumerProxyTransformer);

        Config receiverConfig=context.getConfig("edc.receiver.http");
        Config endpoints=receiverConfig.getConfig("endpoints");
        Config authKeys=receiverConfig.getConfig("auth-keys");
        Config authCodes=receiverConfig.getConfig("auth-keys");
        for(Map.Entry<String,String> endpoint : endpoints.getEntries().entrySet()) {
            String name = endpoint.getKey();
            String url = endpoint.getValue();
            HttpEndpointDataReferenceReceiver.Builder builder=HttpEndpointDataReferenceReceiver.Builder.newInstance()
                    .endpoint(url)
                    .httpClient(httpClient)
                    .typeManager(context.getTypeManager())
                    .retryPolicy(retryPolicy)
                    .monitor(context.getMonitor());
            if(authKeys.hasKey(name)) {
                builder=builder.authHeader(authKeys.getString(name), authCodes.getString(name,""));
            }
            HttpEndpointDataReferenceReceiver receiver=builder.build();
            receiverRegistry.registerReceiver(receiver);
        }
    }

    /**
     * Creates service generating {@link org.eclipse.dataspaceconnector.spi.types.domain.edr.EndpointDataReference} corresponding
     * to a http proxy.
     */
    protected DataPlaneTransferProxyReferenceService createProxyReferenceService(ServiceExtensionContext context, PrivateKey privateKey, DataEncrypter encrypter) {
        var tokenValiditySeconds = context.getSetting(DATA_PROXY_TOKEN_VALIDITY_SECONDS, DEFAULT_DATA_PROXY_TOKEN_VALIDITY_SECONDS);
        var tokenGenerationService = new TokenGenerationServiceImpl(privateKey);
        return new HttpTransferProxyReferenceService(context.getMonitor(),tokenGenerationService, context.getTypeManager(), tokenValiditySeconds, encrypter, clock);
    }

    /**
     * Register the API controller that is used for validating tokens received in input of Data Plane API.
     */
    protected DataPlaneTokenValidationApiController createTokenValidationApiController(PublicKey publicKey, DataEncrypter encrypter, TypeManager typeManager) {
        var registry = new TokenValidationRulesRegistryImpl();
        registry.addRule(new ContractValidationRule(contractNegotiationStore, clock));
        registry.addRule(new ExpirationDateValidationRule(clock));
        var tokenValidationService = new TokenValidationServiceImpl(id -> publicKey, registry);
        return new DataPlaneTokenValidationApiController(tokenValidationService, encrypter, typeManager);
    }

    /**
     * Build the private/public key pair used for signing/verifying token generated by this extension.
     */
    protected KeyPair createKeyPair(ServiceExtensionContext context) {
        var config = context.getConfig();

        var privateKeyAlias = config.getString(TOKEN_SIGNER_PRIVATE_KEY_ALIAS);
        var privateKey = privateKeyResolver.resolvePrivateKey(privateKeyAlias, PrivateKey.class);
        Objects.requireNonNull(privateKey, "Failed to resolve private key with alias: " + privateKeyAlias);

        var publicKeyAlias = config.getString(TOKEN_VERIFIER_PUBLIC_KEY_ALIAS);
        var publicKeyPem = vault.resolveSecret(publicKeyAlias);
        Objects.requireNonNull(publicKeyPem, "Failed to resolve public key secret with alias: " + publicKeyPem);
        var publicKey = PublicKeyParser.from(publicKeyPem);
        return new KeyPair(publicKey, privateKey);
    }
}

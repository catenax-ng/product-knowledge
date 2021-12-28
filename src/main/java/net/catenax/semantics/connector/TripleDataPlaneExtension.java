/*
 * Copyright (c) 2021 T-Systems International GmbH (Catena-X Consortium)
 *
 * See the AUTHORS file(s) distributed with this work for additional
 * information regarding authorship.
 *
 * See the LICENSE file(s) distributed with this work for
 * additional information regarding license terms.
 */

package net.catenax.semantics.connector;

import org.eclipse.dataspaceconnector.dataloading.AssetLoader;
import org.eclipse.dataspaceconnector.ids.spi.daps.DapsService;
import org.eclipse.dataspaceconnector.ids.spi.policy.IdsPolicyService;
import org.eclipse.dataspaceconnector.spi.asset.AssetIndex;
import org.eclipse.dataspaceconnector.spi.asset.DataAddressResolver;
import org.eclipse.dataspaceconnector.spi.iam.IdentityService;
import org.eclipse.dataspaceconnector.spi.policy.PolicyRegistry;
import org.eclipse.dataspaceconnector.spi.protocol.web.WebService;
import org.eclipse.dataspaceconnector.spi.security.Vault;
import org.eclipse.dataspaceconnector.spi.system.ServiceExtension;
import org.eclipse.dataspaceconnector.spi.system.ServiceExtensionContext;
import org.eclipse.dataspaceconnector.spi.transfer.TransferProcessManager;
import org.eclipse.dataspaceconnector.spi.transfer.flow.DataFlowManager;
import org.eclipse.dataspaceconnector.spi.types.domain.asset.Asset;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.DataAddress;

import java.util.Set;

/**
 * API and dataflow extensions for synchronous querying triple data via SPARQL and
 * (planned) triple data eventing through asynchronous file transfer
 */
public class TripleDataPlaneExtension implements ServiceExtension {
    public static final String CROSS_CONNECTOR_POLICY = "co-policy-central";
    public static final String EDC_ASSET_PATH = "net.catenax.semantics.connector.assets";
    public static final String ASSET_ENDPOINT_PROPERTY = "net.catenax.semantics.connector.asset-endpoint";
    public static final String TYPE_PROPERTY = "type";
    public static final String LOCATION_PROPERTY = "location";

    /**
     * connector related headers in the data plane
     */
    public static final String CONNECTOR_HEADER="catenax-connector-context";
    public static final String AGREEMENT_HEADER="catenax-security-token";
    public static final String CONNECTOR_CHAIN_DELIMITER=",";
    public static final String CORRELATION_HEADER="catenax-correlation-id";

    @Override
    public Set<String> requires() {
        return Set.of("edc:webservice", "edc:ids:core", PolicyRegistry.FEATURE, DataAddressResolver.FEATURE, AssetIndex.FEATURE);
    }

    @Override
    public void initialize(ServiceExtensionContext context) {

        var monitor=context.getMonitor();
        monitor.info("Initializing Triple Data Plane");

        var webService = context.getService(WebService.class);
        var dapsService = context.getService(DapsService.class);
        var assetIndex = context.getService(AssetIndex.class);
        var dataResolver = context.getService(DataAddressResolver.class);
        var policyService = context.getService(IdsPolicyService.class);
        var vault = context.getService(Vault.class);
        var policyRegistry = context.getService(PolicyRegistry.class);
        var dataFlowMgr = context.getService(DataFlowManager.class);
        var processManager = context.getService(TransferProcessManager.class);
        var identityService = context.getService(IdentityService.class);
        var connectorId= context.getSetting("edc.ids.id",context.getConnectorId());
        var loader = context.getService(AssetLoader.class);

        var flowController = new SparqlSynchronousDataflow(monitor, identityService, connectorId, dataResolver);

        monitor.info(String.format("Registering Synchronous SparQL Query Dataflow %s",flowController));
        dataFlowMgr.register(flowController);

        var apiController = new SparqlSynchronousApi(dapsService,
                assetIndex,
                processManager,
                policyService,
                policyRegistry,
                vault,
                monitor);
        monitor.info(String.format("Registering Synchronous SparQL Query Controller %s",apiController));
        webService.registerController(apiController);

        var eventController = new TurtleAsynchronousApi(
                dataResolver,
                dapsService,
                assetIndex,
                processManager,
                policyService,
                policyRegistry,
                vault,
                monitor,
                connectorId);
        monitor.info(String.format("Registering Asynchronous Turtle Event Controller %s",eventController));
        webService.registerController(eventController);

        policyService.registerRequestPermissionFunction(ConnectorOriginMatchRequestPermission.PERMISSION_NAME,new ConnectorOriginMatchRequestPermission());

        var crossPolicy = CrossConnectorPolicy.createCrossConnectorPolicy(CROSS_CONNECTOR_POLICY,"idsc:USE","urn:connector:([a-z0.9A-Z\\-].*):semantics:catenax:net");

        monitor.info(String.format("Registering Delegation Policy %s",crossPolicy));
        policyRegistry.registerPolicy(crossPolicy);

        String[] assets = context.getSetting(EDC_ASSET_PATH,"").split(";");
        String port=context.getSetting("web.http.port","80");
        if(assets.length>1 || !assets[0].isEmpty()) {
            for(String assetSpec : assets) {
                String[] assetComponents = new String[2];
                assetComponents[0]=assetSpec.substring(0,assetSpec.indexOf("@"));
                assetComponents[1]=assetSpec.substring(assetSpec.indexOf("@")+1);
                DataAddress dataAddress = DataAddress.Builder.newInstance()
                   .property(TYPE_PROPERTY, "sparql-request")
                   .property(LOCATION_PROPERTY, String.format("http://localhost:%s/api/sparql/%s", port, assetComponents[0]))
                   .property(ASSET_ENDPOINT_PROPERTY,assetComponents[1])
                   .build();
                String assetId = assetComponents[0];
                String policy=CROSS_CONNECTOR_POLICY;
                Asset asset = Asset.Builder.newInstance().id(assetId).policyId(policy).build();

                monitor.info(String.format("Registering Asset %s under policy %s", assetId,policy));
                loader.accept(asset, dataAddress);
            }
        }
    }

}

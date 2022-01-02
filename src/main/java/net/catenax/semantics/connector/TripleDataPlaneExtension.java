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
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.DataRequest;

import java.util.Set;

/**
 * API and dataflow extensions for synchronous querying triple data via SPARQL and
 * (planned) triple data eventing through asynchronous file transfer
 */
public class TripleDataPlaneExtension implements ServiceExtension {
    public static final String CROSS_CONNECTOR_POLICY = "co-policy-central";
    public static final String EDC_ASSET_PATH = "net.catenax.semantics.connector.assets";
    public static final String EDC_REMOTE_ASSET_PATH = "net.catenax.semantics.connector.remote.assets";
    public static final String ASSET_ENDPOINT_PROPERTY = "net.catenax.semantics.connector.asset-endpoint";
    public static final String TYPE_PROPERTY = "type";
    public static final String LOCATION_PROPERTY = "location";
    public static final String GRAPH_PROPERTY = "graph";

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

    protected ServiceExtensionContext context;

    /**
     * initialize the triple plane extension
     * @arg context
     */
    @Override
    public void initialize(ServiceExtensionContext context) {
        this.context=context;
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
        String port=context.getSetting("web.http.port","80");

        var synchronousFlowController = new SparqlSynchronousDataflow(monitor, identityService, connectorId, dataResolver);

        monitor.info(String.format("Registering Synchronous SparQL Query Dataflow %s",synchronousFlowController));
        dataFlowMgr.register(synchronousFlowController);

        var asynchronousFlowController = new TurtleAsynchronousDataflow(monitor,identityService, connectorId, dataResolver);
        monitor.info(String.format("Registering Asynchronous Turtle Event Dataflow %s",asynchronousFlowController));
        dataFlowMgr.register(asynchronousFlowController);

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

        var crossConnectorConstraint=CrossConnectorPolicy.createCrossConnectorConstraint("urn:connector:([a-z0.9A-Z\\-].*):semantics:catenax:net");
        var crossPolicy = CrossConnectorPolicy.createPolicy(CROSS_CONNECTOR_POLICY,
            CrossConnectorPolicy.createPermission(CrossConnectorPolicy.USE_PERMISSION,crossConnectorConstraint),
            CrossConnectorPolicy.createPermission(CrossConnectorPolicy.DISTRIBUTE_PERMISSION,crossConnectorConstraint));

        monitor.info(String.format("Registering Delegation Policy %s",crossPolicy));
        policyRegistry.registerPolicy(crossPolicy);

        String[] assets = context.getSetting(EDC_ASSET_PATH,"").split(";");
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

    /**
     * start the triple plane extension
     * @arg context
     */
    @Override
    public void start() {
        var monitor=context.getMonitor();
        var processManager = context.getService(TransferProcessManager.class);
        var connectorId= context.getSetting("edc.ids.id",context.getConnectorId());
        String port=context.getSetting("web.http.port","80");

        String[] registrations = context.getSetting(EDC_REMOTE_ASSET_PATH,"").split(";");
        if(registrations.length>1 || !registrations[0].isEmpty()) {        
            for(String registrationSpec : registrations) {
                String[] registrationComponents=new String[2];
                registrationComponents[0]=registrationSpec.substring(0,registrationSpec.indexOf("@"));
                registrationComponents[1]=registrationSpec.substring(registrationSpec.indexOf("@")+1);
                String[] registrationKey =new String[2];
                registrationKey[0]=registrationComponents[0].substring(0,registrationComponents[0].indexOf("#"));
                registrationKey[1]=registrationComponents[0].substring(registrationComponents[0].indexOf("#")+1);
                
                var dataRequest = DataRequest.Builder.newInstance()
                    .id(java.util.UUID.randomUUID().toString()) //this is not relevant, thus can be random
                    .connectorAddress(registrationComponents[1]) //the address of the provider connector
                    .protocol("ids-rest") //must be ids-rest
                    .connectorId(connectorId)
                    .assetId(Asset.Builder.newInstance().id(registrationComponents[0]).policyId(CROSS_CONNECTOR_POLICY).build().getId())
                    .dataDestination(DataAddress.Builder.newInstance()
                        .type(TurtleAsynchronousDataflow.TURTLE_DATAFLOW_TYPE) //the provider uses this to select the correct DataFlowController
                        .property(LOCATION_PROPERTY, String.format("http://localhost:%s/api/turtle/%s", port, registrationKey[0])) //where we want the turtle event to be pushed
                        .property(GRAPH_PROPERTY,registrationKey[1])
                        .build())
                    .managedResources(false) //we do not need any provisioning
                    .build();

                var response = processManager.initiateConsumerRequest(dataRequest);

                monitor.info(String.format("Performed an event subscription data request to remote asset %s at connector %s with result %s",registrationComponents[0],registrationComponents[1],response));
            }
        }
    }

    @Override
    public void shutdown() {
    }
}

/*
 * Copyright (c) 2021-2022 T-Systems International GmbH (Catena-X Consortium)
 *
 * See the AUTHORS file(s) distributed with this work for additional
 * information regarding authorship.
 *
 * See the LICENSE file(s) distributed with this work for
 * additional information regarding license terms.
 */

package net.catenax.semantics.connector;

import net.catenax.semantics.connector.policy.ConnectorOriginMatchFunction;
import net.catenax.semantics.connector.policy.CrossConnectorPolicy;
import net.catenax.semantics.connector.policy.UnionAssetMatchFunction;
import net.catenax.semantics.connector.sparql.SparqlSynchronousApi;
import net.catenax.semantics.connector.sparql.SparqlSynchronousDataflow;
import net.catenax.semantics.connector.turtle.TurtleAsynchronousApi;
import net.catenax.semantics.connector.turtle.TurtleAsynchronousDataflow;
import net.catenax.semantics.triples.SparqlHelper;
import org.eclipse.dataspaceconnector.dataloading.AssetLoader;
import org.eclipse.dataspaceconnector.ids.spi.daps.DapsService;
import org.eclipse.dataspaceconnector.ids.spi.policy.IdsPolicyActions;
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
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.TransferType;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Set;

/**
 * API and dataflow extensions for synchronous querying triple data via SPARQL and
 * (planned) triple data eventing through asynchronous file transfer
 */
public class TripleDataPlaneExtension implements ServiceExtension {

    public static final TransferType TURTLE_TRANSFER=TransferType.Builder.transferType().isFinite(false).contentType(SparqlHelper.TURTLE_MEDIATYPE.toString()).build();

    public static final String CROSS_CONNECTOR_POLICY = "co-policy-central";
    public static final String SINGLE_CONNECTOR_POLICY = "co-policy-local";

    public static final String EDC_ASSET_PATH = "net.catenax.semantics.connector.assets";
    public static final String EDC_REMOTE_ASSET_PATH = "net.catenax.semantics.connector.remote.assets";
    public static final String ASSET_ENDPOINT_PROPERTY = "net.catenax.semantics.connector.asset-endpoint";

    /**
     * connector related headers in the data plane
     */
    public static final String CONNECTOR_HEADER="catenax-connector-context";
    public static final String AGREEMENT_HEADER="catenax-security-token";
    public static final String CORRELATION_HEADER="catenax-correlation-id";

    /**
     * data related properties in the connector plane
     */
    public static final String REQUEST_TYPE="catenax-request-type";
    public static final String TYPE_PROPERTY = "type";
    public static final String LOCATION_PROPERTY = "catenax-request-location";
    public static final String GRAPH_PROPERTY = "catenax-request-graph";
    public static final String AGREEMENT_PROPERTY = "catenax-request-token";

    @Override
    public Set<String> requires() {
        return Set.of("edc:webservice", "edc:ids:core", PolicyRegistry.FEATURE, DataAddressResolver.FEATURE, AssetIndex.FEATURE);
    }

    protected ServiceExtensionContext context;
    protected TurtleAsynchronousDataflow asynchronousFlowController;
    protected Method transferType;

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

        var internalService=new SparqlHelper(monitor);
        var synchronousFlowController = new SparqlSynchronousDataflow(monitor, identityService, connectorId, dataResolver, internalService);

        monitor.info(String.format("Registering Synchronous SparQL Query Dataflow %s",synchronousFlowController));
        dataFlowMgr.register(synchronousFlowController);

        asynchronousFlowController = new TurtleAsynchronousDataflow(monitor,identityService, connectorId, dataResolver);
        monitor.info(String.format("Registering Asynchronous Turtle Event Dataflow %s",asynchronousFlowController));
        dataFlowMgr.register(asynchronousFlowController);

        var idsController=new FederatedArtifactRequestController(
                dapsService,
                assetIndex,
                processManager,
                policyService,
                policyRegistry,
                vault,
                monitor);
        monitor.info(String.format("Registering IDS Request Controller %s",idsController));
        webService.registerController(idsController);


        var apiController = new SparqlSynchronousApi(dapsService,
                assetIndex,
                processManager,
                policyService,
                policyRegistry,
                vault,
                monitor,
                idsController,
                internalService);
        monitor.info(String.format("Registering Synchronous SparQL Query Controller %s",apiController));
        webService.registerController(apiController);

        var eventController = new TurtleAsynchronousApi(
                asynchronousFlowController,
                dataResolver,
                dapsService,
                assetIndex,
                processManager,
                policyService,
                policyRegistry,
                vault,
                monitor,
                internalService,
                connectorId);
        monitor.info(String.format("Registering Asynchronous Turtle Event Controller %s",eventController));
        webService.registerController(eventController);

        var comf = new ConnectorOriginMatchFunction();
        comf.register(policyService);

        var uamf = new UnionAssetMatchFunction();
        uamf.register(policyService);

        // match all connector chains
        var crossConnectorConstraint= CrossConnectorPolicy.
                createCrossConnectorConstraint("(urn:connector:([a-z0.9A-Z\\-].*):semantics:catenax:net)(;(urn:connector:([a-z0.9A-Z\\-].*):semantics:catenax:net))*",true);
        // match single local connector call
        var singleConnectorConstraint = CrossConnectorPolicy.
                createCrossConnectorConstraint(connectorId,true);
        // match single remote connector call
        var consumerConnectorConstraint=  CrossConnectorPolicy.createCrossConnectorConstraint("(urn:connector:([a-z0.9A-Z\\-].*):semantics:catenax:net)",true);

        // match all public assets
        var crossAssetConstraintCentral = CrossConnectorPolicy.createUnionAssetConstraint("urn:(x-arq|tenant1|tenant2|cx):(Default|Propagate|)[Gg]raph.*",false);
        // match all local assets
        var crossAssetConstraintLocal = CrossConnectorPolicy.
                createUnionAssetConstraint("urn:(x-arq|tenant1|tenant2|cx):(Default|Propagate|Private|)[Gg]raph.*",false);
        // match a single local asset
        var targetAssetConstraint = CrossConnectorPolicy.
                createUnionAssetConstraint("urn:(x-arq|tenant1|tenant2|cx):(Default|Propagate|Private|)[Gg]raph",true);

        // central read permission
        var readPermissionCentral = CrossConnectorPolicy.createPermission(IdsPolicyActions.READ_ACTION, List.of(),crossConnectorConstraint,crossAssetConstraintCentral);
        // local read permission
        var readPermissionLocal = CrossConnectorPolicy.createPermission(IdsPolicyActions.READ_ACTION, List.of(),singleConnectorConstraint,crossAssetConstraintLocal);

        // local insert and delete permissions
        var insertPermissionCentral =  CrossConnectorPolicy.createPermission(CrossConnectorPolicy.INSERT_ACTION,List.of(),crossConnectorConstraint);
        var insertPermission =  CrossConnectorPolicy.createPermission(CrossConnectorPolicy.INSERT_ACTION,List.of(),singleConnectorConstraint);
        var deletePermission =  CrossConnectorPolicy.createPermission(IdsPolicyActions.DELETE_ACTION,List.of(),singleConnectorConstraint);

        // a read permission duty for distribution
        var distributeReadObligation= CrossConnectorPolicy.createDuty(IdsPolicyActions.READ_ACTION, crossConnectorConstraint,crossAssetConstraintCentral);
        var distributePermission = CrossConnectorPolicy.createPermission(IdsPolicyActions.DISTRIBUTE_ACTION,List.of(distributeReadObligation),consumerConnectorConstraint);

        var crossPolicy = CrossConnectorPolicy.createPolicy(CROSS_CONNECTOR_POLICY,
            List.of(readPermissionCentral,readPermissionLocal,insertPermission,insertPermissionCentral,deletePermission,distributePermission),List.of(),List.of());
        var singlePolicy = CrossConnectorPolicy.createPolicy(SINGLE_CONNECTOR_POLICY,
                List.of(readPermissionLocal,insertPermission,deletePermission),List.of(),List.of());

        monitor.info(String.format("Registering Delegation Policy %s",crossPolicy));
        policyRegistry.registerPolicy(crossPolicy);

        monitor.info(String.format("Registering Delegation Policy %s",singlePolicy));
        policyRegistry.registerPolicy(singlePolicy);

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
                if(assetId.contains("Private")) {
                    policy=SINGLE_CONNECTOR_POLICY;
                }
                Asset asset = Asset.Builder.newInstance().id(assetId).policyId(policy).build();

                monitor.info(String.format("Registering Asset %s under policy %s", assetId,policy));
                loader.accept(asset, dataAddress);
            }
        }

        try {
            transferType = DataRequest.Builder.class.getDeclaredMethod("transferType", new Class[]{TransferType.class});
            transferType.setAccessible(true);
        } catch(Exception e) {
            throw new RuntimeException("Could not initialize TripleDataPlaneExtension",e);
        }
    }

    /**
     * start the triple plane extension
     * register remote assets (subscriptions)
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
                
                var dataRequestBuilder = DataRequest.Builder.newInstance()
                    .id(java.util.UUID.randomUUID().toString()) //this is not relevant, thus can be random
                    .connectorAddress(registrationComponents[1]) //the address of the provider connector
                    .protocol("ids-rest") //must be ids-rest
                    .connectorId(connectorId)
                    .assetId(Asset.Builder.newInstance().id(registrationComponents[0]).policyId(CROSS_CONNECTOR_POLICY).build().getId());

                // TODO let this setter be made public
                try {
                    dataRequestBuilder = (DataRequest.Builder) transferType.invoke(dataRequestBuilder, new Object[]{TURTLE_TRANSFER});
                } catch(Exception e) {
                    throw new RuntimeException("Could not start TripleDataPlaneExtension.",e);
                }

                var dataRequest=dataRequestBuilder
                    .dataDestination(DataAddress.Builder.newInstance()
                        .type(TurtleAsynchronousDataflow.TURTLE_DATAFLOW_TYPE) //the provider uses this to select the correct DataFlowController
                        .property(LOCATION_PROPERTY, String.format("http://localhost:%s/api/turtle/%s", port, registrationKey[0])) //where we want the turtle event to be pushed
                        .property(GRAPH_PROPERTY,registrationKey[1])
                        .property(AGREEMENT_PROPERTY,"mock-eu")
                        .property(REQUEST_TYPE,"SUBSCRIBE")
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
        asynchronousFlowController.shutdown();
    }
}

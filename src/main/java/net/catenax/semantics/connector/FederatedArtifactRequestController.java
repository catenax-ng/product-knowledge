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

import de.fraunhofer.iais.eis.ArtifactRequestMessage;
import de.fraunhofer.iais.eis.RejectionMessageBuilder;
import de.fraunhofer.iais.eis.RejectionReason;
import jakarta.ws.rs.core.Response;
import net.catenax.semantics.connector.policy.CrossConnectorPolicy;
import org.eclipse.dataspaceconnector.ids.api.transfer.ArtifactRequestController;
import org.eclipse.dataspaceconnector.ids.spi.daps.DapsService;
import org.eclipse.dataspaceconnector.ids.spi.policy.IdsPolicyService;
import org.eclipse.dataspaceconnector.policy.engine.PolicyEvaluationResult;
import org.eclipse.dataspaceconnector.policy.model.Policy;
import org.eclipse.dataspaceconnector.spi.asset.AssetIndex;
import org.eclipse.dataspaceconnector.spi.iam.VerificationResult;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.policy.PolicyRegistry;
import org.eclipse.dataspaceconnector.spi.security.Vault;
import org.eclipse.dataspaceconnector.spi.transfer.TransferProcessManager;
import org.eclipse.dataspaceconnector.spi.types.domain.asset.Asset;

import java.util.List;
import java.util.Map;

/**
 * An extended artifact request controller which allows/checks queries against
 * a federated set of assets.
 */
public class FederatedArtifactRequestController extends ArtifactRequestController {

    final protected Monitor monitor;
    final protected IdsPolicyService policyService;

    /**
     * create a new federated artifact request controller
     *
     * @param dapsService
     * @param assetIndex
     * @param processManager
     * @param policyService
     * @param policyRegistry
     * @param vault
     * @param monitor
     */
    public FederatedArtifactRequestController(
            DapsService dapsService,
            AssetIndex assetIndex,
            TransferProcessManager processManager,
            IdsPolicyService policyService,
            PolicyRegistry policyRegistry,
            Vault vault,
            Monitor monitor) {
        super(dapsService, assetIndex, processManager, policyService, policyRegistry, vault, monitor);
        this.monitor = monitor;
        this.policyService = policyService;
    }

    /**
     * federated asset resolution and policy check
     *
     * @param message request message
     * @return a pair of the resolved asset and an optional failure response
     */
    @Override
    protected Asset resolveAndVerifyAsset(ArtifactRequestMessage message, VerificationResult verificationResult) throws ResponseException {
        var urn = message.getRequestedArtifact().toString();
        var assetName = urn.substring(0, urn.indexOf("#"));
        var graphNames = List.of(urn.substring(urn.indexOf("#") + 1).split(";"));
        Asset nextAsset = null;
        for (String assetGraph : graphNames) {
            assetGraph=assetGraph.replace("%23","#");
            String dataUrn = assetName + "#" + assetGraph;
            nextAsset = resolveAsset(dataUrn);
            monitor.debug(() -> "Received artifact request for: " + dataUrn);
            if (nextAsset == null) {
                throw new ResponseException(Response.status(Response.Status.BAD_REQUEST).
                        entity(new RejectionMessageBuilder().
                                _rejectionReason_(RejectionReason.NOT_FOUND).
                                _contentVersion_(String.format("Requested artifact %s could not be found",dataUrn)).
                                build())
                        .build());
            }
            var policy = resolvePolicy(nextAsset);
            if (policy == null) {
                monitor.severe("Policy not found for artifact: " + dataUrn);
                throw new ResponseException(Response.status(Response.Status.INTERNAL_SERVER_ERROR).
                        entity(new RejectionMessageBuilder().
                                _rejectionReason_(RejectionReason.TEMPORARILY_NOT_AVAILABLE).
                                _contentVersion_(String.format("There is no suitable policy for artifact %s",dataUrn)).
                                build())
                        .build());
            }
            var consumerConnectorId = message.getIssuerConnector().toString();
            var correlationId = message.getId().toString();
            var policyResult = evaluatePolicy(message, policy, consumerConnectorId, correlationId, verificationResult);

            if (!policyResult.valid()) {
                monitor.info("Policy evaluation failed");
                throw new ResponseException(Response.status(Response.Status.FORBIDDEN).
                        entity(new RejectionMessageBuilder().
                                _rejectionReason_(RejectionReason.NOT_AUTHORIZED)
                                ._contentVersion_(String.format("Evaluation of policy %s resulted in failures.",policy.getUid()))
                                .build())
                        .build());
            }
        }
        return nextAsset;
    }

    /**
     * evaluates the policy in more detail
     *
     * @param policy
     * @param consumerConnectorId
     * @param correlationId
     * @param verificationResult
     * @return policy evaluation result (success and failure)
     */
    @Override
    protected PolicyEvaluationResult evaluatePolicy(ArtifactRequestMessage message, Policy policy, String consumerConnectorId, String correlationId, VerificationResult verificationResult) {
        return CrossConnectorPolicy.evaluatePolicy(policyService,message.getRequestedArtifact().toString(),(Map<String,Object>)message.getProperties().getOrDefault("dataspaceconnector-data-destination", Map.of()),policy,consumerConnectorId,correlationId,verificationResult);
    }

}

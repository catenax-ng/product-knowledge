package net.catenax.semantics.connector;

import org.eclipse.dataspaceconnector.policy.model.*;

import static org.eclipse.dataspaceconnector.policy.model.Operator.IN;

public class CrossConnectorPolicy {

    public static Policy createCrossConnectorPolicy(String policyId, String permissionType, String connectorRegex) {
        LiteralExpression crossConnectorExpression = new LiteralExpression(ConnectorOriginMatchRequestPermission.PERMISSION_NAME);
        var crossConnectorDomainConstraint =
                AtomicConstraint.Builder.newInstance().leftExpression(crossConnectorExpression).
                        operator(IN).rightExpression(new LiteralExpression(connectorRegex)).build();
        var usePermission = Permission.Builder.newInstance().action(Action.Builder.newInstance().type(permissionType).build()).
                constraint(crossConnectorDomainConstraint).build();
        return Policy.Builder.newInstance().id(policyId).permission(usePermission).build();
    }
}

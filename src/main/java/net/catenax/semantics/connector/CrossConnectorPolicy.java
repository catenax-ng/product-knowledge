package net.catenax.semantics.connector;

import org.eclipse.dataspaceconnector.policy.model.*;

import static org.eclipse.dataspaceconnector.policy.model.Operator.IN;

/**
 * builds a policy 
 */
public class CrossConnectorPolicy {

    public static String USE_PERMISSION="idsc:USE";
    public static String DISTRIBUTE_PERMISSION="cx:DISTRIBUTE";
    
    public static AtomicConstraint createCrossConnectorConstraint(String connectorRegex) {
        LiteralExpression crossConnectorExpression = new LiteralExpression(ConnectorOriginMatchRequestPermission.PERMISSION_NAME);
        return AtomicConstraint.Builder.newInstance().leftExpression(crossConnectorExpression).
                        operator(IN).rightExpression(new LiteralExpression(connectorRegex)).build();
    }

    public static Permission createPermission(String permissionType, Constraint... constraints) {
        var permissionBuilder = Permission.Builder.newInstance().action(Action.Builder.newInstance().type(permissionType).build());
        for(Constraint constraint : constraints) {
            permissionBuilder=permissionBuilder.constraint(constraint);
        }
        return permissionBuilder.build();
    } 
    
    public static Policy createPolicy(String policyId, Permission... permissions) {
        var policyBuilder=Policy.Builder.newInstance().id(policyId);
        for(Permission permission: permissions) {
            policyBuilder=policyBuilder.permission(permission);
        }
        return policyBuilder.build();
    }
}

/*
 * Copyright (c) 2021-2022 T-Systems International GmbH (Catena-X Consortium)
 *
 * See the AUTHORS file(s) distributed with this work for additional
 * information regarding authorship.
 *
 * See the LICENSE file(s) distributed with this work for
 * additional information regarding license terms.
 */
package net.catenax.semantics.connector.policy;

import net.catenax.semantics.connector.TripleDataPlaneExtension;
import org.eclipse.dataspaceconnector.ids.spi.policy.IdsPolicyActions;
import org.eclipse.dataspaceconnector.ids.spi.policy.IdsPolicyService;
import org.eclipse.dataspaceconnector.policy.engine.PolicyEvaluationResult;
import org.eclipse.dataspaceconnector.policy.engine.RuleProblem;
import org.eclipse.dataspaceconnector.policy.model.*;
import org.eclipse.dataspaceconnector.spi.iam.ClaimToken;
import org.eclipse.dataspaceconnector.spi.iam.VerificationResult;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * builds a policy 
 */
public class CrossConnectorPolicy {

    /**
     * data from the asset may be updated
     */
    public static String INSERT="cx:INSERT";
    public static Action INSERT_ACTION=Action.Builder.newInstance().type(INSERT).build();

    /**
     * create a constraint regarding cross connector calls
     * @param connectorRegex regular expression describing the allowed connector call chains
     * @return cross connector constraint
     */
    public static AtomicConstraint createCrossConnectorConstraint(String connectorRegex, boolean completeMatch) {
        LiteralExpression crossConnectorExpression = new LiteralExpression(ConnectorOriginMatchFunction.FUNCTION_NAME);
        Operator operator=Operator.EQ;
        if(!completeMatch) {
            operator=Operator.IN;
        }
        return AtomicConstraint.Builder.newInstance().leftExpression(crossConnectorExpression).
                        operator(operator).rightExpression(new LiteralExpression(connectorRegex)).build();
    }

    /**
     * create a constraint regarding asset unions
     * @param assetRegex regular expression describing the allowed assets
     * @return asset union constraint
     */
    public static AtomicConstraint createUnionAssetConstraint(String assetRegex, boolean completeMatch) {
        LiteralExpression unionAssetExpression = new LiteralExpression(UnionAssetMatchFunction.FUNCTION_NAME);
        Operator operator=Operator.EQ;
        if(!completeMatch) {
            operator=Operator.IN;
        }
        return AtomicConstraint.Builder.newInstance().leftExpression(unionAssetExpression).
                operator(operator).rightExpression(new LiteralExpression(assetRegex)).build();
    }

    /**
     * create a duty
     * @param action
     * @param constraints
     * @return new duty
     */
    public static Duty createDuty(Action action, Constraint... constraints) {
        var dutyBuilder = Duty.Builder.newInstance().action(action);
        for(Constraint constraint : constraints) {
            dutyBuilder=dutyBuilder.constraint(constraint);
        }
        return dutyBuilder.build();
    }

    /**
     * create a prohibition
     * @param action
     * @param constraints
     * @return new prohibition
     */
    public static Prohibition createProhibition(Action action, Constraint... constraints) {
        var prohibitionBuilder = Prohibition.Builder.newInstance().action(action);
        for(Constraint constraint : constraints) {
            prohibitionBuilder=prohibitionBuilder.constraint(constraint);
        }
        return prohibitionBuilder.build();
    }

    /**
     * create a permission
     * @param action
     * @param constraints
     * @return new permission
     */
    public static Permission createPermission(Action action, List<Duty> duties, Constraint... constraints) {
        var permissionBuilder = Permission.Builder.newInstance().action(action);
        permissionBuilder=permissionBuilder.duties(duties);
        for(Constraint constraint : constraints) {
            permissionBuilder=permissionBuilder.constraint(constraint);
        }
        return permissionBuilder.build();
    }

    /**
     * creates a policy
     * @param policyId
     * @param permissions
     * @param obligations
     * @param prohibitions
     * @return new policy
     */
    public static Policy createPolicy(String policyId, List<Permission> permissions, List<Duty> obligations, List<Prohibition> prohibitions) {
        var policyBuilder=Policy.Builder.newInstance().id(policyId);
        policyBuilder=policyBuilder.permissions(permissions);
        policyBuilder=policyBuilder.duties(obligations);
        policyBuilder.prohibitions(prohibitions);
        return policyBuilder.build();
    }

    /**
     * evaluates a federated policy in more detail
     * @param policy
     * @param consumerConnectorId
     * @param correlationId
     * @param verificationResult
     * @return policy evaluation result (success and failure)
     */
    public static PolicyEvaluationResult evaluatePolicy(IdsPolicyService policyService, String urn, Map<String,Object> destination, Policy policy, String consumerConnectorId, String correlationId, VerificationResult verificationResult) {
        var assetName = urn.substring(0, urn.indexOf("#"));
        var graphNames = urn.substring(urn.indexOf("#") + 1);
        var ctb = ClaimToken.Builder.newInstance();
        ctb.claims(verificationResult.token().getClaims());
        ctb.claim(UnionAssetMatchFunction.FUNCTION_NAME, graphNames);
        String type = ((Map<String,String>) destination.getOrDefault("properties",Map.of())).getOrDefault(TripleDataPlaneExtension.REQUEST_TYPE,"");
        PolicyEvaluationResult result = policyService.evaluateRequest(consumerConnectorId, correlationId, ctb.build(), policy);
        Map<Rule,List<RuleProblem>> remaining = result.getProblems().stream().filter(
                problem -> {
                    if ("SELECT".equals(type) && (problem.getRule().getAction() == IdsPolicyActions.READ_ACTION)) {
                        return true;
                    } else if ("INSERT".equals(type) && problem.getRule().getAction() == IdsPolicyActions.READ_ACTION) {
                        return true;
                    } else if ("DELETE".equals(type) && problem.getRule().getAction() == CrossConnectorPolicy.INSERT_ACTION) {
                        return true;
                    } else if ("SUBSCRIBE".equals(type) && problem.getRule().getAction() == IdsPolicyActions.DISTRIBUTE_ACTION) {
                        return true;
                    } else {
                        return false;
                    }
                }).collect(Collectors.toMap(problem -> problem.getRule(), problem -> List.of(problem), (pl1, pl2) -> {
            var res=List.<RuleProblem>of();
            res.addAll(pl1);
            res.addAll(pl2);
            return res;
        }));
        var check=policy.getPermissions().stream().map(permission -> {
            if (
                    ("SELECT".equals(type) && permission.getAction() == IdsPolicyActions.READ_ACTION) ||
                            ("INSERT".equals(type) && permission.getAction() == IdsPolicyActions.READ_ACTION) ||
                            ("DELETE".equals(type) && permission.getAction() == CrossConnectorPolicy.INSERT_ACTION) ||
                            ("SUBSCRIBE".equals(type) && permission.getAction() == IdsPolicyActions.DISTRIBUTE_ACTION)
            ) {
                return remaining.getOrDefault(permission, List.<RuleProblem>of()).size() == 0;
            } else
                return false;
        }).reduce((pb1,pb2) -> pb1 || pb2);
        if(!check.orElse(false)) {
            return new PolicyEvaluationResult(remaining.values().stream().flatMap( p->p.stream() ).collect(Collectors.toList()));
        } else {
            return new PolicyEvaluationResult();
        }
    }
}

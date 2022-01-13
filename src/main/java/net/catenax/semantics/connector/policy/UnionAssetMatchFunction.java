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

import org.eclipse.dataspaceconnector.ids.spi.policy.*;
import org.eclipse.dataspaceconnector.policy.model.Duty;
import org.eclipse.dataspaceconnector.policy.model.Operator;
import org.eclipse.dataspaceconnector.policy.model.Permission;
import org.eclipse.dataspaceconnector.policy.model.Prohibition;

/**
 * A request permission (constraint) which checks a particular portion
 * of the claim token which lists all the assets which are jointly selected
 * for match with a regular expression
 */
public class UnionAssetMatchFunction implements IdsRequestPermissionFunction, IdsRequestDutyFunction, IdsRequestProhibitionFunction {
    public static String FUNCTION_NAME = "cx:asset_union";

    /**
     * register
     * @param policyService
     */
    public void register(IdsPolicyService policyService) {
        policyService.registerRequestPermissionFunction(FUNCTION_NAME,this);
        policyService.registerRequestDutyFunction(FUNCTION_NAME,this);
        policyService.registerRequestProhibitionFunction(FUNCTION_NAME,this);
    }

    @Override
    public boolean evaluate(Operator operator, String s, Duty duty, IdsRequestPolicyContext idsRequestPolicyContext) {
        return evaluate(operator,s,idsRequestPolicyContext);
    }

    @Override
    public boolean evaluate(Operator operator, String s, Prohibition prohibition, IdsRequestPolicyContext idsRequestPolicyContext) {
        return evaluate(operator,s,idsRequestPolicyContext);
    }

    @Override
    public boolean evaluate(Operator operator, String s, Permission permission, IdsRequestPolicyContext idsRequestPolicyContext) {
        return evaluate(operator,s,idsRequestPolicyContext);
    }

    /**
     * the actual evaluation
     * @param operator
     * @param s
     * @param idsRequestPolicyContext
     * @return
     */
    public boolean evaluate(Operator operator, String s, IdsRequestPolicyContext idsRequestPolicyContext) {
        String allAssets=idsRequestPolicyContext.getClaimToken().getClaims().getOrDefault(FUNCTION_NAME, "");
        if (s == null) {
            return false;
        }
        boolean check = true;
        if(operator==Operator.IN) {
            String[] unionAssets = allAssets.split(";");
            for (String asset : unionAssets) {
                check = check && java.util.regex.Pattern.matches(s, asset);
            }
        } else if(operator==Operator.EQ) {
            check= java.util.regex.Pattern.matches(s, allAssets);
        }
        return check;
    }
}
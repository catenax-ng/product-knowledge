package net.catenax.semantics.connector;

import org.eclipse.dataspaceconnector.ids.spi.policy.*;
import org.eclipse.dataspaceconnector.policy.model.Duty;
import org.eclipse.dataspaceconnector.policy.model.Operator;
import org.eclipse.dataspaceconnector.policy.model.Permission;
import org.eclipse.dataspaceconnector.policy.model.Prohibition;

/**
 * A request permission (constraint) which checks the origin connector id
 * (which actually is a stack of connector ids separated with ";")
 * using a regular expression
 */
public class ConnectorOriginMatchFunction implements IdsRequestPermissionFunction, IdsRequestDutyFunction, IdsRequestProhibitionFunction {
    public static String FUNCTION_NAME="ids:origin";

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
        String allConnectors=idsRequestPolicyContext.getConsumerConnectorId();
        if (s == null) {
             return false;
        }
        boolean check = true;
        if(operator==Operator.IN) {
            String[] connectors = allConnectors.split(";");
            for (String connector : connectors) {
                check = check && java.util.regex.Pattern.matches(s, connector);
            }
        } else if(operator==Operator.EQ) {
            check= java.util.regex.Pattern.matches(s, allConnectors);
        }
        return check;
    }

}

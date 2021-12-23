package net.catenax.semantics.connector;

import org.eclipse.dataspaceconnector.ids.spi.policy.IdsRequestPermissionFunction;
import org.eclipse.dataspaceconnector.ids.spi.policy.IdsRequestPolicyContext;
import org.eclipse.dataspaceconnector.policy.model.Operator;
import org.eclipse.dataspaceconnector.policy.model.Permission;

/**
 * A request permission (constraint) which checks the origin connector id
 * using a regular expression
 */
public class ConnectorOriginMatchRequestPermission implements IdsRequestPermissionFunction {
    public static String PERMISSION_NAME="ids:origin";

    @Override
    public boolean evaluate(Operator operator, String s, Permission permission, IdsRequestPolicyContext idsRequestPolicyContext) {
        return s != null && java.util.regex.Pattern.matches(s,idsRequestPolicyContext.getConsumerConnectorId());
    }

}

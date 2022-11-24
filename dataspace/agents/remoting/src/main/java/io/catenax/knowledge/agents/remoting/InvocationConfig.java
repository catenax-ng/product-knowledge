//
// Application to provide REST APIs as SPARQL services
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.remoting;

import org.eclipse.rdf4j.sail.config.SailConfigException;

import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * class to represent a single invocation description
 * from the config graph of the remoting SAIL repo.
 */
public class InvocationConfig {
    /** regexp to check invocation */
    public static Pattern classPattern = Pattern.compile(
            "(?<classType>class):(?<class>[a-zA-Z0-9\\.]+)#(?<method>[a-zA-Z0-9]+)|(?<restType>https?)://(?<url>[a-zA-Z0-9\\.:/%#\\-]+)");

    /** url of the target service */
    protected String targetUri = null;

    /** method for the invocation, maybe POST or POST-MF, GET or INVOKE */
    protected String method = null;

    /** a matcher for the targetUri containing regex groups/bindings */
    protected Matcher matcher = null;

    /** the maximal batch size */
    protected long batch = 1;

    /** prefix to attach to all properties */
    protected String inputProperty;
    
    /** whether and where to put a unique invocation id */
    protected String invocationIdProperty;

    /**
     * map of arguments
     */
    protected Map<String, ArgumentConfig> arguments = new java.util.HashMap<String, ArgumentConfig>();

    /** the result */
    String resultName=null;
    ResultConfig result=null;
    
    @Override
    public String toString() {
        return super.toString()+"/service";
    }   

    /**
     * Validates the invocation config
     * @throws SailConfigException
     */
    public void validate(String context) throws SailConfigException {
        if (targetUri == null || targetUri.length() == 0) {
            throw new SailConfigException(String.format("Service URL in invocation %s is not provided",context));
        }
        matcher = classPattern.matcher(targetUri);
        if (!matcher.matches()) {
            throw new SailConfigException(String.format("Service URL %s has no supported format.", targetUri));
        }
        if (method == null) {
            if (matcher.group("classType") != null) {
                method = "INVOKE";
            } else if (matcher.group("restType") != null) {
                method = "GET";
            } else {
                throw new SailConfigException(String.format("Cannot deduce service method from URL %s.", targetUri));
            }
        } else {
            switch (method) {
                case "INVOKE":
                    if (matcher.group("classType") == null) {
                        throw new SailConfigException(String.format(
                                "INVOKE Method can onl be used with class-type service URLs but was %s.", targetUri));
                    }
                    break;
                case "POST-JSON":
                case "POST-JSON-MF":
                case "GET":
                    if (matcher.group("restType") == null) {
                        throw new SailConfigException(String.format(
                                "%s Method can only be used with REST service URLs but was %s.", method, targetUri));
                    }

            }
        }
        for (Map.Entry<String, ArgumentConfig> arg : arguments.entrySet()) {
            arg.getValue().validate(arg.getKey());
        }
        if(resultName==null || result==null) {
            throw new SailConfigException(String.format(
                "There was no result configured for the invocation."));

        } else {
            result.validate(resultName);
        }
    }
}

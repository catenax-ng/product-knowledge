//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.system.configuration.Config;

import java.util.Map;

/**
 * typed wrapper around the
 * EDC configuration
 */
public class AgentConfig {

    public static String DEFAULT_ASSET_PROPERTY = "cx.agent.asset.default";
    public static String DEFAULT_ASSET_NAME = "urn:graph:cx:Dataspace";
    public static String ASSET_FILE_PROPERTY = "cx.agent.asset.file";
    public static String DEFAULT_ASSET_FILE = "dataspace.ttl";
    public static String ACCESS_POINT_PROPERTY = "cx.agent.accesspoint.name";
    public static String VERBOSE_PROPERTY = "cx.agent.sparql.verbose";
    public static boolean DEFAULT_VERBOSE_PROPERTY = false;
    public static String DEFAULT_ACCESS_POINT = "api";
    /* deprecated */
    public static String CONTROL_PLANE_URL = "cx.agent.controlplane.url";
    public static String CONTROL_PLANE_MANAGEMENT = "cx.agent.controlplane.management";
    public static String CONTROL_PLANE_IDS = "cx.agent.controlplane.ids";
    public static String CONTROL_PLANE_AUTH_HEADER = "edc.api.control.auth.apikey.key";
    public static String CONTROL_PLANE_AUTH_VALUE = "edc.api.control.auth.apikey.value";
    public static String NEGOTIATION_TIMEOUT_PROPERTY = "cx.agent.negotiation.timeout";
    public static long DEFAULT_NEGOTIATION_TIMEOUT = 30000;
    public static String NEGOTIATION_POLLINTERVAL_PROPERTY = "cx.agent.negotiation.poll";
    public static long DEFAULT_NEGOTIATION_POLLINTERVAL = 1000;

    /**
     * references to EDC services
     */
    protected final Config config;
    protected final Monitor monitor;

    /**
     * creates the typed config
     * @param monitor logger
     * @param config untyped config
     */
    public AgentConfig(Monitor monitor, Config config) {
        this.monitor = monitor;
        this.config = config;
    }

    /**
     * @return the name of the default asset/graph
     */
    public String getDefaultAsset() {
        return config.getString(DEFAULT_ASSET_PROPERTY, DEFAULT_ASSET_NAME);
    }

    /**
     * @return initial file to load
     */
    public String getAssetFile() {
        return config.getString(ASSET_FILE_PROPERTY, DEFAULT_ASSET_FILE);
    }

    /**
     * @return name of the sparql access point
     */
    public String getAccessPoint() {
        return config.getString(ACCESS_POINT_PROPERTY, DEFAULT_ACCESS_POINT);
    }

    /**
     * @return uri of the control plane management endpoint (without concrete api)
     */
    public String getControlPlaneManagementUrl() {
        return config.getString(CONTROL_PLANE_MANAGEMENT,config.getString(CONTROL_PLANE_URL,null));
    }

    /**
     * @return uri of the control plane ids endpoint (without concrete api)
     */
    public String getControlPlaneIdsUrl() {
        return config.getString(CONTROL_PLANE_IDS);
    }

    /**
     * @return a map of key/value paris to be used when interacting with the control plane management endpoint
     */
    public Map<String, String> getControlPlaneManagementHeaders() {
        String key = config.getString(CONTROL_PLANE_AUTH_HEADER);
        String value = config.getString(CONTROL_PLANE_AUTH_VALUE);
        if (key != null && value != null) {
            return Map.of(key, value);
        }
        return Map.of();
    }

    /**
     * @return the default overall timeout when waiting for a negotation result
     */
    public long getNegotiationTimeout() {
        return config.getLong(NEGOTIATION_TIMEOUT_PROPERTY,DEFAULT_NEGOTIATION_TIMEOUT);
    }

    /**
     * @return the default overall timeout when waiting for a negotation result
     */
    public long getNegotiationPollinterval() {
        return config.getLong(NEGOTIATION_POLLINTERVAL_PROPERTY,DEFAULT_NEGOTIATION_POLLINTERVAL);
    }

    /**
     * @return whether sparql engine is set to verbose
     */
    public boolean isSparqlVerbose() {
        return config.getBoolean(VERBOSE_PROPERTY,DEFAULT_VERBOSE_PROPERTY);
    }

}

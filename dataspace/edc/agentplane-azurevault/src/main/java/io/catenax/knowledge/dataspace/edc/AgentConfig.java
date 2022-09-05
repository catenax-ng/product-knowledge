//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.system.configuration.Config;

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
    public static String DEFAULT_ACCESS_POINT = "api";
    
    Config config;
    Monitor monitor;

    public AgentConfig(Monitor monitor, Config config) {
        this.monitor=monitor;
        this.config=config;
    }

    public String getDefaultAsset() {
        return config.getString(DEFAULT_ASSET_PROPERTY,DEFAULT_ASSET_NAME);
    }

    public String getAssetFile() {
        return config.getString(ASSET_FILE_PROPERTY,DEFAULT_ASSET_FILE);
    }

    public String getAccessPoint() {
        return config.getString(ACCESS_POINT_PROPERTY,DEFAULT_ACCESS_POINT);
    }

}

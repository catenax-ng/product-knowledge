//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

/**
 * lists the various protocols supported
 */
public enum AgentProtocol {

    SPARQL_HTTP("urn:cx:Protocol:w3c:Http#SPARQL");

    private final String protocolId;

    AgentProtocol(String protocolId) {
        this.protocolId=protocolId;
    }

    public String getProtocolId() {
        return protocolId;
    }
}

package io.catenax.knowledge.dataspace.aasbridge;

import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;

public class AasBridge {

    final String providerSparqlEndpoint;
    final AssetAdministrationShellEnvironment aasTemplate;
    public static void main(String[] args) {

    }

    public AasBridge(String providerSparqlEndpoint,
                     AssetAdministrationShellEnvironment aasTemplate){
        this.providerSparqlEndpoint = providerSparqlEndpoint;
        this.aasTemplate = aasTemplate;
    }





}

//
// Knowledge Agent AAS Bridge
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.aasbridge.aspects;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import io.adminshell.aas.v3.dataformat.DeserializationException;
import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import io.adminshell.aas.v3.model.Submodel;
import io.adminshell.aas.v3.model.SubmodelElement;
import io.adminshell.aas.v3.model.SubmodelElementCollection;
import io.catenax.knowledge.dataspace.aasbridge.AasUtils;
import io.catenax.knowledge.dataspace.aasbridge.AspectMapper;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

/**
 * A Mapper for the Part site information Submodel
 */

public class PartSiteInformationAsPlannedMapper extends AspectMapper {
    public PartSiteInformationAsPlannedMapper(String providerSparqlEndpoint, String credentials, HttpClient client, long timeoutSeconds) throws IOException, DeserializationException, URISyntaxException, ExecutionException, InterruptedException {
        super(providerSparqlEndpoint, "/aasTemplates/PartSiteInformationAsPlanned-aas-1.0.0.xml", credentials, client, timeoutSeconds);
        this.aasInstances = this.parametrizeAas();

    }

    protected AssetAdministrationShellEnvironment parametrizeAas() throws URISyntaxException, IOException, ExecutionException, InterruptedException {
        CompletableFuture<ArrayNode> queryFuture =
                executeQuery("/queries/PartSiteInformationAsPlanned.rq");

        ArrayNode queryResponse = queryFuture.get();

        Map<JsonNode, List<JsonNode>> groupedByCxid = StreamSupport.stream(queryResponse.spliterator(), false).collect(Collectors.groupingBy(node -> node.get("catenaXId")));

        Optional<AssetAdministrationShellEnvironment> partSiteInformation = groupedByCxid.values().stream().map(group -> {
            AssetAdministrationShellEnvironment aasInstance = instantiateAas();
            setGlobalAssetId(aasInstance.getAssetAdministrationShells().get(0),(ObjectNode) group.get(0), "catenaXId");

            Submodel submodel = AasUtils.getSubmodelFromAasenv(aasInstance, "urn:bamm:io.catenax.part_site_information_as_planned:1.0.0#PartSiteInformationAsPlanned");
            setProperty(submodel, "catenaXId", getValueByKey((ObjectNode) group.get(0), "catenaXId"));
            SubmodelElementCollection siteCollection = AasUtils.getSmecFromSubmodel(submodel, "sites");
            SubmodelElementCollection siteEntityTemplate = (SubmodelElementCollection) AasUtils.getChildFromParentSmec(siteCollection, "SiteEntity");

            List<SubmodelElement> sites = group.stream().map(site -> {
                SubmodelElementCollection siteEntityInstance = AasUtils.cloneReferable(siteEntityTemplate, SubmodelElementCollection.class);
                setProperty(siteEntityInstance, "catenaXsiteId", getValueByKey((ObjectNode) site, "site"));
                setProperty(siteEntityInstance, "function", getValueByKey((ObjectNode) site, "function"));
                setProperty(siteEntityInstance, "functionValidFrom", getValueByKey((ObjectNode) site, "roleValidFrom"));
                setProperty(siteEntityInstance, "functionValidUntil", getValueByKey((ObjectNode) site, "roleValidTo"));

                return siteEntityInstance;
            }).collect(Collectors.toList());

            siteCollection.setValues(sites);
            return aasInstance;
        }).reduce((env1, env2) -> {
            env1.setSubmodels(AasUtils.join(env1.getSubmodels(), env2.getSubmodels()));
            env1.setAssetAdministrationShells(AasUtils.join(env1.getAssetAdministrationShells(), env2.getAssetAdministrationShells()));
            env1.setConceptDescriptions(AasUtils.join(env1.getConceptDescriptions(), env2.getConceptDescriptions()));

            return env1;
        });
        return partSiteInformation.orElseThrow();
    }
}

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
import io.adminshell.aas.v3.model.impl.DefaultAssetAdministrationShellEnvironment;
import io.catenax.knowledge.dataspace.aasbridge.AspectMapper;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.util.Collection;
import java.util.List;
import java.util.Map;
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

        List<Submodel> singleLevelBomsAsPlanned = groupedByCxid.values().stream().map(group -> {
            AssetAdministrationShellEnvironment aasInstance = instantiateAas();
            Submodel submodel = getSubmodelFromAasenv(aasInstance, "urn:bamm:io.catenax.part_site_information_as_planned:1.0.0#PartSiteInformationAsPlanned");

            setPropertyInSubmodel(submodel, "catenaXId", findValueInProperty((ObjectNode) group.get(0), "catenaXId"));
            SubmodelElementCollection siteCollection = getSmecFromSubmodel(submodel, "sites");
            SubmodelElementCollection siteEntityTemplate = (SubmodelElementCollection) getChildFromParentSmec(siteCollection, "SiteEntity");

            List<SubmodelElement> sites = group.stream().map(site -> {
                SubmodelElementCollection siteEntityInstance = cloneReferable(siteEntityTemplate, SubmodelElementCollection.class);
                Collection<SubmodelElement> siteSmes = siteEntityInstance.getValues();
                setPropertyInSmec(siteEntityInstance, "catenaXsiteId", findValueInProperty((ObjectNode) site, "site"));
                setPropertyInSmec(siteEntityInstance, "function", findValueInProperty((ObjectNode) site, "function"));
                setPropertyInSmec(siteEntityInstance, "functionValidFrom", findValueInProperty((ObjectNode) site, "roleValidFrom"));
                setPropertyInSmec(siteEntityInstance, "functionValidUntil", findValueInProperty((ObjectNode) site, "roleValidTo"));

                return siteEntityInstance;
            }).collect(Collectors.toList());

            siteCollection.setValues(sites);
            return submodel;
        }).collect(Collectors.toList());

        return new DefaultAssetAdministrationShellEnvironment.Builder()
                .submodels(singleLevelBomsAsPlanned)
                .conceptDescriptions(aasTemplate.getConceptDescriptions())
                .build();
    }

}

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
import io.adminshell.aas.v3.model.*;
import io.adminshell.aas.v3.model.impl.DefaultAssetAdministrationShellEnvironment;
import io.adminshell.aas.v3.model.impl.DefaultIdentifier;
import io.catenax.knowledge.dataspace.aasbridge.AspectMapper;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.UUID;
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

        List<Submodel> singleLevelBomsAsPlanned = groupedByCxid.entrySet().stream().map(byCxId -> {
            AssetAdministrationShellEnvironment aasInstance = instantiateAas();
            Submodel submodel = aasInstance.getSubmodels().stream()
                    .filter(sub -> sub.getSemanticId().getKeys().stream()
                            .anyMatch(key -> key.getValue().equals("urn:bamm:io.catenax.part_site_information_as_planned:1.0.0#PartSiteInformationAsPlanned"))
                    )
                    .findFirst().orElseThrow(() -> new RuntimeException("Desired Submodel not found in Template"));

            submodel.setIdentification(new DefaultIdentifier.Builder()
                    .idType(IdentifierType.CUSTOM)
                    .identifier(UUID.randomUUID().toString())
                    .build());

            List<SubmodelElement> submodelElements = submodel
                    .getSubmodelElements();

            submodelElements.stream().filter(sme -> sme.getIdShort().equals("catenaXId"))
                    .findFirst().ifPresent(mn -> ((Property) mn).setValue(findValueInProperty((ObjectNode) byCxId.getValue().get(0), "catenaXId")));

            SubmodelElementCollection siteCollection = (SubmodelElementCollection) submodelElements.stream().filter(sme -> sme.getIdShort().equals("sites"))
                    .findFirst().orElseThrow();

            SubmodelElementCollection siteEntityTemplate = (SubmodelElementCollection) siteCollection.getValues().stream().filter(sme -> sme.getIdShort().equals("SiteEntity"))
                    .findFirst().orElseThrow();

            List<SubmodelElement> sites = byCxId.getValue().stream().map(site -> {
                SubmodelElementCollection siteEntityInstance = cloneReferable(siteEntityTemplate, SubmodelElementCollection.class);
                Collection<SubmodelElement> siteSmes = siteEntityInstance.getValues();
                ((Property) siteSmes.stream().filter(sme -> sme.getIdShort().equals("catenaXsiteId")).findFirst().orElseThrow())
                        .setValue(findValueInProperty((ObjectNode) site, "site"));

                ((Property) siteSmes.stream().filter(sme -> sme.getIdShort().equals("function")).findFirst().orElseThrow())
                        .setValue(findValueInProperty((ObjectNode) site, "function"));

                ((Property) siteSmes.stream().filter(sme -> sme.getIdShort().equals("functionValidFrom")).findFirst().orElseThrow())
                        .setValue(findValueInProperty((ObjectNode) site, "roleValidFrom"));

                ((Property) siteSmes.stream().filter(sme -> sme.getIdShort().equals("functionValidUntil")).findFirst().orElseThrow())
                        .setValue(findValueInProperty((ObjectNode) site, "roleValidTo"));

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

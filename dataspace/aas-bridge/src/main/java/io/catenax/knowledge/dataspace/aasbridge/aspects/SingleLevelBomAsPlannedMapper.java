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
 * A Mapper for the Single level Bom As Planned Submodel
 */

public class SingleLevelBomAsPlannedMapper extends AspectMapper {
    public SingleLevelBomAsPlannedMapper(String providerSparqlEndpoint, String credentials, HttpClient client, long timeoutSeconds) throws IOException, DeserializationException, URISyntaxException, ExecutionException, InterruptedException {
        super(providerSparqlEndpoint, "/aasTemplates/SingleLevelBomAsPlanned-aas-1.0.1.xml", credentials, client, timeoutSeconds);
        this.aasInstances = this.parametrizeAas();
    }

    protected AssetAdministrationShellEnvironment parametrizeAas() throws URISyntaxException, IOException, ExecutionException, InterruptedException {
        CompletableFuture<ArrayNode> queryFuture =
                executeQuery("/queries/SingleLevelBomAsPlanned.rq");

        ArrayNode queryResponse = queryFuture.get();

        Map<JsonNode, List<JsonNode>> groupedByCxid = StreamSupport.stream(queryResponse.spliterator(), false).collect(Collectors.groupingBy(node -> node.get("catenaXId")));

        List<Submodel> singleLevelBomsAsPlanned = groupedByCxid.entrySet().stream().map(byCxId -> {
            AssetAdministrationShellEnvironment aasInstance = instantiateAas();
            Submodel submodel = aasInstance.getSubmodels().stream()
                    .filter(sub -> sub.getSemanticId().getKeys().stream()
                            .anyMatch(key -> key.getValue().equals("urn:bamm:io.catenax.single_level_bom_as_planned:1.0.1#SingleLevelBomAsPlanned"))
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

            SubmodelElementCollection childCollection = (SubmodelElementCollection) submodelElements.stream().filter(sme -> sme.getIdShort().equals("childParts"))
                    .findFirst().orElseThrow();

            SubmodelElementCollection childDataTemplate = (SubmodelElementCollection) childCollection.getValues().stream().filter(sme -> sme.getIdShort().equals("ChildData"))
                    .findFirst().orElseThrow();

            List<SubmodelElement> children = byCxId.getValue().stream().map(child -> {
                SubmodelElementCollection childDataInstance = cloneReferable(childDataTemplate, SubmodelElementCollection.class);
                Collection<SubmodelElement> childSmes = childDataInstance.getValues();
                ((Property) childSmes.stream().filter(sme -> sme.getIdShort().equals("createdOn")).findFirst().orElseThrow())
                        .setValue(findValueInProperty((ObjectNode) child, "productionStartDate"));

                ((Property) childSmes.stream().filter(sme -> sme.getIdShort().equals("lastModifiedOn")).findFirst().orElseThrow())
                        .setValue(findValueInProperty((ObjectNode) child, "productionEndDate"));

                ((Property) childSmes.stream().filter(sme -> sme.getIdShort().equals("childCatenaXId")).findFirst().orElseThrow())
                        .setValue(findValueInProperty((ObjectNode) child, "childCatenaXId"));

                Collection<SubmodelElement> quantityElements = ((SubmodelElementCollection) childSmes.stream().filter(sme -> sme.getIdShort().equals("Quantity")).findFirst().orElseThrow())
                        .getValues();

                ((Property) quantityElements.stream().filter(sme -> sme.getIdShort().equals("quantityNumber")).findFirst().orElseThrow())
                        .setValue(findValueInProperty((ObjectNode) child, "childQuantity"));

                ((Property) quantityElements.stream().filter(sme -> sme.getIdShort().equals("measurementUnit")).findFirst().orElseThrow())
                        .setValue(findValueInProperty((ObjectNode) child, "billOfMaterialUnit"));

                return childDataInstance;
            }).collect(Collectors.toList());

            childCollection.setValues(children);

            return submodel;
        }).collect(Collectors.toList());

        return new DefaultAssetAdministrationShellEnvironment.Builder()
                .submodels(singleLevelBomsAsPlanned)
                .conceptDescriptions(aasTemplate.getConceptDescriptions())
                .build();
    }
}

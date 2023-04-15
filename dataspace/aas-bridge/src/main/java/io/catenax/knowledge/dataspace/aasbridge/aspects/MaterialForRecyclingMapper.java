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
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

/**
 * A Mapper for the materialForRecycling Submodel
 */
public class MaterialForRecyclingMapper extends AspectMapper {

    public MaterialForRecyclingMapper(String providerSparqlEndpoint, String cred, HttpClient client, long timeoutSeconds) throws IOException, DeserializationException, URISyntaxException, ExecutionException, InterruptedException {
        super(providerSparqlEndpoint, "/aasTemplates/MaterialForRecycling-aas-1.1.0.xml", cred, client, timeoutSeconds);
        this.aasInstances = this.parametrizeAas();
    }

    protected AssetAdministrationShellEnvironment parametrizeAas() throws IOException, URISyntaxException, ExecutionException, InterruptedException {
        CompletableFuture<ArrayNode> queryFuture =
                executeQuery("/queries/MaterialForRecyclingEngineering.rq");

        ArrayNode queryResponse = queryFuture.get();

        Map<JsonNode, List<JsonNode>> groupedByEmat = StreamSupport.stream(queryResponse.spliterator(), false)
                .collect(Collectors.groupingBy(node ->  node.get("eMat"), Collectors.toList()));

        List<Submodel> materialsForRecycling = groupedByEmat.values().stream().map(rmats -> {
            AssetAdministrationShellEnvironment aasInstance = instantiateAas();
            Submodel submodel = aasInstance.getSubmodels().stream()
                    .filter(sub -> sub.getSemanticId().getKeys().stream()
                            .anyMatch(key -> key.getValue().equals("urn:bamm:io.catenax.material_for_recycling:1.1.0#MaterialForRecycling"))
                    )
                    .findFirst().orElseThrow(() -> new RuntimeException("Desired Submodel not found in Template"));

            submodel.setIdentification(new DefaultIdentifier.Builder()
                    .idType(IdentifierType.CUSTOM)
                    .identifier(UUID.randomUUID().toString())
                    .build());

            List<SubmodelElement> submodelElements = submodel
                    .getSubmodelElements();

            submodelElements.stream().filter(sme -> sme.getIdShort().equals("materialName"))
                    .findFirst().ifPresent(mn -> ((Property) mn).setValue(findValueInProperty((ObjectNode) rmats.get(0), "engineeringMaterialName")));

            submodelElements.stream().filter(sme -> sme.getIdShort().equals("materialClass"))
                    .findFirst().ifPresent(mn -> ((Property) mn).setValue(findValueInProperty((ObjectNode) rmats.get(0), "engineeringMaterialClass")));

            SubmodelElementCollection component = submodelElements.stream().filter(sme -> sme.getIdShort().equals("component")).map(comp -> (SubmodelElementCollection) comp)
                    .findFirst().orElseThrow();
            SubmodelElementCollection componentEntity = component.getValues().stream().filter(sme -> sme.getIdShort().equals("ComponentEntity"))
                    .map(sme -> (SubmodelElementCollection) sme).findFirst().orElseThrow();

            List<SubmodelElement> components = rmats.stream().map(rmat -> {
                SubmodelElementCollection componentClone = cloneReferable(componentEntity, SubmodelElementCollection.class);
                componentClone.getValues()
                        .stream().map(sme -> (Property) sme).filter(p -> p.getIdShort().equals("aggregateState"))
                        .findFirst().orElseThrow().setValue(findValueInProperty((ObjectNode) rmat, "componentState"));
                componentClone.getValues()
                        .stream().map(sme -> (Property) sme).filter(p -> p.getIdShort().equals("recycledContent"))
                        .findFirst().orElseThrow().setValue(findValueInProperty((ObjectNode) rmat, "componentRecycledContent"));
                componentClone.getValues()
                        .stream().map(sme -> (Property) sme).filter(p -> p.getIdShort().equals("materialAbbreviation"))
                        .findFirst().orElseThrow().setValue(findValueInProperty((ObjectNode) rmat, "componentMaterialAbbreviation"));
                componentClone.getValues()
                        .stream().map(sme -> (Property) sme).filter(p -> p.getIdShort().equals("materialClass"))
                        .findFirst().orElseThrow().setValue(findValueInProperty((ObjectNode) rmat, "componentMaterialClass"));
                componentClone.getValues()
                        .stream().map(sme -> (Property) sme).filter(p -> p.getIdShort().equals("materialName"))
                        .findFirst().orElseThrow().setValue(findValueInProperty((ObjectNode) rmat, "componentMaterialName"));
                // quantity is in the aspect model but not in the graph currently
                return componentClone;
            }).collect(Collectors.toList());
            component.setValues(components);
            return submodel;

        }).collect(Collectors.toList());
        return new DefaultAssetAdministrationShellEnvironment.Builder()
                .submodels(materialsForRecycling)
                .conceptDescriptions(aasTemplate.getConceptDescriptions())
                .build();

    }

}
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
import java.util.List;
import java.util.Map;
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

            Submodel submodel = getSubmodelFromAasenv(aasInstance, "urn:bamm:io.catenax.material_for_recycling:1.1.0#MaterialForRecycling");

            setPropertyInSubmodel(submodel, "materialName", findValueInProperty((ObjectNode) rmats.get(0), "engineeringMaterialName"));
            setPropertyInSubmodel(submodel, "materialClass", findValueInProperty((ObjectNode) rmats.get(0), "engineeringMaterialClass"));

            SubmodelElementCollection component = getSmecFromSubmodel(submodel, "component");
            SubmodelElementCollection componentEntity = (SubmodelElementCollection) getChildFromParentSmec(component, "ComponentEntity");

            List<SubmodelElement> components = rmats.stream().map(rmat -> {
                SubmodelElementCollection componentClone = cloneReferable(componentEntity, SubmodelElementCollection.class);
                setPropertyInSmec(componentClone, "aggregateState", findValueInProperty((ObjectNode) rmat, "componentState"));
                setPropertyInSmec(componentClone, "recycledContent", findValueInProperty((ObjectNode) rmat, "componentRecycledContent"));
                setPropertyInSmec(componentClone, "materialAbbreviation", findValueInProperty((ObjectNode) rmat, "componentMaterialAbbreviation"));
                setPropertyInSmec(componentClone, "materialClass", findValueInProperty((ObjectNode) rmat, "componentMaterialClass"));
                setPropertyInSmec(componentClone, "materialName", findValueInProperty((ObjectNode) rmat, "componentMaterialName"));
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
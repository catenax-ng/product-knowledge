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

        Optional<AssetAdministrationShellEnvironment> materialsForRecycling = groupedByEmat.values().stream().map(rmats -> {
            AssetAdministrationShellEnvironment aasInstance = instantiateAas();
            setGlobalAssetId(aasInstance.getAssetAdministrationShells().get(0), (ObjectNode) rmats.get(0), "eMat" );

            Submodel submodel = AasUtils.getSubmodelFromAasenv(aasInstance, "urn:bamm:io.catenax.material_for_recycling:1.1.0#MaterialForRecycling");

            setProperty(submodel, "materialName", getValueByKey((ObjectNode) rmats.get(0), "engineeringMaterialName"));
            setProperty(submodel, "materialClass", getValueByKey((ObjectNode) rmats.get(0), "engineeringMaterialClass"));

            SubmodelElementCollection component = AasUtils.getSmecFromSubmodel(submodel, "component");
            SubmodelElementCollection componentEntity = (SubmodelElementCollection) AasUtils.getChildFromParentSmec(component, "ComponentEntity");

            List<SubmodelElement> components = rmats.stream().map(rmat -> {
                SubmodelElementCollection componentClone = AasUtils.cloneReferable(componentEntity, SubmodelElementCollection.class);
                setProperty(componentClone, "aggregateState", getValueByKey((ObjectNode) rmat, "componentState"));
                setProperty(componentClone, "recycledContent", getValueByKey((ObjectNode) rmat, "componentRecycledContent"));
                setProperty(componentClone, "materialAbbreviation", getValueByKey((ObjectNode) rmat, "componentMaterialAbbreviation"));
                setProperty(componentClone, "materialClass", getValueByKey((ObjectNode) rmat, "componentMaterialClass"));
                setProperty(componentClone, "materialName", getValueByKey((ObjectNode) rmat, "componentMaterialName"));
                // quantity is in the aspect model but not in the graph currently

                return componentClone;
            }).collect(Collectors.toList());
            component.setValues(components);
            return aasInstance;

        }).reduce((env1, env2)-> {
            env1.setSubmodels(AasUtils.join(env1.getSubmodels(), env2.getSubmodels()));
            env1.setAssetAdministrationShells(AasUtils.join(env1.getAssetAdministrationShells(), env2.getAssetAdministrationShells()));
            env1.setConceptDescriptions(AasUtils.join(env1.getConceptDescriptions(), env2.getConceptDescriptions()));
            return env1;
        });
        return materialsForRecycling.orElseThrow();
    }
}
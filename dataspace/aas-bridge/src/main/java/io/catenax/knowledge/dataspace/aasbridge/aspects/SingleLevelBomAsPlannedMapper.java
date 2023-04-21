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

        Optional<AssetAdministrationShellEnvironment> singleLevelBomsAsPlanned = groupedByCxid.values().stream().map(group -> {
            AssetAdministrationShellEnvironment aasInstance = instantiateAas();
            setGlobalAssetId(aasInstance.getAssetAdministrationShells().get(0), (ObjectNode) group.get(0), "catenaXId");

            Submodel submodel = AasUtils.getSubmodelFromAasenv(aasInstance, "urn:bamm:io.catenax.single_level_bom_as_planned:1.0.1#SingleLevelBomAsPlanned");
            setProperty(submodel, "catenaXId", getValueByKey((ObjectNode) group.get(0), "catenaXId"));
            SubmodelElementCollection childCollection = AasUtils.getSmecFromSubmodel(submodel, "childParts");
            SubmodelElementCollection childDataTemplate = (SubmodelElementCollection) AasUtils.getChildFromParentSmec(childCollection, "ChildData");

            List<SubmodelElement> children = group.stream().map(child -> {
                SubmodelElementCollection childDataInstance = AasUtils.cloneReferable(childDataTemplate, SubmodelElementCollection.class);

                setProperty(childDataInstance, "createdOn", getValueByKey((ObjectNode) child, "productionStartDate"));
                setProperty(childDataInstance, "lastModifiedOn", getValueByKey((ObjectNode) child, "productionEndDate"));
                setProperty(childDataInstance, "childCatenaXId", getValueByKey((ObjectNode) child, "childCatenaXId"));

                SubmodelElementCollection quantityElements = (SubmodelElementCollection) AasUtils.getChildFromParentSmec(childDataInstance, "Quantity");
                setProperty(quantityElements, "quantityNumber", getValueByKey((ObjectNode) child, "childQuantity"));
                setProperty(quantityElements, "measurementUnit", getValueByKey((ObjectNode) child, "billOfMaterialUnit"));

                return childDataInstance;
            }).collect(Collectors.toList());

            childCollection.setValues(children);
            return aasInstance;
        }).reduce((env1, env2) -> {
            env1.setSubmodels(AasUtils.join(env1.getSubmodels(), env2.getSubmodels()));
            env1.setAssetAdministrationShells(AasUtils.join(env1.getAssetAdministrationShells(), env2.getAssetAdministrationShells()));
            env1.setConceptDescriptions(AasUtils.join(env1.getConceptDescriptions(), env2.getConceptDescriptions()));

            return env1;
        });
        return singleLevelBomsAsPlanned.orElseThrow();
    }
}

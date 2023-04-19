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

        List<Submodel> singleLevelBomsAsPlanned = groupedByCxid.values().stream().map(group -> {
            AssetAdministrationShellEnvironment aasInstance = instantiateAas();
            Submodel submodel = getSubmodelFromAasenv(aasInstance, "urn:bamm:io.catenax.single_level_bom_as_planned:1.0.1#SingleLevelBomAsPlanned");

            setPropertyInSubmodel(submodel, "catenaXId", findValueInProperty((ObjectNode) group.get(0), "catenaXId"));
            SubmodelElementCollection childCollection = getSmecFromSubmodel(submodel, "childParts");
            SubmodelElementCollection childDataTemplate = (SubmodelElementCollection) getChildFromParentSmec(childCollection, "ChildData");

            List<SubmodelElement> children = group.stream().map(child -> {
                SubmodelElementCollection childDataInstance = cloneReferable(childDataTemplate, SubmodelElementCollection.class);

                setPropertyInSmec(childDataInstance,"createdOn", findValueInProperty((ObjectNode) child, "productionStartDate"));
                setPropertyInSmec(childDataInstance,"lastModifiedOn", findValueInProperty((ObjectNode) child, "productionEndDate"));
                setPropertyInSmec(childDataInstance,"childCatenaXId", findValueInProperty((ObjectNode) child, "childCatenaXId"));

                SubmodelElementCollection quantityElements = (SubmodelElementCollection) getChildFromParentSmec(childDataInstance, "Quantity");
                setPropertyInSmec(quantityElements,"quantityNumber",findValueInProperty((ObjectNode) child, "childQuantity"));
                setPropertyInSmec(quantityElements,"measurementUnit",findValueInProperty((ObjectNode) child, "billOfMaterialUnit"));

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

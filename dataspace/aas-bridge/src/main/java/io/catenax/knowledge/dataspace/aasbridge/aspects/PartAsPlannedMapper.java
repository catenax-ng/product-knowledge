//
// Knowledge Agent AAS Bridge
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.aasbridge.aspects;

import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import io.adminshell.aas.v3.dataformat.DeserializationException;
import io.adminshell.aas.v3.dataformat.SerializationException;
import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import io.adminshell.aas.v3.model.Property;
import io.adminshell.aas.v3.model.Submodel;
import io.adminshell.aas.v3.model.SubmodelElementCollection;
import io.catenax.knowledge.dataspace.aasbridge.AasUtils;
import io.catenax.knowledge.dataspace.aasbridge.AspectMapper;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.stream.StreamSupport;

/**
 * A Mapper for the Part as Planned Submodel
 */

public class PartAsPlannedMapper extends AspectMapper {
    public PartAsPlannedMapper(String providerSparqlEndpoint, String cred, HttpClient client, long timeoutSeconds) throws IOException, DeserializationException {
        super(providerSparqlEndpoint, "/aasTemplates/PartAsPlanned-aas-1.0.0.xml", cred, client, timeoutSeconds);
        try {
            this.aasInstances = this.parametrizeAas();
        } catch (URISyntaxException | SerializationException | InterruptedException | ExecutionException e) {
            throw new RuntimeException(e);
        }
    }

    protected AssetAdministrationShellEnvironment parametrizeAas() throws IOException, URISyntaxException, ExecutionException, InterruptedException, SerializationException {
        CompletableFuture<ArrayNode> queryFuture =
                executeQuery("/queries/PartAsPlanned.rq");

        // stream over returned parts
        Optional<AssetAdministrationShellEnvironment> partsAsPlanned = StreamSupport.stream(queryFuture.get().spliterator(), false)
                .map(node -> {
                            AssetAdministrationShellEnvironment aasInstance = instantiateAas();
                            setGlobalAssetId(aasInstance.getAssetAdministrationShells().get(0), (ObjectNode) node, "catenaXId");

                            Submodel submodel = AasUtils.getSubmodelFromAasenv(aasInstance, "urn:bamm:io.catenax.part_as_planned:1.0.0#PartAsPlanned");

                            SubmodelElementCollection validityPeriodEntity = AasUtils.getSmecFromSubmodel(submodel, "ValidityPeriodEntity");
                            validityPeriodEntity
                                    .getValues().forEach(p ->
                                            ((Property) p).setValue(getValueByMatch((Property) p, (ObjectNode) node))
                                    );

                            setProperty(submodel, "catenaXId", getValueByKey((ObjectNode) node, "catenaXId"));

                            SubmodelElementCollection partTypeInformationEntity = AasUtils.getSmecFromSubmodel(submodel, "PartTypeInformationEntity");
                            partTypeInformationEntity
                                    .getValues().forEach(p ->
                                            ((Property) p).setValue(getValueByMatch((Property) p, (ObjectNode) node))
                                    );

                            return aasInstance;
                        }
                ).reduce((env1, env2) -> {
                    env1.setSubmodels(AasUtils.join(env1.getSubmodels(), env2.getSubmodels()));
                    env1.setAssetAdministrationShells(AasUtils.join(env1.getAssetAdministrationShells(), env2.getAssetAdministrationShells()));
                    env1.setConceptDescriptions(AasUtils.join(env1.getConceptDescriptions(), env2.getConceptDescriptions()));
                    return env1;
                });
        return partsAsPlanned.orElseThrow();
    }
}

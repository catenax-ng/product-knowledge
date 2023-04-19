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
import io.adminshell.aas.v3.model.impl.DefaultAssetAdministrationShellEnvironment;
import io.catenax.knowledge.dataspace.aasbridge.AspectMapper;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.util.ArrayList;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collector;
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

    protected AssetAdministrationShellEnvironment parametrizeAas() throws IOException, URISyntaxException, ExecutionException, InterruptedException, SerializationException, DeserializationException {
        CompletableFuture<ArrayNode> queryFuture =
                executeQuery("/queries/PartAsPlanned.rq");

        // stream over returned parts
        ArrayList<Submodel> partsAsPlanned = StreamSupport.stream(queryFuture.get().spliterator(), false)
                .map(node -> {
                            // get new AAS copy
                            AssetAdministrationShellEnvironment aasInstance = instantiateAas();
                            Submodel submodel = getSubmodelFromAasenv(aasInstance, "urn:bamm:io.catenax.part_as_planned:1.0.0#PartAsPlanned");

                            SubmodelElementCollection validityPeriodEntity = getSmecFromSubmodel(submodel, "ValidityPeriodEntity");
                            validityPeriodEntity
                                    .getValues().forEach(p ->
                                            ((Property) p).setValue(findValueInProperty((Property) p, (ObjectNode) node))
                                    );

                            setPropertyInSubmodel(submodel, "catenaXId", findValueInProperty((ObjectNode) node, "catenaXId"));

                            SubmodelElementCollection partTypeInformationEntity = getSmecFromSubmodel(submodel, "PartTypeInformationEntity");
                            partTypeInformationEntity
                                    .getValues().forEach(p ->
                                            ((Property) p).setValue(findValueInProperty((Property) p, (ObjectNode) node))
                                    );

                            return aasInstance;
                        }
                )
                // good to return AASEnvs but problematic to only collect SMs
                .collect(Collector.of(
                                ArrayList<Submodel>::new,
                                (list, aas) -> list.addAll(aas.getSubmodels()),
                                (left, right) -> {
                                    left.addAll(right);
                                    return left;
                                }
                        )
                );
        return new DefaultAssetAdministrationShellEnvironment.Builder()
                .submodels(partsAsPlanned)
                .conceptDescriptions(aasTemplate.getConceptDescriptions())
                .build();
    }

}

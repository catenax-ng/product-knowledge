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
import io.adminshell.aas.v3.model.*;
import io.adminshell.aas.v3.model.impl.DefaultAssetAdministrationShellEnvironment;
import io.adminshell.aas.v3.model.impl.DefaultIdentifier;
import io.catenax.knowledge.dataspace.aasbridge.AspectMapper;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
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

        // get new AAS copy
        aasTemplate.getSubmodels().stream()
                .filter(sub -> sub.getSemanticId().getKeys().stream()
                        .anyMatch(key -> key.getValue().equals("urn:bamm:io.catenax.part_as_planned:1.0.0#PartAsPlanned"))
                )
                .findFirst().orElseThrow(() -> new RuntimeException("Desired Submodel not found in Template"));

        // stream over returned parts
        ArrayList<Submodel> partsAsPlanned = StreamSupport.stream(queryFuture.get().spliterator(), false)
                .map(node -> {
                            // get new AAS copy
                            AssetAdministrationShellEnvironment aasInstance = instantiateAas();
                    Submodel submodel = aasInstance.getSubmodels().stream()
                            .filter(sub -> sub.getSemanticId().getKeys().stream()
                                    .anyMatch(key -> key.getValue().equals("urn:bamm:io.catenax.part_as_planned:1.0.0#PartAsPlanned"))
                            )
                            .findFirst().orElseThrow(() -> new RuntimeException("Desired Submodel not found in Template"));

                    submodel.setIdentification(new DefaultIdentifier.Builder()
                            .idType(IdentifierType.CUSTOM)
                            .identifier(UUID.randomUUID().toString())
                            .build());
                    List<SubmodelElement> submodelElements = submodel
                                    .getSubmodelElements();


                            // optional SMEs
                            submodelElements.stream()
                                    .filter(sme -> sme.getIdShort().equals("ValidityPeriodEntity"))
                                    .findFirst().ifPresent(sme -> ((SubmodelElementCollection) sme)
                                            .getValues().forEach(p ->
                                                    ((Property) p).setValue(findValueInProperty((Property) p, (ObjectNode) node))

                                            )
                                    );

                            submodelElements.stream()
                                    .filter(sme -> sme.getIdShort().equals("catenaXId"))
                                    .findFirst().ifPresentOrElse((sme -> ((Property) sme)
                                                    .setValue(findValueInProperty((Property) sme, (ObjectNode) node))),
                                            () -> {
                                                throw new RuntimeException("failed to find a catenaXId in PartsAsPlannedMapper");
                                            });

                            submodelElements.stream()
                                    .filter(sme -> sme.getIdShort().equals("PartTypeInformationEntity"))
                                    .findFirst().ifPresentOrElse(sme -> ((SubmodelElementCollection) sme)
                                            .getValues().forEach(p -> findValueInProperty((Property) p, (ObjectNode) node)
                                            ), () -> {
                                        throw new RuntimeException("failed to find partTypeInformation in partasplanned smt");
                                    });

                            return aasInstance;
                        }
                )
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

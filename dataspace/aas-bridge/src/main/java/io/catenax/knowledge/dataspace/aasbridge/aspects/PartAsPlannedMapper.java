package io.catenax.knowledge.dataspace.aasbridge.aspects;

import io.adminshell.aas.v3.dataformat.DeserializationException;
import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import io.adminshell.aas.v3.model.Property;
import io.adminshell.aas.v3.model.SubmodelElement;
import io.adminshell.aas.v3.model.SubmodelElementCollection;
import io.catenax.knowledge.dataspace.aasbridge.AspectMapper;
import opc.i4aas.client.AASDataSpecificationIEC61360TypeImpl;

import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Collection;
import java.util.List;

public class PartAsPlannedMapper extends AspectMapper {
    public PartAsPlannedMapper(String providerSparqlEndpoint) throws IOException, DeserializationException {
        super(providerSparqlEndpoint, Path.of("src/main/resources/aasTemplates/PartAsPlanned-aas-1.0.0.xml"));
        try {
            this.aasInstances = this.parametrizeAas();
        } catch (URISyntaxException e) {
            throw new RuntimeException(e);
        }
    }

    protected AssetAdministrationShellEnvironment parametrizeAas() throws IOException, URISyntaxException {
        this.executeQuery(Files.readString(Path.of("src/main/resources/queries/PartAsPlanned.rq")));


        AssetAdministrationShellEnvironment aasInstance = instantiateAas();
        List<SubmodelElement> submodelElements = aasInstance.getSubmodels().stream()
                .filter(sub -> sub.getSemanticId().getKeys().stream()
                        .anyMatch(key -> key.getValue().equals("urn:bamm:io.catenax.part_as_planned:1.0.0#PartAsPlanned"))
                )
                .findFirst().orElseThrow(() -> new RuntimeException("Desired Submodel not found in Template"))
                .getSubmodelElements();

        // optional SMEs
        submodelElements.stream()
                .filter(sme -> sme.getIdShort().equals("validityPeriod"))
                .findFirst().ifPresent(sme -> ((SubmodelElementCollection) sme)
                        .getValues().forEach(p ->
                                ((Property) p).setValue(getValueFromIdShort((Property) p))
                        )
                );

        return null;
    }


    private String getValueFromIdShort(Property property) {
        String idShort = property.getIdShort();
        return null;
    }


}

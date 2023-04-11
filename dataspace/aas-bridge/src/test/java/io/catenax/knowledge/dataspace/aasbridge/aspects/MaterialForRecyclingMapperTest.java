package io.catenax.knowledge.dataspace.aasbridge.aspects;

import io.adminshell.aas.v3.dataformat.DeserializationException;
import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import io.adminshell.aas.v3.model.SubmodelElementCollection;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.util.Set;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertNotEquals;

class MaterialForRecyclingMapperTest {
    private static MaterialForRecyclingMapper mapper;


    @BeforeAll
    public static void instantiate() throws IOException, DeserializationException, URISyntaxException, ExecutionException, InterruptedException {
        String devUrl = "https://knowledge.dev.demo.catena-x.net/oem-edc-data/BPNL00000003COJN/api/agent" +
                "?OemProviderAgent="+
                URLEncoder.encode("http://oem-provider-agent:8082/sparql", "ISO-8859-1");
        mapper = new MaterialForRecyclingMapper(devUrl, System.getProperty( "PROVIDER_CREDENTIAL_BASIC"));
    }

    @Test
    void parametrizeAas() throws IOException, URISyntaxException, ExecutionException, InterruptedException {
        AssetAdministrationShellEnvironment env = mapper.parametrizeAas();
        Set<SubmodelElementCollection> componentsPerSubmodel = env.getSubmodels().stream()
                .map(sm ->
                        (SubmodelElementCollection) sm.getSubmodelElements().stream()
                                .filter(sme -> sme.getIdShort().equals("component"))
                                .findFirst().get())
                .filter(comp -> comp.getValues().size() > 1).collect(Collectors.toSet());


        assertNotEquals(0, componentsPerSubmodel.size());

    }
}
//
// Knowledge Agent AAS Bridge
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.aasbridge.aspects;

import io.adminshell.aas.v3.model.AssetAdministrationShell;
import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import io.adminshell.aas.v3.model.SubmodelElementCollection;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;

/**
 * tests the material for recycling mapping logic
 */
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class MaterialForRecyclingMapperTest extends AspectMapperTest {
    private MaterialForRecyclingMapper mapper;

    @BeforeAll
    public void instantiate() throws Exception {
        mockResponse = new String(getClass().getClassLoader()
                .getResourceAsStream("MaterialForRecycling-sparql-results.json")
                .readAllBytes());
        super.instantiate();
        String devUrl = mockWebServer.url("/oem-edc-data/BPNL00000003COJN/api/agent" +
                "?OemProviderAgent=" +
                URLEncoder.encode("http://oem-provider-agent:8082/sparql", StandardCharsets.ISO_8859_1)).toString();
        mapper = new MaterialForRecyclingMapper(devUrl, System.getProperty("PROVIDER_CREDENTIAL_BASIC"), client, timeoutSeconds);
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


    @Test
    public void idProvisioning() {
        // all submodels in a mapper have different Ids
        List<String> submodelIds = mapper.getAasInstances().getSubmodels().stream()
                .map(sm -> sm.getIdentification().getIdentifier()).collect(Collectors.toList());
        List<String> distinctSubmodelIds = submodelIds.stream()
                .distinct().collect(Collectors.toList());
        assertEquals(submodelIds, distinctSubmodelIds);

        List<AssetAdministrationShell> aass = mapper.getAasInstances().getAssetAdministrationShells();
        List<String> aasIds = aass.stream().map(aas -> aas.getIdentification().getIdentifier()).collect(Collectors.toList());
        List<String> distinctAasIds = aasIds.stream().distinct().collect(Collectors.toList());
        assertEquals(aasIds, distinctAasIds);

        List<String> assetIds = aass.stream().map(aas -> aas.getAssetInformation().getGlobalAssetId().getKeys().get(0).getValue()).collect(Collectors.toList());
        List<String> distinctAssetIds = assetIds.stream().distinct().collect(Collectors.toList());
        assertEquals(assetIds, distinctAssetIds);

        aass.forEach(aas->
            assertEquals(1, aas.getSubmodels().stream().map(sm->sm.getKeys().get(0).getValue()).distinct().count())
        );
    }


}
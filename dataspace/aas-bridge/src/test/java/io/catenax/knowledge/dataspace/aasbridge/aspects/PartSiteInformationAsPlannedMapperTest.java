//
// Knowledge Agent AAS Bridge
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.aasbridge.aspects;

import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import io.adminshell.aas.v3.model.SubmodelElement;
import io.adminshell.aas.v3.model.SubmodelElementCollection;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.util.Collection;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * tests the part site information mapping logic
 */
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class PartSiteInformationAsPlannedMapperTest extends AspectMapperTest {

    private PartSiteInformationAsPlannedMapper mapper;

    @BeforeAll
    public void instantiate() throws Exception {
        mockResponse=new String(getClass().getClassLoader()
                .getResourceAsStream("PartSiteInformationAsPlanned-sparql-results.json")
                .readAllBytes());
        super.instantiate();
        String devUrl = mockWebServer.url("/oem-edc-data/BPNL00000003COJN/api/agent" +
                "?OemProviderAgent=" +
                URLEncoder.encode("http://oem-provider-agent:8082/sparql", "ISO-8859-1")).toString();
        mapper = new PartSiteInformationAsPlannedMapper(devUrl, System.getProperty("PROVIDER_CREDENTIAL_BASIC"),client,timeoutSeconds);
    }
    @Test
    void parametrizeAas() throws URISyntaxException, IOException, ExecutionException, InterruptedException {
        AssetAdministrationShellEnvironment env = mapper.parametrizeAas();
        List<Collection<SubmodelElement>> listOfChildren = env.getSubmodels().stream().filter(sm -> sm.getIdShort().equals("PartSiteInformationAsPlanned"))
                .map(sm -> sm.getSubmodelElements().stream().filter(sme -> sme.getIdShort().equals("sites")).findFirst().orElseThrow())
                .map(cp -> ((SubmodelElementCollection) cp).getValues()).collect(Collectors.toList());
        listOfChildren
                .forEach(cp -> {
                    assertTrue(cp.size() >= 1);
                });
        assertTrue(listOfChildren.stream().anyMatch(cp -> cp.size() > 1));

    }
}
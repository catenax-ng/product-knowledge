//
// Knowledge Agent AAS Bridge
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.aasbridge.aspects;

import io.adminshell.aas.v3.dataformat.DeserializationException;
import io.adminshell.aas.v3.dataformat.SerializationException;
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
 * tests the single level bom mapping logic
 */
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class SingleLevelBomAsPlannedMapperTest extends AspectMapperTest {
    private SingleLevelBomAsPlannedMapper mapper;

    @BeforeAll
    public void instantiate() throws Exception {
        mockResponse=new String(getClass().getClassLoader()
                .getResourceAsStream("SingleLevelBomAsPlanned-sparql-results.json")
                .readAllBytes());
        super.instantiate();
        String devUrl = mockWebServer.url("/oem-edc-data/BPNL00000003COJN/api/agent" +
                "?OemProviderAgent=" +
                URLEncoder.encode("http://oem-provider-agent:8082/sparql", "ISO-8859-1")).toString();
        mapper = new SingleLevelBomAsPlannedMapper(devUrl, System.getProperty("PROVIDER_CREDENTIAL_BASIC"),client,timeoutSeconds);
    }

    @Test
    void parametrizeAas() throws IOException, URISyntaxException, ExecutionException, InterruptedException, SerializationException, DeserializationException {
        AssetAdministrationShellEnvironment env = mapper.parametrizeAas();
        List<Collection<SubmodelElement>> listOfChildren = env.getSubmodels().stream().filter(sm -> sm.getIdShort().equals("SingleLevelBomAsPlanned"))
                .map(sm -> sm.getSubmodelElements().stream().filter(sme -> sme.getIdShort().equals("childParts")).findFirst().orElseThrow())
                .map(cp -> ((SubmodelElementCollection) cp).getValues()).collect(Collectors.toList());
        listOfChildren
                .forEach(cp -> {
                    assertTrue(cp.size() >= 1);
                });
        assertTrue(listOfChildren.stream().anyMatch(cp -> cp.size() > 1));
    }
}

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
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.util.concurrent.ExecutionException;

import static org.junit.jupiter.api.Assertions.assertNotEquals;

/**
 * tests the part aas aplanned mapping logic
 */
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class PartAsPlannedMapperTest extends AspectMapperTest {

    private PartAsPlannedMapper mapper;

    @BeforeAll
    public void instantiate() throws Exception {
        mockResponse=new String(getClass().getClassLoader()
                .getResourceAsStream("PartAsPlanned-sparql-results.json")
                .readAllBytes());
        super.instantiate();
        String devUrl = mockWebServer.url("/oem-edc-data/BPNL00000003COJN/api/agent"+
                "?OemProviderAgent="+
                URLEncoder.encode("http://oem-provider-agent:8082/sparql", "ISO-8859-1")).toString();
        mapper = new PartAsPlannedMapper(devUrl, System.getProperty( "PROVIDER_CREDENTIAL_BASIC"),client,timeoutSeconds);
    }

    @Test
    void parametrizeAas() throws IOException, URISyntaxException, ExecutionException, InterruptedException, SerializationException, DeserializationException {
        AssetAdministrationShellEnvironment assetAdministrationShellEnvironment = mapper.parametrizeAas();
        assertNotEquals(0, assetAdministrationShellEnvironment.getConceptDescriptions().size());
        assertNotEquals(0, assetAdministrationShellEnvironment.getSubmodels().size());

    }
}
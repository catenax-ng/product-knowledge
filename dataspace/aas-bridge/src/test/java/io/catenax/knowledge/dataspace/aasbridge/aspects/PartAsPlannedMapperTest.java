package io.catenax.knowledge.dataspace.aasbridge.aspects;

import io.adminshell.aas.v3.dataformat.DeserializationException;
import io.adminshell.aas.v3.dataformat.SerializationException;
import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.util.concurrent.ExecutionException;

import static org.junit.jupiter.api.Assertions.assertNotEquals;

class PartAsPlannedMapperTest {

    private static PartAsPlannedMapper mapper;

    @BeforeAll
    public static void instantiate() throws IOException, DeserializationException {
        String devUrl = "https://knowledge.dev.demo.catena-x.net/oem-edc-data/BPNL00000003COJN/api/agent"+
                "?OemProviderAgent="+
                URLEncoder.encode("http://oem-provider-agent:8082/sparql", "ISO-8859-1");
        mapper = new PartAsPlannedMapper(devUrl, System.getProperty( "PROVIDER_CREDENTIAL_BASIC"));
    }

    @Test
    void parametrizeAas() throws IOException, URISyntaxException, ExecutionException, InterruptedException, SerializationException, DeserializationException {
        AssetAdministrationShellEnvironment assetAdministrationShellEnvironment = mapper.parametrizeAas();
        assertNotEquals(0, assetAdministrationShellEnvironment.getConceptDescriptions().size());
        assertNotEquals(0, assetAdministrationShellEnvironment.getSubmodels().size());

    }
}
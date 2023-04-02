package io.catenax.knowledge.dataspace.aasbridge;

import io.adminshell.aas.v3.dataformat.DeserializationException;
import io.catenax.knowledge.dataspace.aasbridge.aspects.MaterialForRecyclingMapper;
import org.junit.jupiter.api.BeforeAll;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.concurrent.ExecutionException;

class AspectMapperTest {

    private static AspectMapper mapper;


    @BeforeAll
    public static void instantiate() throws IOException, DeserializationException, URISyntaxException, ExecutionException, InterruptedException {
        String devUrl = "https://knowledge.dev.demo.catena-x.net/oem-edc-data/BPNL00000003COJN/api/agent";
        mapper = new MaterialForRecyclingMapper(devUrl);
    }
}
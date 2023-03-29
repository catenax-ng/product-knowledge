package io.catenax.knowledge.dataspace.aasbridge.aspects;

import io.adminshell.aas.v3.dataformat.DeserializationException;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import java.io.IOException;

class MaterialForRecyclingMapperTest {
    private static MaterialForRecyclingMapper mapper;


    @BeforeAll
    public static void instantiate() throws IOException, DeserializationException {
        String devUrl = "https://knowledge.dev.demo.catena-x.net/oem-edc-data/BPNL00000003COJN/api/agent";
        mapper = new MaterialForRecyclingMapper(devUrl);
    }

    @Test
    void parametrizeAas() {
        System.out.println(mapper.getAasTemplate());

        // mapper.parametrizeAas(sme->sme.getIdShort().equals(""))
    }
}
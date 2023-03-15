package io.catenax.knowledge.dataspace.aasbridge;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.adminshell.aas.v3.dataformat.DeserializationException;
import io.catenax.knowledge.dataspace.aasbridge.aspects.MaterialForRecyclingMapper;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import static org.junit.jupiter.api.Assertions.*;

class AspectMapperTest {

    private static AspectMapper mapper;

    @BeforeAll
    public static void instantiate() throws IOException, DeserializationException {
        String devUrl = "https://knowledge.dev.demo.catena-x.net/oem-provider-agent3/sparql";
        mapper = new MaterialForRecyclingMapper(devUrl);
    }
    @Test
    void executeQuery() throws URISyntaxException, ExecutionException, InterruptedException, JsonProcessingException {
        String result = mapper.executeQuery("PREFIX cx: <https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#>\n" +
                "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>\n" +
                "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\n" +
                "PREFIX : <:>\n" +
                "\n" +
                "SELECT * WHERE {\n" +
                "\n" +
                "  VALUES (?catenaXId) { \n" +
                "      (<urn:uuid:0733946c-59c6-41ae-9570-cb43a6e4c79e>) \n" +
                "  }\n" +
                "  \n" +
                "  ?catenaXId rdf:type cx:Part;\n" +
                "    cx:partSeries ?partTypeInformation_manufacturerPartId;\n" +
                "    cx:partName ?partTypeInformation_nameAtManufacturere;\n" +
                "    cx:partProductionDate ?validityPeriod_validFrom;\n" +
                "    cx:partProductionDate ?validityPeriod_validTo.\n" +
                "\n" +
                "  BIND(\"product\"^^xsd:string AS ?partTypeInformation_classification)\n" +
                "} \n"
        )
                .get();

        JsonNode bindings = new ObjectMapper().readTree(result).path("results").path("bindings");
        ArrayList list = new ObjectMapper().readValue(bindings.toString(), ArrayList.class);
        assertNotEquals(0, list.size());

    }
}
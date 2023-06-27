package io.catenax.knowledge.dataspace.aasbridge;

import io.adminshell.aas.v3.model.*;
import io.adminshell.aas.v3.model.impl.DefaultProperty;
import io.adminshell.aas.v3.model.impl.DefaultSubmodelElementCollection;
import okhttp3.mockwebserver.MockResponse;
import okhttp3.mockwebserver.MockWebServer;
import org.eclipse.digitaltwin.aas4j.exceptions.TransformationException;
import org.eclipse.digitaltwin.aas4j.mapping.MappingSpecificationParser;
import org.eclipse.digitaltwin.aas4j.mapping.model.MappingSpecification;
import org.eclipse.digitaltwin.aas4j.transform.GenericDocumentTransformer;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import java.io.*;
import java.io.File;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Collection;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class MappingExecutorTest {

    private final String MOCK_URL = "/oem-edc-data/BPNL00000003COJN/api/agent" +
            "?OemProviderAgent=" +
            URLEncoder.encode("http://oem-provider-agent:8082/sparql", StandardCharsets.ISO_8859_1);

    @Test
    @Disabled
    void executeMapping() throws IOException, TransformationException {
        MappingSpecification mapping = new MappingSpecificationParser().loadMappingSpecification("src/main/resources/mappingSpecifications/materialForRecycling-mapping.json");
        GenericDocumentTransformer transformer = new GenericDocumentTransformer();
        InputStream instream = MappingExecutorTest.class.getResourceAsStream("/sparqlResponseXml/MaterialForRecycling-sparql-results.xml");
        String s = new String(instream.readAllBytes());
        AssetAdministrationShellEnvironment env = transformer.execute(new ByteArrayInputStream(s.getBytes()), mapping);
        assertEquals(12, env.getSubmodels().size());
        env.getAssetAdministrationShells().forEach(aas ->
                assertTrue(aas.getAssetInformation().getGlobalAssetId().getKeys().get(0).getValue().startsWith("urn:material")));

        env.getSubmodels().stream().map(sm -> getProperty(sm, "materialName")).anyMatch(p -> p.equals("bla"));
        env.getSubmodels().stream().map(sm -> getProperty(sm, "materialClass")).anyMatch(p -> p.equals("CeramicMaterial"));

        assertEquals(3,env.getSubmodels().stream()
                .filter(sm->getProperty(sm,"materialName").equals("bla"))
                .map(sm -> getSmcValues(sm, "component")).findFirst().get().size());

        // env.getSubmodels().forEach(sm -> assertEquals("EngineeringMaterial", getProperty(sm, "materialClass")));

    }

    @Disabled
    @ParameterizedTest
    @ValueSource(strings = {"MaterialForRecycling", "PartAsPlanned", "PartSiteInformation", "SingleLevelBomAsPlanned"})
    void executeQuery(String aspectName) throws IOException, URISyntaxException, ExecutionException, InterruptedException {
        MockWebServer mockWebServer = instantiateMockServer(aspectName);
        MappingExecutor executor = new MappingExecutor(
                new URI(mockWebServer.url(MOCK_URL).toString()),
                System.getProperty("PROVIDER_CREDENTIAL_BASIC"),
                3,
                5 );

        InputStream inputStream = executor.executeQuery(
                new File(MappingExecutor.class.getClassLoader().getResource("/selectQueries/select" + aspectName + ".rq").getFile()))
                .get();
        String result = new String(inputStream.readAllBytes());
        assertEquals(result, getMockResponseBody(aspectName));
    }

    private MockWebServer instantiateMockServer(String aspectName) throws IOException, URISyntaxException {
        MockWebServer mockServer = new MockWebServer();
        String mockResponseBody = getMockResponseBody(aspectName);
        MockResponse response = new MockResponse()
                .addHeader("Content-Type", "application/xml; charset=utf-8")
                .setBody(mockResponseBody)
                .setResponseCode(200);
        mockServer.url(MOCK_URL).toString();
        mockServer.enqueue(response);

        return mockServer;
    }

    private String getMockResponseBody(String aspectName) throws IOException {
        String mockResponseBody = new String(getClass().getClassLoader()
                .getResourceAsStream("sparqlResponseXml/"+ aspectName +"-sparql-results.xml")
                .readAllBytes());
        return mockResponseBody;
    }

    private String getProperty(Submodel submodel, String propertyIdShort) {
        return submodel.getSubmodelElements().stream()
                .filter(sme->sme.getClass().equals(DefaultProperty.class))
                .map(sme->(Property)sme)
                .filter(p->p.getIdShort().equals(propertyIdShort))
                .findFirst().map(Property::getValue)
                .orElseThrow(()-> new RuntimeException("propertyNotFound"));
    }

    private Collection<SubmodelElement> getSmcValues(Submodel submodel, String idShort) {
        return submodel.getSubmodelElements().stream()
                .filter(sme->sme.getClass().equals(DefaultSubmodelElementCollection.class))
                .map(sme->(SubmodelElementCollection)sme)
                .filter(smc -> smc.getIdShort().equals(idShort))
                .findFirst().map(SubmodelElementCollection::getValues)
                .orElseThrow(()-> new RuntimeException("smcNotFound"));

    }

    private List<SubmodelElement> getSmes(Collection<SubmodelElement> smc, String idShort) {
        return smc.stream().filter(sme -> sme.getIdShort().equals(idShort)).collect(Collectors.toList());
    }


}
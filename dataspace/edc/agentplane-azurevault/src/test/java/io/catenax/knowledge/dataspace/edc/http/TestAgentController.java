//
// EDC Data Plane Agent Extension Test
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.http;

import io.catenax.knowledge.dataspace.edc.AgentConfig;
import io.catenax.knowledge.dataspace.edc.TestConfig;
import io.catenax.knowledge.dataspace.edc.sparql.DataspaceServiceExecutor;
import io.catenax.knowledge.dataspace.edc.sparql.SparqlQueryProcessor;
import okhttp3.OkHttpClient;
import org.apache.jena.sparql.service.ServiceExecutorRegistry;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.apache.jena.fuseki.Fuseki;
import org.eclipse.dataspaceconnector.spi.monitor.ConsoleMonitor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletContext;

import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;

import java.util.List;

/**
 * Tests the agent controller
 */
public class TestAgentController {
    
    ConsoleMonitor monitor=new ConsoleMonitor();
    TestConfig config=new TestConfig();
    AgentConfig agentConfig=new AgentConfig(monitor,config);
    ServiceExecutorRegistry reg=new ServiceExecutorRegistry();
    OkHttpClient client=new OkHttpClient();
    DataspaceServiceExecutor exec=new DataspaceServiceExecutor(monitor,null,agentConfig,client);
    SparqlQueryProcessor processor=new SparqlQueryProcessor(reg,monitor,agentConfig);
    AgentController agentController=new AgentController(monitor,null,agentConfig,null,processor);

    AutoCloseable mocks=null;

    @BeforeEach
    public void setUp()  {
        mocks=MockitoAnnotations.openMocks(this);
        reg.add(exec);
    }

    @AfterEach
    public void tearDown() throws Exception {
        if(mocks!=null) {
            mocks.close();
            mocks=null;
            reg.remove(exec);
        }
    }
    
    @Mock
    HttpServletRequest request;
 
    @Mock
    HttpServletResponse response;

    @Mock
    ServletContext context;

    ObjectMapper mapper=new ObjectMapper();

    /**
     * execution helper
     * @param method http method
     * @param query optional query
     * @param asset optional asset name
     * @param accepts determines return representation
     * @param params additional parameters
     * @return response body as string
     */
    protected String testExecute(String method, String query, String asset, String accepts, List<Map.Entry<String,String>> params) throws IOException {
        Map<String,String[]> fparams=new HashMap<>();
        StringBuilder queryString=new StringBuilder();
        boolean isFirst=true;
        for(Map.Entry<String,String> param : params) {
            if(isFirst) {
                isFirst=false;
            } else {
                queryString.append("&");
            }
            queryString.append(URLEncoder.encode(param.getKey(), StandardCharsets.UTF_8));
            queryString.append("=");
            queryString.append(URLEncoder.encode(param.getValue(), StandardCharsets.UTF_8));
            if(fparams.containsKey(param.getKey())) {
                String[] oarray=fparams.get(param.getKey());
                String[] narray=new String[oarray.length+1];
                System.arraycopy(oarray,0,narray,0,oarray.length);
                narray[oarray.length]=param.getValue();
                fparams.put(param.getKey(),narray);
            } else {
                String[] narray=new String[] { param.getValue() };
                fparams.put(param.getKey(),narray);
            }
        }
        when(request.getQueryString()).thenReturn(queryString.toString());
        when(request.getMethod()).thenReturn(method);
        if(query!=null) {
            fparams.put("query",new String[] { query });
            when(request.getParameter("query")).thenReturn(query);
        }
        if(asset!=null) {
            fparams.put("asset",new String[] { asset });
            when(request.getParameter("asset")).thenReturn(asset);
        }
        when(request.getParameterMap()).thenReturn(fparams);
        when(request.getServletContext()).thenReturn(context);
        when(request.getHeaders("Accept")).thenReturn(Collections.enumeration(List.of(accepts)));
        when(context.getAttribute(Fuseki.attrVerbose)).thenReturn(false);
        when(context.getAttribute(Fuseki.attrOperationRegistry)).thenReturn(processor.getOperationRegistry());
        when(context.getAttribute(Fuseki.attrNameRegistry)).thenReturn(processor.getDataAccessPointRegistry());
        when(context.getAttribute(Fuseki.attrNameRegistry)).thenReturn(processor.getDataAccessPointRegistry());
        ByteArrayOutputStream responseStream=new ByteArrayOutputStream();
        MockServletOutputStream mos=new MockServletOutputStream(responseStream);
        when(response.getOutputStream()).thenReturn(mos);
        agentController.getQuery(request, response, asset);
        return responseStream.toString();
    }

    /**
     * test canonical call with fixed binding
     * @throws IOException in case of an error
     */
    @Test
    public void testFixedQuery() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?what WHERE { VALUES (?what) { (\"42\"^^xsd:int)} }";
        String result=testExecute("GET",query,null,"*/*",new ArrayList<>());
        JsonNode root=mapper.readTree(result);
        ArrayNode bindings=(ArrayNode) root.get("results").get("bindings");
        assertEquals(1,bindings.size(),"Correct number of result bindings.");
        JsonNode whatBinding0=bindings.get(0).get("what");
        assertEquals("42",whatBinding0.get("value").asText(),"Correct binding");
    }

    /**
     * test canonical call with simple replacement binding
     * @throws IOException in case of an error
     */
    @Test
    public void testParameterizedQuerySingle() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?what WHERE { VALUES (?what) { (\"@input\"^^xsd:int)} }";
        String result=testExecute("GET",query,null,"*/*",List.of(new AbstractMap.SimpleEntry<>("input","84")));
        JsonNode root=mapper.readTree(result);
        ArrayNode bindings=(ArrayNode) root.get("results").get("bindings");
        assertEquals(1,bindings.size(),"Correct number of result bindings.");
        JsonNode whatBinding0=bindings.get(0).get("what");
        assertEquals("84",whatBinding0.get("value").asText(),"Correct binding");
    }

    /**
     * test canonical call with simple replacement binding
     * @throws IOException in case of an error
     */
    @Test
    public void testParameterizedQueryMultiSingleResult() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?what WHERE { VALUES ?what { \"@input\"^^xsd:int } }";
        String result=testExecute("GET",query,null,"*/*",List.of(new AbstractMap.SimpleEntry<>("input","42"),new AbstractMap.SimpleEntry<>("input","84")));
        JsonNode root=mapper.readTree(result);
        ArrayNode bindings=(ArrayNode) root.get("results").get("bindings");
        assertEquals(1,bindings.size(),"Correct number of result bindings.");
        JsonNode whatBinding0=bindings.get(0).get("what");
        assertEquals("42",whatBinding0.get("value").asText(),"Correct binding");
    }

    /**
     * test canonical call with simple replacement binding
     * @throws IOException in case of an error
     */
    @Test
    public void testParameterizedQueryMultiMultiResult() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?what WHERE { VALUES (?what) { (\"@input\"^^xsd:int)} }";
        String result=testExecute("GET",query,null,"*/*",List.of(new AbstractMap.SimpleEntry<>("input","42"),new AbstractMap.SimpleEntry<>("input","84")));
        JsonNode root=mapper.readTree(result);
        ArrayNode bindings=(ArrayNode) root.get("results").get("bindings");
        assertEquals(2,bindings.size(),"Correct number of result bindings.");
        JsonNode whatBinding0=bindings.get(0).get("what");
        assertEquals("42",whatBinding0.get("value").asText(),"Correct binding");
        JsonNode whatBinding1=bindings.get(1).get("what");
        assertEquals("84",whatBinding1.get("value").asText(),"Correct binding");
    }

    /**
     * test canonical call with simple replacement binding
     * @throws IOException in case of an error
     */
    @Test
    public void testParameterizedQueryTupleResult() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?so ?what WHERE { VALUES (?so ?what) { (\"@input1\"^^xsd:int \"@input2\"^^xsd:int)} }";
        String result=testExecute("GET",query,null,"*/*",
            List.of(new AbstractMap.SimpleEntry<>("input1","42"),
                    new AbstractMap.SimpleEntry<>("input2","84"),
                    new AbstractMap.SimpleEntry<>("input1","43"),
                    new AbstractMap.SimpleEntry<>("input2","85")
                    ));
        JsonNode root=mapper.readTree(result);
        ArrayNode bindings=(ArrayNode) root.get("results").get("bindings");
        assertEquals(4,bindings.size(),"Correct number of result bindings.");
        JsonNode soBinding0=bindings.get(0).get("so");
        assertEquals("42",soBinding0.get("value").asText(),"Correct binding 0");
        JsonNode whatBinding0=bindings.get(0).get("what");
        assertEquals("84",whatBinding0.get("value").asText(),"Correct binding 0");
        JsonNode soBinding1=bindings.get(1).get("so");
        assertEquals("43",soBinding1.get("value").asText(),"Correct binding 1");
        JsonNode whatBinding1=bindings.get(1).get("what");
        assertEquals("84",whatBinding1.get("value").asText(),"Correct binding 1");
        JsonNode soBinding2=bindings.get(2).get("so");
        assertEquals("42",soBinding2.get("value").asText(),"Correct binding 2");
        JsonNode whatBinding2=bindings.get(2).get("what");
        assertEquals("85",whatBinding2.get("value").asText(),"Correct binding 2");
        JsonNode soBinding3=bindings.get(3).get("so");
        assertEquals("43",soBinding3.get("value").asText(),"Correct binding 3");
        JsonNode whatBinding3=bindings.get(3).get("what");
        assertEquals("85",whatBinding3.get("value").asText(),"Correct binding 3");
    }

    /**
     * test canonical call with simple replacement binding
     * @throws IOException in case of an error
     */
    @Test
    public void testParameterizedQueryTupleResultOrderIrrelevant() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?so ?what WHERE { VALUES (?so ?what) { (\"@input1\"^^xsd:int \"@input2\"^^xsd:int)} }";
        String result=testExecute("GET",query,null,"*/*",
            List.of(new AbstractMap.SimpleEntry<>("input2","84"),
                    new AbstractMap.SimpleEntry<>("input2","85"),
                    new AbstractMap.SimpleEntry<>("input1","42"),
                    new AbstractMap.SimpleEntry<>("input1","43")
                    ));
        JsonNode root=mapper.readTree(result);
        ArrayNode bindings=(ArrayNode) root.get("results").get("bindings");
        assertEquals(4,bindings.size(),"Correct number of result bindings.");
        JsonNode soBinding0=bindings.get(0).get("so");
        assertEquals("42",soBinding0.get("value").asText(),"Correct binding 0");
        JsonNode whatBinding0=bindings.get(0).get("what");
        assertEquals("84",whatBinding0.get("value").asText(),"Correct binding 0");
        JsonNode soBinding1=bindings.get(1).get("so");
        assertEquals("43",soBinding1.get("value").asText(),"Correct binding 1");
        JsonNode whatBinding1=bindings.get(1).get("what");
        assertEquals("84",whatBinding1.get("value").asText(),"Correct binding 1");
        JsonNode soBinding2=bindings.get(2).get("so");
        assertEquals("42",soBinding2.get("value").asText(),"Correct binding 2");
        JsonNode whatBinding2=bindings.get(2).get("what");
        assertEquals("85",whatBinding2.get("value").asText(),"Correct binding 2");
        JsonNode soBinding3=bindings.get(3).get("so");
        assertEquals("43",soBinding3.get("value").asText(),"Correct binding 3");
        JsonNode whatBinding3=bindings.get(3).get("what");
        assertEquals("85",whatBinding3.get("value").asText(),"Correct binding 3");
    }

    /**
     * test canonical call with simple replacement binding
     * @throws IOException in case of an error
     */
    @Test
    public void testParameterizedQueryTupleResultSpecial() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?so ?what ?now WHERE { VALUES (?so ?what) { (\"@input1\"^^xsd:int \"@input2\"^^xsd:int)} VALUES (?now) { (\"@input3\"^^xsd:int)} }";
        String result=testExecute("GET",query,null,"*/*",
            List.of(new AbstractMap.SimpleEntry<>("(input2","84"),
                    new AbstractMap.SimpleEntry<>("input1","42)"),
                    new AbstractMap.SimpleEntry<>("(input2","85"),
                    new AbstractMap.SimpleEntry<>("input1","43)"),
                    new AbstractMap.SimpleEntry<>("input3","21")
                    ));
        JsonNode root=mapper.readTree(result);
        ArrayNode bindings=(ArrayNode) root.get("results").get("bindings");
        assertEquals(2,bindings.size(),"Correct number of result bindings.");
        JsonNode soBinding0=bindings.get(0).get("so");
        assertEquals("42",soBinding0.get("value").asText(),"Correct binding 0");
        JsonNode whatBinding0=bindings.get(0).get("what");
        assertEquals("84",whatBinding0.get("value").asText(),"Correct binding 0");
        JsonNode nowBinding0=bindings.get(0).get("now");
        assertEquals("21",nowBinding0.get("value").asText(),"Correct binding 0");
        JsonNode soBinding1=bindings.get(1).get("so");
        assertEquals("43",soBinding1.get("value").asText(),"Correct binding 1");
        JsonNode whatBinding1=bindings.get(1).get("what");
        assertEquals("85",whatBinding1.get("value").asText(),"Correct binding 1");
        JsonNode nowBinding1=bindings.get(1).get("now");
        assertEquals("21",nowBinding1.get("value").asText(),"Correct binding 1");
    }

    /**
     * test canonical call with simple replacement binding
     * @throws IOException in case of an error
     */
    @Test
    @Tag("online")
    public void testParameterizedSkill() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?what WHERE { VALUES (?what) { (\"@input\"^^xsd:int)} }";
        String asset="urn:cx:Skill:cx:Test";
        agentController.postSkill(query,asset);
        String result=testExecute("GET",null,asset,"*/*",List.of(new AbstractMap.SimpleEntry<>("input","84")));
        JsonNode root=mapper.readTree(result);
        JsonNode whatBinding0=root.get("results").get("bindings").get(0).get("what");
        assertEquals("84",whatBinding0.get("value").asText(),"Correct binding");
    }

    /**
     * test federation call - will only work with a local oem provider running
     * @throws IOException in case of an error
     */
    @Test
    @Tag("online")
    public void testFederatedSkill() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?what WHERE { SERVICE<http://localhost:8080/sparql> { VALUES (?what) { (\"@input\"^^xsd:int)} } }";
        String asset="urn:cx:Skill:cx:Test";
        agentController.postSkill(query,asset);
        String result=testExecute("GET",null,asset,"*/*",List.of(new AbstractMap.SimpleEntry<>("input","84")));
        JsonNode root=mapper.readTree(result);
        JsonNode whatBinding0=root.get("results").get("bindings").get(0).get("what");
        assertEquals("84",whatBinding0.get("value").asText(),"Correct binding");
    }

}

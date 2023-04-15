//
// EDC Data Plane Agent Extension Test
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.http;

import io.catenax.knowledge.dataspace.edc.*;
import io.catenax.knowledge.dataspace.edc.rdf.RDFStore;
import io.catenax.knowledge.dataspace.edc.sparql.DataspaceServiceExecutor;
import io.catenax.knowledge.dataspace.edc.sparql.SparqlQueryProcessor;
import okhttp3.*;
import org.apache.jena.sparql.service.ServiceExecutorRegistry;
import org.eclipse.dataspaceconnector.spi.types.TypeManager;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
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
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Tests the agent controller
 */
public class TestAgentController {
    
    ConsoleMonitor monitor=new ConsoleMonitor();
    TestConfig config=new TestConfig();
    AgentConfig agentConfig=new AgentConfig(monitor,config);
    ServiceExecutorRegistry serviceExecutorReg=new ServiceExecutorRegistry();
    OkHttpClient client=new OkHttpClient();
    IAgreementController mockController = new MockAgreementController();
    ExecutorService threadedExecutor= Executors.newSingleThreadExecutor();
    TypeManager typeManager = new TypeManager();
    DataspaceServiceExecutor exec=new DataspaceServiceExecutor(monitor,mockController,agentConfig,client,threadedExecutor,typeManager,agentConfig);
    RDFStore store = new RDFStore(agentConfig,monitor);


    SparqlQueryProcessor processor=new SparqlQueryProcessor(serviceExecutorReg,monitor,agentConfig,store, typeManager);
    SkillStore skillStore=new SkillStore();


    AgentController agentController=new AgentController(monitor,mockController,agentConfig,null,processor,skillStore);

    AutoCloseable mocks=null;

    @BeforeEach
    public void setUp()  {
        mocks=MockitoAnnotations.openMocks(this);
        //serviceExecutorReg.add(exec);
        serviceExecutorReg.addBulkLink(exec);
    }

    @AfterEach
    public void tearDown() throws Exception {
        if(mocks!=null) {
            mocks.close();
            mocks=null;
            serviceExecutorReg.remove(exec);
            serviceExecutorReg.removeBulkLink(exec);
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
        agentController.getQuery(asset,null,request,response,null);
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
     * test canonical call with replacement binding which should not confuse the filtering
     * @throws IOException in case of an error
     */
    @Test
    public void testParameterizedQueryFilterContains() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?so ?what WHERE { VALUES(?so ?what) {(\"@input1\"^^xsd:string \"@input2\"^^xsd:string)} FILTER CONTAINS(?so,?what) }";
        String result=testExecute("GET",query,null,"*/*",
                List.of(new AbstractMap.SimpleEntry<>("(input2","BAR"),
                        new AbstractMap.SimpleEntry<>("input1","FOOBAR)"),
                        new AbstractMap.SimpleEntry<>("(input2","BLUB"),
                        new AbstractMap.SimpleEntry<>("input1","NOOB)")
                ));
        JsonNode root=mapper.readTree(result);
        ArrayNode bindings=(ArrayNode) root.get("results").get("bindings");
        assertEquals(1,bindings.size(),"Correct number of result bindings.");
        JsonNode soBinding0=bindings.get(0).get("so");
        assertEquals("FOOBAR",soBinding0.get("value").asText(),"Correct binding 0");
        JsonNode whatBinding0=bindings.get(0).get("what");
        assertEquals("BAR",whatBinding0.get("value").asText(),"Correct binding 0");
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
    public void testRemotingSkill() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?what WHERE { SERVICE<http://localhost:8080/sparql> { VALUES (?what) { (\"@input\"^^xsd:int)} } }";
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
    public void testFederatedGraph() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?what WHERE { SERVICE<edc://localhost:8080/sparql> { " +
                "GRAPH <urn:cx:Graph:4711> { VALUES (?what) { (\"42\"^^xsd:int)} } } }";
        Request.Builder builder=new Request.Builder();
        builder.url("http://localhost:8080");
        builder.addHeader("Accept","application/json");
        builder.put(RequestBody.create(query, MediaType.parse("application/sparql-query")));
        Response response=processor.execute(builder.build(),null,null,null,null);
        JsonNode root=mapper.readTree(response.body().string());
        JsonNode whatBinding0=root.get("results").get("bindings").get(0).get("what");
        assertEquals("42",whatBinding0.get("value").asText(),"Correct binding");
    }

    /**
     * test federation call - will only work with a local oem provider running
     * @throws IOException in case of an error
     */
    @Test
    @Tag("online")
    public void testFederatedServiceChain() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?what WHERE { VALUES (?chain1) { (<http://localhost:8080/sparql#urn:cx:Graph:1>)} SERVICE ?chain1 { " +
                "VALUES (?chain2) { (<http://localhost:8080/sparql>)} SERVICE ?chain2 { VALUES (?what) { (\"42\"^^xsd:int)} } } }";
        Request.Builder builder=new Request.Builder();
        builder.url("http://localhost:8080");
        builder.addHeader("Accept","application/sparql-results+json");
        builder.put(RequestBody.create(query, MediaType.parse("application/sparql-query")));
        Response response=processor.execute(builder.build(),null,null,null,null);
        assertEquals(true,response.isSuccessful(),"Response was successful");
        JsonNode root=mapper.readTree(response.body().string());
        JsonNode whatBinding0=root.get("results").get("bindings").get(0).get("what");
        assertEquals("84",whatBinding0.get("value").asText(),"Correct binding");
    }

    /**
     * test remote call with non-existing target
     * @throws IOException in case of an error
     */
    @Test
    public void testRemoteError() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?what WHERE { SERVICE <http://does-not-resolve/sparql#urn:cx:Graph:1> { VALUES (?what) { (\"42\"^^xsd:int) } } }";
        Request.Builder builder=new Request.Builder();
        builder.url("http://localhost:8080");
        builder.addHeader("Accept","application/sparql-results+json");
        builder.put(RequestBody.create(query, MediaType.parse("application/sparql-query")));
        Response response=processor.execute(builder.build(),null,null,null,null);
        assertEquals(true,response.isSuccessful(),"Response was successful");
        JsonNode root=mapper.readTree(response.body().string());
        assertEquals(0,root.get("results").get("bindings").size());
        String warnings=response.header("cx_warnings");
        JsonNode warningsJson=mapper.readTree(warnings);
        assertEquals(1,warningsJson.size(),"got remote warnings");
    }

    /**
     * test remote call with matchmaking agent
     * @throws IOException in case of an error
     */
    @Test
    @Tag("online")
    public void testRemoteWarning() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?what WHERE { SERVICE <http://localhost:8898/match?asset=urn%3Acx%3AGraphAsset%23Test> { VALUES (?what) { (\"42\"^^xsd:int) } } }";
        Request.Builder builder=new Request.Builder();
        builder.url("http://localhost:8080");
        builder.addHeader("Accept","application/sparql-results+json");
        builder.put(RequestBody.create(query, MediaType.parse("application/sparql-query")));
        Response response=processor.execute(builder.build(),null,null,null,null);
        assertEquals(true,response.isSuccessful(),"Response was successful");
        JsonNode root=mapper.readTree(response.body().string());
        assertEquals(1,root.get("results").get("bindings").size());
        String warnings=response.header("cx_warnings");
        JsonNode warningsJson=mapper.readTree(warnings);
        assertEquals(1,warningsJson.size(),"got remote warnings");
    }

    /**
     * test remote call with matchmaking agent
     * @throws IOException in case of an error
     */
    @Test
    @Tag("online")
    public void testRemoteTransfer() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> SELECT ?what WHERE { SERVICE <http://localhost:8898/transfer?asset=urn%3Acx%3AGraphAsset%23Test> { VALUES (?what) { (\"42\"^^xsd:int) } } }";
        Request.Builder builder=new Request.Builder();
        builder.url("http://localhost:8080");
        builder.addHeader("Accept","application/sparql-results+json");
        builder.put(RequestBody.create(query, MediaType.parse("application/sparql-query")));
        Response response=processor.execute(builder.build(),null,null,null,null);
        assertEquals(true,response.isSuccessful(),"Response was successful");
        JsonNode root=mapper.readTree(response.body().string());
        assertEquals(1,root.get("results").get("bindings").size());
        String warnings=response.header("cx_warnings");
        JsonNode warningsJson=mapper.readTree(warnings);
        assertEquals(1,warningsJson.size(),"got remote warnings");
    }

    /**
     * test federation call - will only work with a local oem provider running
     * @throws IOException in case of an error
     */
    @Test
    @Tag("online")
    public void testBatchFederation() throws IOException {
        String query="PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> "+
                "SELECT ?chain1 ?what ?output WHERE { " +
                "  VALUES (?chain1 ?what) { "+
                "   (<http://localhost:8080/sparql#urn:cx:Graph:1> \"42\"^^xsd:int) "+
                "   (<http://localhost:8080/sparql#urn:cx:Graph:2> \"21\"^^xsd:int) "+
                "   (<http://localhost:8080/sparql#urn:cx:Graph:1> \"84\"^^xsd:int) "+
                "  } "+
                "  SERVICE ?chain1 { " +
                "    BIND(?what as ?output) "+
                "  } "+
                "}";
        Request.Builder builder=new Request.Builder();
        builder.url("http://localhost:8080");
        builder.addHeader("Accept","application/sparql-results+json");
        builder.put(RequestBody.create(query, MediaType.parse("application/sparql-query")));
        Response response=processor.execute(builder.build(),null,null,null,null);
        assertEquals(true,response.isSuccessful(),"Successful result");
        JsonNode root=mapper.readTree(response.body().string());
        JsonNode bindings=root.get("results").get("bindings");
        assertEquals(3,bindings.size(),"Correct number of result bindings.");
        JsonNode whatBinding0=bindings.get(0).get("output");
        assertEquals("21",whatBinding0.get("value").asText(),"Correct binding");
        JsonNode whatBinding1=bindings.get(1).get("output");
        assertEquals("42",whatBinding1.get("value").asText(),"Correct binding");
        JsonNode whatBinding2=bindings.get(2).get("output");
        assertEquals("84",whatBinding2.get("value").asText(),"Correct binding");
    }

}

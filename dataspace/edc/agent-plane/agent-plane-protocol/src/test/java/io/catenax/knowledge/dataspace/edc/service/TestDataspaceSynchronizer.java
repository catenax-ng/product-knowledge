//
// EDC Data Plane Agent Extension Test
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.service;

import io.catenax.knowledge.dataspace.edc.*;
import io.catenax.knowledge.dataspace.edc.rdf.RDFStore;
import okhttp3.*;
import org.apache.jena.graph.Node;
import org.apache.jena.sparql.core.Quad;
import org.eclipse.edc.policy.model.Policy;
import org.eclipse.edc.spi.types.TypeManager;
import org.eclipse.edc.spi.types.domain.asset.Asset;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

import org.eclipse.edc.spi.monitor.ConsoleMonitor;
import org.apache.jena.graph.NodeFactory;


import org.mockito.MockitoAnnotations;

import java.time.ZonedDateTime;
import java.util.Collection;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;

import org.eclipse.edc.connector.contract.spi.types.offer.ContractOffer;

/**
 * Tests the dataspace synchronization
 */
public class TestDataspaceSynchronizer {
    
    ConsoleMonitor monitor=new ConsoleMonitor();
    TestConfig config=new TestConfig();
    AgentConfig agentConfig=new AgentConfig(monitor,config);
    OkHttpClient client=new OkHttpClient();
    ScheduledExecutorService threadedExecutor= Executors.newSingleThreadScheduledExecutor();
    RDFStore store = new RDFStore(agentConfig,monitor);

    TypeManager typeManager=new TypeManager();

    DataManagement dm=new DataManagement(monitor,typeManager,client,agentConfig);
    DataspaceSynchronizer synchronizer = new DataspaceSynchronizer(threadedExecutor,agentConfig,dm,store,monitor);

    AutoCloseable mocks=null;

    @BeforeEach
    public void setUp()  {
        mocks=MockitoAnnotations.openMocks(this);
    }

    @AfterEach
    public void tearDown() throws Exception {
        if(mocks!=null) {
            mocks.close();
            mocks=null;
        }
    }
    
    /**
     * test quad representation of a contract offer
     */
    @Test
    public void testQuadRepresentation()  {
        Node graph = store.getDefaultGraph();
        Node connector = NodeFactory.createURI("edc://test");
        Asset asset = Asset.Builder.newInstance()
                .id("urn:cx:test:ExampleAsset")
                .contentType("application/json, application/xml")
                .version("0.8.6-SNAPSHOT")
                .name("Test Asset")
                .description("Test Asset for RDF Representation")
                .property("asset:prop:contract","<urn:cx:test:Contract>")
                .property("rdf:type","<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#GraphAsset>")
                .property("rdfs:isDefinedBy","<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/diagnosis_ontology.ttl>,<https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/part_ontology.ttl>")
                .property("cx:protocol","<urn:cx:Protocol:w3c:Http#SPARQL>")
                .property("cx:shape","@prefix : <urn:cx:Graph:oem:Diagnosis2022> .\n@prefix cx: <https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#> .\n@prefix cx-diag: <https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/diagnosis_ontology.ttl#> .\n@prefix owl: <http://www.w3.org/2002/07/owl#> .\n@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\\n@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n@prefix sh: <http://www.w3.org/ns/shacl#> .\n\n:OemDTC rdf:type sh:NodeShape ;\n  sh:targetClass cx:DTC ;\n  sh:property [\n        sh:path cx:provisionedBy ;\n        sh:hasValue <urn:bpn:legal:BPNL00000003COJN> ;\n    ] ;\n  sh:property [\n        sh:path cx:Version ;\n        sh:hasValue \"0\"^^xsd:long ;\n    ] ;\n  sh:property [\n        sh:path cx:affects ;\n        sh:class :OemDiagnosedParts ;\n    ] ;\n\n:OemDiagnosedParts rdf:type sh:NodeShape ;\n  sh:targetClass cx:DiagnosedPart ;\n  sh:property [\n        sh:path cx:provisionedBy ;\n        sh:hasValue <urn:bpn:legal:BPNL00000003COJN> ;\n    ] ;\n")
                .property("cx:isFederated","true")
                .build();
        Policy policy = Policy.Builder.newInstance().build();
        ContractOffer offer = ContractOffer.Builder.newInstance().id("urn:cx:test:Contract").policy(policy).contractStart(ZonedDateTime.now()).contractEnd(ZonedDateTime.now().plusDays(1)).asset(asset).build();
        Collection<Quad> result=synchronizer.convertToQuads(graph, connector, offer);
        assertEquals(12,result.size(),"Got correct number of quads (1 connector subject and 11 asset subjects).");
    }

}

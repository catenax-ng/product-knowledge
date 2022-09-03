//
// Application to provide REST APIs as SPARQL services
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.remoting;

import org.eclipse.rdf4j.model.*;
import org.eclipse.rdf4j.model.util.*;
import org.eclipse.rdf4j.model.vocabulary.*;

import org.eclipse.rdf4j.query.*;

import org.eclipse.rdf4j.repository.Repository;
import org.eclipse.rdf4j.repository.RepositoryConnection;
import org.eclipse.rdf4j.repository.RepositoryResult;
import org.eclipse.rdf4j.repository.sail.SailRepository;
import org.eclipse.rdf4j.sail.memory.MemoryStore;
import org.eclipse.rdf4j.common.iteration.Iterations;

import org.eclipse.rdf4j.rio.*;


/**
 * The main application for the SparQL endpoint
 */
public class Application {

    public static void main(String[] args) {
        Repository rep = new SailRepository(new MemoryStore());
        Namespace ex = Values.namespace("ex", "http://example.org/");
        IRI john = Values.iri(ex, "john");
        try (RepositoryConnection conn = rep.getConnection()) {
            conn.add(john, RDF.TYPE, FOAF.PERSON);
            conn.add(john, RDFS.LABEL, Values.literal("John"));
            RepositoryResult<Statement> statements = conn.getStatements(null, null, null);
            Model model = QueryResults.asModel(statements);
            Rio.write(model, System.out, RDFFormat.TURTLE);
        }
        RemotingSailConfig rsc=new RemotingSailConfig(RemotingSailFactory.SAIL_TYPE);
        InvocationConfig ic=new InvocationConfig();
        rsc.invocations.put("https://github.com/catenax-ng/product-knowledge/ontology/prognosis.ttl#Invocation",ic);
        ic.targetUri="class:io.catenax.knowledge.agents.remoting.TestFunction#test";
        ArgumentConfig ac=new ArgumentConfig();
        ac.argumentName = "arg0";
        ic.arguments.put("https://github.com/catenax-ng/product-knowledge/ontology/prognosis.ttl#input-1",ac);
        ac=new ArgumentConfig();
        ac.argumentName = "arg1";
        ic.arguments.put("https://github.com/catenax-ng/product-knowledge/ontology/prognosis.ttl#input-2",ac);
        ReturnValueConfig rc=new ReturnValueConfig();
        ic.outputs.put("https://github.com/catenax-ng/product-knowledge/ontology/prognosis.ttl#output",rc);
        
        rsc.validate();

        rep = new SailRepository(new RemotingSail(rsc));
        try (RepositoryConnection conn = rep.getConnection()) {
            //conn.add(john, RDF.TYPE, FOAF.PERSON);
            //conn.add(john, RDFS.LABEL, Values.literal("John"));
            TupleQuery query=(TupleQuery) conn.prepareQuery(QueryLanguage.SPARQL,
            "PREFIX cx: <https://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#> "+
            "PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> "+
            "PREFIX prognosis: <https://github.com/catenax-ng/product-knowledge/ontology/prognosis.ttl#> "+
            "SELECT ?output "+
            "WHERE { "+
            "?invocation a prognosis:Invocation; "+
            "            prognosis:input-1 \"1\"^^xsd:string; "+
            "            prognosis:input-2 \"2\"^^xsd:string; "+
            "            prognosis:output ?output. "+
            "}");
            final TupleQueryResult result = query.evaluate();
		    final String[] names = result.getBindingNames().toArray(new String[0]);
		    java.util.List<BindingSet> bindings = Iterations.asList(result);
		    System.out.println("Got bindings "+bindings.size());
        }
    }
}
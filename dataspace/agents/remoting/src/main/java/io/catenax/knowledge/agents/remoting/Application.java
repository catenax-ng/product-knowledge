//
// Application to provide REST APIs as SPARQL services
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.remoting;

import org.eclipse.rdf4j.common.iteration.Iterations;
import org.eclipse.rdf4j.query.BindingSet;
import org.eclipse.rdf4j.query.QueryLanguage;
import org.eclipse.rdf4j.query.TupleQuery;
import org.eclipse.rdf4j.query.TupleQueryResult;
import org.eclipse.rdf4j.repository.Repository;
import org.eclipse.rdf4j.repository.RepositoryConnection;
import org.eclipse.rdf4j.repository.sail.SailRepository;

import java.util.Arrays;


/**
 * A sample main application which exposes an RDF4J-SparQL endpoint
 * with a fixed binding. Just to demonstrate how to build custom servers.
 * Usually, this library is added to the rdf4j lib path and the
 * endpoints/repositories using the function binding are then defined
 * declaratively.
 */
public class Application {


    @Override
    public String toString() {
        return super.toString()+"/application";
    }

    /**
     * main logic sets up the rdf4j server programatically.
     * @param args command line args
     */

    public static void main(String[] args) {        
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
        ReturnValueConfig rvc=new ReturnValueConfig();
        ResultConfig rc=new ResultConfig();
        rc.outputs.put("https://github.com/catenax-ng/product-knowledge/ontology/prognosis.ttl#output",rvc);
        ic.result=rc;
        ic.resultName="https://github.com/catenax-ng/product-knowledge/ontology/prognosis.ttl#Result";

        rsc.validate();

        Repository rep = new SailRepository(new RemotingSail(rsc));
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
            System.out.println("Got variables "+Arrays.toString(names));
		    java.util.List<BindingSet> bindings = Iterations.asList(result);
		    System.out.println("Got bindings "+Arrays.toString(bindings.toArray(new BindingSet[0])));
        }
    }
}
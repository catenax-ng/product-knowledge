package net.catenax.semantics.triples;

import net.catenax.semantics.connector.LoggerMonitor;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;

import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * A helper class to deal with parsing/evaluating Sparql Queries
 */
public class SparqlHelper {

    /**
     * three different sparql commands
     */
    public static enum SparqlCommand {
        INSERT,
        DELETE,
        SELECT
    }

    /**
     * a regular expression to extract the command of the query
     */
    protected final static Pattern COMMAND_PATTERN=Pattern.compile("(?<Command>SELECT|INSERT|DELETE)[^;]*WHERE\\s*\\{[^;]*\\}");

    /**
     * a regular expression to extract the (graph, service, logic) contexts
     * out of a sparql query
     */
    protected final static Pattern CONTEXT_PATTERN=Pattern.compile("(?<Open>(?<Context>(?<Type>GRAPH|SERVICE|FROM|INTO)\\s*\\<(?<Urn>[^\\>]+)\\>)?\\s*\\{)|(?<Close>\\})");

    /**
     * logging facility
     */
    protected final Monitor monitor;

    /**
     * create a new SparQL Helper in the runtime
     * @param monitor the actual runtime monitor interface
     */
    public SparqlHelper(Monitor monitor) {
        this.monitor=monitor;
    }

    /**
     * create a new SparQL Helper for test purposes
     * use a default monitor/logger
     */
    public SparqlHelper() {
        this(new LoggerMonitor());
    }

    /**
     * analyse query command inside a given graph
     * @param query the SparQL query
     * @return detected command
     */
    public SparqlCommand analyseCommand(String query) {
        Matcher matcher=COMMAND_PATTERN.matcher(query);
        if(!matcher.find()) {
            return null;
        } else {
            return SparqlCommand.valueOf(matcher.group(1));
        }
    }

    /**
     * analyse query context inside a given graph
     * @param graph target graph of the query
     * @param query the SparQL query
     * @return a set of graphs which build the (joined) contexts of the query, we do not account graphs in remote services to these.
     */
    public Set<String> analyseContext(String graph, String query) {

        int depth=0;
        Set<String> context=new java.util.HashSet<String>();
        context.add(graph);
        int serviceDepth=-1;

        monitor.debug(String.format("Analysing the query starting with context %s at depth %d",String.join(";",context),depth));

        // Analysing the query
        Matcher matcher=CONTEXT_PATTERN.matcher(query);
        while(matcher.find()) {
            //monitor.info(matcher.group(0));
            if(matcher.group(1)!=null) {

                String newContext=matcher.group(2);

                // check whether we enter a new service context
                if(newContext!=null && serviceDepth<0) {
                    String type=matcher.group(3);
                    // maybe an explicit service annotation
                    if("SERVICE".equals(type)) {
                        serviceDepth=depth;
                    } else {
                        String target=matcher.group(4);
                        // or an implicit from/into clause where the IRI is a remote protocol
                        if(("FROM".equals(type) || "INTO".equals(type)) && target.startsWith("http")) {
                            serviceDepth=depth;
                        } else {
                            // otherwise this annotation should be a graph which we add
                            context.add(target);
                        }
                    }
                }
                depth++;
            } else if(matcher.group(5)!=null) {
                if(depth<=0) {
                    throw new RuntimeException("Too much closing parentheses.");
                }
                depth--;
                if(depth==serviceDepth) {
                    serviceDepth=-1;
                }
            } else {
                throw new RuntimeException("Regular expression problem.");
            }
            monitor.debug(String.format("Iterated at %d-%d to context %s at depth %d",matcher.start(),matcher.end(),String.join(";",context),depth));
        }

        if(depth!=0) {
            throw new RuntimeException("Too much opening parentheses.");
        }
        return context;
    }

    /**
     * run context analysis of a sample query, output and assert the result
     * @param args command line args are ignored
     */
    public static void main(String[] args) {
        Set<String> ref=new SparqlHelper().analyseContext("urn:x-arq:DefaultGraph","PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>\n" +
                "PREFIX bamm: <urn:bamm:io.openmanufacturing:meta-model:1.0.0#>\n" +
                "\n" +
                "SELECT ?aspect\n" +
                "WHERE {\n" +
                "    {\n" +
                "        SERVICE <http://localhost:8182/api/sparql/hub> { \n" +
                "            {?aspect rdf:type bamm:Aspect .}\n" +
                "    UNION\n" +
                "    {\n" +
                "        GRAPH <urn:tenant1:PrivateGraph> { \n" +
                "            ?aspect rdf:type bamm:Aspect .\n" +
                "        }\n" +
                "    }\n" +
                "        }\n" +
                "    }\n" +
                "    UNION\n" +
                "    {\n" +
                "        SERVICE <http://localhost:8183/api/sparql/hub> { \n" +
                "            {?aspect rdf:type bamm:Aspect .}\n" +
                "    UNION\n" +
                "    {\n" +
                "        GRAPH <urn:tenant2:PrivateGraph> { \n" +
                "            ?aspect rdf:type bamm:Aspect .\n" +
                "        }\n" +
                "    }\n" +
                "        }\n" +
                "    }\n" +
                "    UNION\n" +
                "    {\n" +
                "        GRAPH <urn:tenant1:PropagateGraph> { \n" +
                "            ?aspect rdf:type bamm:Aspect .\n" +
                "        }\n" +
                "    }\n" +
                "    UNION\n" +
                "    {\n" +
                "        GRAPH <urn:tenant2:PropagateGraph> { \n" +
                "            ?aspect rdf:type bamm:Aspect .\n" +
                "        }\n" +
                "    }\n" +
                "}\n" +
                "\n");
        System.out.println(String.join(";",ref));
        assert ref.contains("urn:x-arq:DefaultGraph");
        assert ref.contains("urn:tenant1:PropagateGraph");
        assert ref.contains("urn:tenant2:PropagateGraph");
        assert !ref.contains("http://localhost:8182/api/sparql/hub");
        assert !ref.contains("http://localhost:8183/api/sparql/hub");
        assert !ref.contains("urn:tenant1:PrivateGraph");
        assert !ref.contains("urn:tenant1:PrivateGraph");
    }

}

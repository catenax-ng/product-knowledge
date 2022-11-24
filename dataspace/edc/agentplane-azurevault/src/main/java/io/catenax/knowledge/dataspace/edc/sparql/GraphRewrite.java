//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
//
package io.catenax.knowledge.dataspace.edc.sparql;

import org.apache.jena.graph.Node;
import org.apache.jena.sparql.algebra.Op;
import org.apache.jena.sparql.algebra.TransformCopy;
import org.apache.jena.sparql.algebra.op.OpGraph;
import org.apache.jena.sparql.core.Var;
import org.apache.jena.sparql.engine.binding.Binding;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;

import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

/**
 * A rewriter which replaces graphs by their bindings
 * and collects the unique names. Is used for EDC calls
 * in order to deduce the necessary assets to negotiate
 * and replace variables for later exchange with the
 * backend service.
 */
public class GraphRewrite extends TransformCopy {

    protected final List<Binding> bindings;
    protected final Set<String> graphNames=new HashSet<>();

    protected final Monitor monitor;

    public GraphRewrite(Monitor monitor, List<Binding> bindings) {
        super(false);
        this.bindings=bindings;
        this.monitor=monitor;
    }

    @Override
    public OpGraph transform(OpGraph op, Op subOp) {
        Node graphNode=op.getNode();
        if(graphNode.isURI()) {
            graphNames.add(graphNode.getURI());
        } else if(graphNode.isVariable()) {
            Var graphVar=(Var) graphNode;
            if(bindings==null || bindings.isEmpty()) {
                monitor.warning(String.format("Found a graph node %s which is a variable but no binding. Ignoring.",graphVar));
            } else {
                Iterator<Binding> allBindings = bindings.iterator();
                Node bound = null;
                while (bound == null && allBindings.hasNext()) {
                    Binding binding = allBindings.next();
                    if (binding.contains(graphVar)) {
                        bound = binding.get(graphVar);
                    }
                }
                if (bound!=null && bound.isURI()) {
                    graphNames.add(bound.getURI());
                    return new OpGraph(bound, subOp);
                } else {
                    monitor.warning(String.format("Found a graph node binding %s which is no uri. Ignoring.", bound));
                }
            }
        } else {
            monitor.warning(String.format("Found a graph node %s which is neither uri or variable. Ignoring.",graphNode));
        }
        return op;
    }

    /**
     * @return set of graph names/assets found
     */
    public Set<String> getGraphNames() {
        return graphNames;
    }

}

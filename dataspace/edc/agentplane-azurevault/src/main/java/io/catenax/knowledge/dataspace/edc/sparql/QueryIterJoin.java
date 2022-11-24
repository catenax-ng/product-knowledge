//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.sparql;

import org.apache.jena.atlas.io.IndentedWriter;
import org.apache.jena.atlas.lib.Lib;
import org.apache.jena.graph.Node;
import org.apache.jena.sparql.core.Var;
import org.apache.jena.sparql.engine.ExecutionContext;
import org.apache.jena.sparql.engine.QueryIterator;
import org.apache.jena.sparql.engine.binding.Binding;
import org.apache.jena.sparql.engine.binding.BindingBuilder;
import org.apache.jena.sparql.engine.iterator.QueryIter1;
import org.apache.jena.sparql.serializer.SerializationContext;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * Query join iterator
 * Prepares the given bindings with a hidden variable which is then projected
 */
public class QueryIterJoin extends QueryIter1 {
    protected final Map<Node,List<Binding>> joinBindings;
    protected final Var idVar;
    protected Iterator<Binding> leftBindings;

    public QueryIterJoin(QueryIterator input, Map<Node,List<Binding>> joinBindings, Var idVar, ExecutionContext execCxt) {
        super(input, execCxt);
        this.joinBindings=joinBindings;
        this.idVar=idVar;
    }

    @Override
    protected void closeSubIterator() {
    }

    @Override
    protected void requestSubCancel() {
    }

    @Override
    public boolean hasNextBinding() {
        return (leftBindings!=null && leftBindings.hasNext()) || hasNextInputBinding();
    }

    protected boolean hasNextInputBinding() {
        if(this.getInput().hasNext()) {
            Binding nextBinding = this.getInput().next();
            Node idNode = nextBinding.get(idVar);
            List<Binding> resultBindings=joinBindings.get(idNode);
            if(resultBindings!=null) {
                leftBindings=resultBindings.stream().map( resultBinding -> {
                    BindingBuilder bb=BindingBuilder.create(resultBinding);
                    nextBinding.forEach( (v,n) -> {
                        if(!resultBinding.contains(v)) {
                            bb.set(v,n);
                        }
                    });
                    return bb.build();
                }).iterator();
            } else {
                leftBindings = null;
            }
            return hasNextBinding();
        } else {
            return false;
        }
    }

    @Override
    public Binding moveToNextBinding() {
        if(leftBindings!=null && leftBindings.hasNext()) {
            return leftBindings.next();
        } else {
            return null;
        }
    }

    @Override
    protected void details(IndentedWriter out, SerializationContext cxt) {
        out.println(Lib.className(this));
    }
}


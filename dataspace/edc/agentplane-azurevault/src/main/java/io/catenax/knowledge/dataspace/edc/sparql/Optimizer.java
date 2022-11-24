//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.sparql;

import org.apache.jena.sparql.algebra.Op;
import org.apache.jena.sparql.algebra.optimize.OptimizerStd;
import org.apache.jena.sparql.algebra.optimize.TransformJoinStrategy;
import org.apache.jena.sparql.util.Context;

/**
 * an optimization strategy which deals with federation better at
 * the level of joins
 */
public class Optimizer extends OptimizerStd {
    public Optimizer(Context context) {
        super(context);
    }

    @Override
    protected Op transformJoinStrategy(Op op) {
        return apply("Federated Index Join strategy", new OptimizeJoinStrategy(), op);
    }

}

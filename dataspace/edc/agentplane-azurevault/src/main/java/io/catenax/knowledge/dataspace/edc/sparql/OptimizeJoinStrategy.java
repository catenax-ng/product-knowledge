//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.sparql;

import org.apache.jena.sparql.algebra.Op;
import org.apache.jena.sparql.algebra.op.OpJoin;
import org.apache.jena.sparql.algebra.op.OpSequence;
import org.apache.jena.sparql.algebra.op.OpService;
import org.apache.jena.sparql.algebra.optimize.TransformJoinStrategy;
import org.apache.jena.sparql.engine.main.JoinClassifier;

/**
 * a join strategy which will always linearize service calls
 * TODO improve to find independent/asynchronous calls which maybe parallelized
 */
public class OptimizeJoinStrategy extends TransformJoinStrategy {

    @Override
    public Op transform(OpJoin opJoin, Op left, Op right) {
        boolean canDoLinear = JoinClassifier.isLinear(opJoin);
        if (canDoLinear) {
            return super.transform(opJoin, left, right);
        } else if(right instanceof OpService) {
            return OpSequence.create(left, right);
        } else {
            return super.transform(opJoin, left, right);
        }
    }
}

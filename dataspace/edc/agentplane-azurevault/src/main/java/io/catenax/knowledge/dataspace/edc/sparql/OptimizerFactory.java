//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
package io.catenax.knowledge.dataspace.edc.sparql;

import org.apache.jena.sparql.algebra.optimize.Rewrite;
import org.apache.jena.sparql.algebra.optimize.RewriteFactory;
import org.apache.jena.sparql.util.Context;

/**
 * a factory for a federation-improved optimization strategy
 */
public class OptimizerFactory implements RewriteFactory {
    @Override
    public Rewrite create(Context context) {
        return new Optimizer(context);
    }
}

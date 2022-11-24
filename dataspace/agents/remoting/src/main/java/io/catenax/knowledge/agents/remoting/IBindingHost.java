//
// Application to provide REST APIs as SPARQL services
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.remoting;

import org.eclipse.rdf4j.query.MutableBindingSet;

import java.util.Collection;
import java.util.Set;

/**
 * Interface to any intermediate stpre
 * which holds information about the bound
 * variables and the incoming/outgoing tuples
 */
public interface IBindingHost {

    Set<String> getVariables();
    Collection<MutableBindingSet> getBindings();

}

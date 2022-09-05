package io.catenax.knowledge.dataspace.edc;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.jena.ext.com.google.common.collect.ArrayListMultimap;

/**
 * Implementation of a compact representation of
 * a tuple set that is the explosion of 
 * - multivalue bindings of individual variables
 * - logical combination of several tuple sets
 */
public class TupleSet {
    
    ArrayListMultimap<String,String> bindings=ArrayListMultimap.create();
    List<TupleSet> explodes=new ArrayList<>();

    /**
     * add a binding to the tuple set
     * @param key variable
     * @param value string value
     * @throws Exception in case that the variable is already bound in the combined tuple sets
     */
    public void add(String key, String value) throws Exception {
        if(explodes.stream().anyMatch( explode -> explode.hasVariable(key))) {
            throw new Exception(String.format("Could not bind variable %s on higher level as it is already bound in an embedded binding.",key));
        }
        bindings.put(key, value);
    }

    /**
     * flattens the representation 
     * @param variables a set of variables
     * @return set of flat tuples.
     * @throws Exception in case that the representation has unintended intersections
     */
    public Collection<Tuple> getTuples(String... variables) throws Exception {

        List<String> ownVars=new ArrayList<>();
        List<String> explodedVars=new ArrayList<>();
        for(String var : variables) {
            if(bindings.containsKey(var)) {
                ownVars.add(var);
            } else {
                explodedVars.add(var);
            }
        }
        Collection<Tuple> explosion=new ArrayList<>();
        for(int count=0;count<explodes.size();count++) {
            explosion.addAll(explodes.get(count).getTuples(explodedVars.toArray(new String[0])));
        }
        if(ownVars.size()>0) {
            for(String key : ownVars) {
                if(explosion.size()==0) {
                    for(String value : bindings.get(key)) {
                        Tuple tuple=new Tuple();
                        tuple.add(key,value);
                        explosion.add(tuple);
                    }        
                } else {
                    Collection<Tuple> nextExplosion= new ArrayList<>();
                    for(String value : bindings.get(key)) {
                        for(Tuple yetTuple : explosion) {
                            Tuple tuple=yetTuple.clone();
                            tuple.add(key,value);
                            nextExplosion.add(tuple);
                        }
                    }
                    explosion=nextExplosion;
                }
            }
        }
        return explosion;
    }

    /**
     * checks whether a particular variable is bound
     * @param key variable name
     * @return existance flag
     */
    public boolean hasVariable(String key) {
        return bindings.containsKey(key) || explodes.stream().anyMatch( explode -> explode.hasVariable(key));
    }

    /**
     * compute the set of bound variables
     * @return set of bound variables
     */
    public Set<String> getVariables() {
        Set<String> myVars=new HashSet<>(bindings.keySet());
        for(int count=0;count<explodes.size();count++) {
            myVars.addAll(explodes.get(count).getVariables());
        }
        return myVars;
    }

    /**
     * merge another tupleset into this one
     * @param other tupleset
     */
    public void merge(TupleSet other) {
        explodes.add(other);
    }

    /**
     * render this object
     */
    @Override
    public String toString() {
        return "Tuple("+bindings.toString()+ "+"+Arrays.toString(explodes.toArray()) + ")";
    }
}

//
// Application to provide REST APIs as SPARQL services
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.remoting;

/**
 * a simple test function to expose
 */
public class TestFunction {


    @Override
    public String toString() {
        return super.toString()+"/test";
    }

    /**
     * test method to expose
     */
    public int test(int operator1,int operator2) {
        return operator1+operator2;
    }    
}

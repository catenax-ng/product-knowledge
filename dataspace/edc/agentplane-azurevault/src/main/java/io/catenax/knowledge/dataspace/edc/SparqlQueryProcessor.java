//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import org.apache.http.HttpStatus;
import org.apache.jena.fuseki.servlets.HttpAction;
import org.apache.jena.fuseki.servlets.SPARQL_QueryGeneral;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.Stack;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * dedicated SparQL query processor which is skill-enabled: Execute
 * predefined queries and parameterize the queries with an additional layer
 * of URL parameterization.
 */
public class SparqlQueryProcessor extends SPARQL_QueryGeneral.SPARQL_QueryProc {
     
    /**
     * execute GET-style
     * @param action typically a GET request
     */
    @Override
    protected void executeWithParameter(HttpAction action) {
        String queryString = ((AgentHttpAction) action).getSkill();
        if(queryString==null) {
            super.executeWithParameter(action);
        } else {
            execute(queryString, action);
        }
    }

    /**
     * execute POST-style
     * @param action typically a POST request
     */
    @Override
    protected void executeBody(HttpAction action) {
        String queryString = ((AgentHttpAction) action).getSkill();
        if(queryString==null) {
            super.executeBody(action);
        } else {
            execute(queryString, action);
        }
    }

    public static String URL_PARAM_REGEX = "(?<key>[^=&]+)=(?<value>[^&]+)"; 
    public static Pattern URL_PARAM_PATTERN=Pattern.compile(URL_PARAM_REGEX);
    
    /**
     * general (URL-parameterized) query execution
     * @param queryString the resolved query
     * @param action the http action containing the parameters
     * TODO error handling
     */
    @Override
    protected void execute(String queryString, HttpAction action) {
        String params="";
        try {
            String uriParams=action.getRequest().getQueryString();
            if(uriParams!=null) {
                params = URLDecoder.decode(uriParams,StandardCharsets.UTF_8.toString());
            }
        } catch (UnsupportedEncodingException e) {
            action.getResponse().setStatus(HttpStatus.SC_BAD_REQUEST);
            return;
        }
        Matcher paramMatcher=URL_PARAM_PATTERN.matcher(params);
        Stack<TupleSet> ts=new Stack<>();
        ts.push(new TupleSet());
        while(paramMatcher.find()) {
            String key=paramMatcher.group("key");
            String value=paramMatcher.group("value");
            while(key.startsWith("(")) {
                key=key.substring(1);
                ts.push(new TupleSet());
            }
            if(key.length()<=0) {
                action.getResponse().setStatus(HttpStatus.SC_BAD_REQUEST);
                return;    
            }
            String realValue=value.replace(")","");
            if(value.length()<=0) {
                action.getResponse().setStatus(HttpStatus.SC_BAD_REQUEST);
                return;    
            }
            try {
                if(!"asset".equals(key) && !"query".equals(key)) {
                    ts.peek().add(key,realValue);
                }
            } catch(Exception e) {
                action.getResponse().setStatus(HttpStatus.SC_BAD_REQUEST);
                return;    
            }
            while(value.endsWith(")")) {
                TupleSet set1=ts.pop();
                ts.peek().merge(set1);
                value=value.substring(0,value.length()-1);
            }
        }
        
        Pattern tuplePattern = Pattern.compile("\\([^\\(\\)]*\\)");
        Pattern variablePattern = Pattern.compile("@(?<name>[a-zA-Z0-9]+)");
        Matcher tupleMatcher=tuplePattern.matcher(queryString);
        StringBuffer replaceQuery=new StringBuffer();
        int lastStart=0;
        while(tupleMatcher.find()) {
            replaceQuery.append(queryString.substring(lastStart,tupleMatcher.start()-1));
            String otuple=tupleMatcher.group(0);
            Matcher variableMatcher=variablePattern.matcher(otuple);
            List<String> variables=new java.util.ArrayList<>();
            while(variableMatcher.find()) {
                variables.add(variableMatcher.group("name"));
            }
            if(variables.size()>0) {
                try {
                    boolean isFirst=true;
                    Collection<Tuple> tuples = ts.peek().getTuples(variables.toArray(new String[0]));
                    for(Tuple rtuple : tuples) {
                        if(isFirst) {
                            isFirst=false;
                        } else {
                            replaceQuery.append(" ");
                        }
                        String newTuple=otuple;
                        for(String key : rtuple.getVariables()) {
                            newTuple=newTuple.replace("@"+key,rtuple.get(key));
                        }
                        replaceQuery.append(newTuple);
                    }
               } catch (Exception e) {
                    System.err.println(e.getMessage());
                    action.getResponse().setStatus(HttpStatus.SC_BAD_REQUEST);
                    return;
                }
            } else {
                replaceQuery.append(otuple);
            }   
            lastStart=tupleMatcher.end();
        }
        replaceQuery.append(queryString.substring(lastStart));

        queryString=replaceQuery.toString();
        Matcher variableMatcher=variablePattern.matcher(queryString);
        List<String> variables=new java.util.ArrayList<>();
        while(variableMatcher.find()) {
            variables.add(variableMatcher.group("name"));
        }
        try {
            Collection<Tuple> tuples=ts.peek().getTuples(variables.toArray(new String[0]));
            if(tuples.size()<=0 && variables.size()>0) {
                System.err.println(String.format("Warning: Got variables %s on top-level but no bindings.",Arrays.toString(variables.toArray())));
                action.getResponse().setStatus(HttpStatus.SC_BAD_REQUEST);
                return;        
            } else if(tuples.size()>0) {
                System.err.println(String.format("Warning: Got %s tuples for top-level bindings of variables %s. Using only the first one.",tuples.size(),Arrays.toString(variables.toArray())));
            }
            if(tuples.size()>0) {
                Tuple rtuple=tuples.iterator().next();
                for(String key : rtuple.getVariables()) {
                    queryString=queryString.replace("@"+key,rtuple.get(key));
                }
            }
        } catch (Exception e) {
            System.err.println(e);
            action.getResponse().setStatus(HttpStatus.SC_BAD_REQUEST);
            return;
        } 
        super.execute(queryString,action);
    }
}

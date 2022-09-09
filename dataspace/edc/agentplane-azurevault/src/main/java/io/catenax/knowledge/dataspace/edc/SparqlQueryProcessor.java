//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import jakarta.ws.rs.BadRequestException;
import jakarta.ws.rs.InternalServerErrorException;
import org.apache.http.HttpStatus;
import org.apache.jena.fuseki.servlets.HttpAction;
import org.apache.jena.fuseki.servlets.SPARQL_QueryGeneral;

import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.Stack;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.jena.sparql.core.DatasetDescription;
import org.apache.jena.query.Query;
import org.apache.jena.sparql.core.DatasetGraph;
import org.apache.jena.sparql.core.DatasetGraphZero;
import org.apache.jena.atlas.lib.Pair;
import org.apache.jena.query.Dataset;
import org.apache.jena.query.DatasetFactory;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;

import org.apache.jena.fuseki.servlets.ActionErrorException;
import org.apache.jena.fuseki.servlets.ServletOps;
import org.apache.jena.riot.RiotException;
import org.apache.jena.fuseki.system.GraphLoadUtils;
import org.apache.jena.atlas.lib.InternalErrorException;

/**
 * dedicated SparQL query processor which is skill-enabled: Execute
 * predefined queries and parameterize the queries with an additional layer
 * of URL parameterization.
 */
public class SparqlQueryProcessor extends SPARQL_QueryGeneral.SPARQL_QueryProc {
     
    /**
     * execute GET-style with possibility of asset=local skill
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
     * execute POST-style with possiblity of asset=local skill
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
        
        Pattern tuplePattern = Pattern.compile("\\([^()]*\\)");
        Pattern variablePattern = Pattern.compile("@(?<name>[a-zA-Z0-9]+)");
        Matcher tupleMatcher=tuplePattern.matcher(queryString);
        StringBuilder replaceQuery=new StringBuilder();
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
                throw new BadRequestException(String.format("Warning: Got variables %s on top-level but no bindings.",Arrays.toString(variables.toArray())));
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
            throw new BadRequestException(e);
        } 
        super.execute(queryString,action);
    }

    /**
     * deal with predefined assets=local graphs
     */
    @Override
    protected Pair<DatasetGraph, Query> decideDataset(HttpAction action, Query query, String queryStringLog) {
        List<String> graphURLs = List.of();
        String graphs=((AgentHttpAction) action).getGraphs();
        List<String> namedGraphs = graphs!=null ? List.of(graphs) : List.of();
 
        DatasetDescription desc=null;
        if ( graphURLs.size() != 0 && namedGraphs.size() != 0 )
            desc=DatasetDescription.create(graphURLs, namedGraphs);
        else 
            desc=DatasetDescription.create(query);

         if ( desc == null ) {
            //ServletOps.errorBadRequest("No dataset description in protocol request or in the query string");
            return Pair.create(DatasetGraphZero.create(), query);
        }

        // These will have been taken care of by the "getDatasetDescription"
        if ( query.hasDatasetDescription() ) {
            // Don't modify input.
            query = query.cloneQuery();
            query.getNamedGraphURIs().clear();
            query.getGraphURIs().clear();
        }
        return Pair.create(datasetFromDescriptionWeb(action, desc), query);
     }


    final static int MAX_TRIPLES = 100 * 1000;

     /**
     * Construct a Dataset based on a dataset description.
     * Loads graph from the web.
     */
    protected DatasetGraph datasetFromDescriptionWeb(HttpAction action, DatasetDescription datasetDesc) {
        try {
            if ( datasetDesc == null )
                return null;
            if ( datasetDesc.isEmpty() )
                return null;

            List<String> graphURLs = datasetDesc.getDefaultGraphURIs();
            List<String> namedGraphs = datasetDesc.getNamedGraphURIs();

            if ( graphURLs.size() == 0 && namedGraphs.size() == 0 )
                return null;

            Dataset dataset = DatasetFactory.create();
            // Look in cache for loaded graphs!!

            // ---- Default graph
            {
                Model model = ModelFactory.createDefaultModel();
                for ( String uri : graphURLs ) {
                    if ( uri == null || uri.equals("") )
                        throw new InternalErrorException("Default graph URI is null or the empty string");

                    try {
                        GraphLoadUtils.loadModel(model, uri, MAX_TRIPLES);
                        action.log.info(String.format("[%d] Load (default graph) %s", action.id, uri));
                    }
                    catch (RiotException ex) {
                        action.log.info(String.format("[%d] Parsing error loading %s: %s", action.id, uri, ex.getMessage()));
                        ServletOps.errorBadRequest("Failed to load URL (parse error) " + uri + " : " + ex.getMessage());
                    }
                    catch (Exception ex) {
                        action.log.info(String.format("[%d] Failed to load (default) %s: %s", action.id, uri, ex.getMessage()));
                        ServletOps.errorBadRequest("Failed to load URL " + uri);
                    }
                }
                dataset.setDefaultModel(model);
            }
            // ---- Named graphs
            if ( namedGraphs != null ) {
                for ( String uri : namedGraphs ) {
                    if ( uri == null || uri.equals("") )
                        throw new InternalErrorException("Named graph URI is null or the empty string");

                    try {
                        Model model = ModelFactory.createDefaultModel();
                        GraphLoadUtils.loadModel(model, uri, MAX_TRIPLES);
                        action.log.info(String.format("[%d] Load (named graph) %s", action.id, uri));
                        dataset.addNamedModel(uri, model);
                    }
                    catch (RiotException ex) {
                        action.log.info(String.format("[%d] Parsing error loading %s: %s", action.id, uri, ex.getMessage()));
                        ServletOps.errorBadRequest("Failed to load URL (parse error) " + uri + " : " + ex.getMessage());
                    }
                    catch (Exception ex) {
                        action.log.info(String.format("[%d] Failed to load (named graph) %s: %s", action.id, uri, ex.getMessage()));
                        ServletOps.errorBadRequest("Failed to load URL " + uri);
                    }
                }
            }

            return dataset.asDatasetGraph();

        }
        catch (ActionErrorException ex) {
            throw ex;
        }
        catch (Exception ex) {
            action.log.info(String.format("[%d] SPARQL parameter error: " + ex.getMessage(), action.id, ex));
            ServletOps.errorBadRequest("Parameter error: " + ex.getMessage());
            return null;
        }
    }
}

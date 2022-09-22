//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.sparql;

import io.catenax.knowledge.dataspace.edc.*;
import io.catenax.knowledge.dataspace.edc.http.HttpServletContextAdapter;
import io.catenax.knowledge.dataspace.edc.http.HttpServletRequestAdapter;
import io.catenax.knowledge.dataspace.edc.http.HttpServletResponseAdapter;
import io.catenax.knowledge.dataspace.edc.http.IJakartaAdapter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.ws.rs.BadRequestException;
import okhttp3.Request;
import okhttp3.Response;
import org.apache.http.HttpStatus;
import org.apache.jena.fuseki.Fuseki;
import org.apache.jena.fuseki.metrics.MetricsProviderRegistry;
import org.apache.jena.fuseki.server.DataAccessPoint;
import org.apache.jena.fuseki.server.DataAccessPointRegistry;
import org.apache.jena.fuseki.server.DataService;
import org.apache.jena.fuseki.server.OperationRegistry;
import org.apache.jena.fuseki.servlets.HttpAction;
import org.apache.jena.fuseki.servlets.SPARQL_QueryGeneral;

import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import java.net.URLDecoder;
import java.util.Stack;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.jena.graph.NodeFactory;
import org.apache.jena.query.TxnType;
import org.apache.jena.riot.Lang;
import org.apache.jena.riot.RDFParser;
import org.apache.jena.riot.lang.StreamRDFCounting;
import org.apache.jena.riot.system.ErrorHandler;
import org.apache.jena.riot.system.ErrorHandlerFactory;
import org.apache.jena.riot.system.StreamRDF;
import org.apache.jena.riot.system.StreamRDFLib;
import org.apache.jena.query.Query;
import org.apache.jena.sparql.core.DatasetGraph;
import org.apache.jena.sparql.core.DatasetGraphFactory;
import org.apache.jena.atlas.lib.Pair;
import org.apache.jena.sparql.service.ServiceExecutorRegistry;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;

import static java.nio.charset.StandardCharsets.UTF_8;

/**
 * dedicated SparQL query processor which is skill-enabled and open for edc-based services:
 * Execute predefined queries and parameterize the queries with an additional layer
 * of URL parameterization.
 */
public class SparqlQueryProcessor extends SPARQL_QueryGeneral.SPARQL_QueryProc {

    /**
     * other services
     */
    protected final Monitor monitor;
    protected final ServiceExecutorRegistry registry;
    protected final AgentConfig config;


    /**
     * state
     */
    protected final OperationRegistry operationRegistry= OperationRegistry.createEmpty();
    protected final DataAccessPointRegistry dataAccessPointRegistry=new DataAccessPointRegistry(MetricsProviderRegistry.get().getMeterRegistry());
    // we need a single data access point (with its default graph)
    protected final DatasetGraph dataset;
    protected final DataAccessPoint api;
    // map EDC monitor to SLF4J (better than the builtin MonitorProvider)
    private final MonitorWrapper monitorWrapper;
    // some state to set when interacting with Fuseki
    private long count=-1;

    /**
     * create a new sparql processor
     * @param registry service execution registry
     * @param monitor EDC logging
     */
    public SparqlQueryProcessor(ServiceExecutorRegistry registry, Monitor monitor, AgentConfig config) {
        this.monitor=monitor;
        this.registry=registry;
        this.config=config;
        this.monitorWrapper=new MonitorWrapper(getClass().getName(),monitor);
        dataset = DatasetGraphFactory.createTxnMem();
        DataService.Builder dataService = DataService.newBuilder(dataset);
        DataService service=dataService.build();
        api=new DataAccessPoint(config.getAccessPoint(), service);
        dataAccessPointRegistry.register(api);
        monitor.debug(String.format("Activating data service %s under access point %s",service,api));
        service.goActive();
        // read file with ontology, share this dataset with the catalogue sync procedure
        if(config.getAssetFile()!=null) {
            dataset.begin(TxnType.WRITE);
            StreamRDF dest = StreamRDFLib.dataset(dataset);
            StreamRDF graphDest = StreamRDFLib.extendTriplesToQuads(NodeFactory.createURI(config.getDefaultAsset()),dest);
            StreamRDFCounting countingDest = StreamRDFLib.count(graphDest);
            ErrorHandler errorHandler = ErrorHandlerFactory.errorHandlerStd(monitorWrapper);
            RDFParser.create()
                    .errorHandler(errorHandler)
                    .source(config.getAssetFile())
                    .lang(Lang.TTL)
                    .parse(countingDest);
            dataset.commit();
            monitor.info(String.format("Initialised asset %s with %d triples from file %s",config.getDefaultAsset(),countingDest.countTriples(),config.getAssetFile()));
        }
    }

    /**
     * @return the operation registry
     */
    public OperationRegistry getOperationRegistry() {
        return operationRegistry;
    }

    /**
     * @return the data access point registry
     */
    public DataAccessPointRegistry getDataAccessPointRegistry() {
        return dataAccessPointRegistry;
    }

    /**
     * wraps a response to a previous servlet API
     * @param jakartaResponse new servlet object
     * @return wrapped/adapted response
     */
    public javax.servlet.http.HttpServletResponse getJavaxResponse(HttpServletResponse jakartaResponse) {
        return IJakartaAdapter.javaxify(jakartaResponse,javax.servlet.http.HttpServletResponse.class,monitor);
    }

    /**
     * wraps a request to a previous servlet API
     * @param jakartaRequest new servlet object
     * @return wrapped/adapted request
     */
    public javax.servlet.http.HttpServletRequest getJavaxRequest(HttpServletRequest jakartaRequest) {
        return IJakartaAdapter.javaxify(jakartaRequest,javax.servlet.http.HttpServletRequest.class,monitor);
    }

    /**
     * execute sparql based on the given request and response
     * @param request jakarta request
     * @param response jakarta response
     * @param skill skill ref
     * @param graph graph ref
     */
    public void execute(HttpServletRequest request, HttpServletResponse response, String skill, String graph) {
        request.getServletContext().setAttribute(Fuseki.attrVerbose, config.isSparqlVerbose());
        request.getServletContext().setAttribute(Fuseki.attrOperationRegistry, operationRegistry);
        request.getServletContext().setAttribute(Fuseki.attrNameRegistry, dataAccessPointRegistry);
        AgentHttpAction action = new AgentHttpAction(++count, monitorWrapper, getJavaxRequest(request), getJavaxResponse(response), skill, graph);
        // Should we check whether this already has been done? the context should be quite static
        action.setRequest(api, api.getDataService());
        ServiceExecutorRegistry.set(action.getContext(),registry);
        execute(action);
    }

    /**
     * execute sparql based on the given internal okhttp request and response
     * @param request ok request
     * @param skill skill ref
     * @param graph graph ref
     * @return simulated ok response
     */
    public Response execute(Request request, String skill, String graph) {
        HttpServletContextAdapter contextAdapter=new HttpServletContextAdapter(request);
        HttpServletRequestAdapter requestAdapter=new HttpServletRequestAdapter(request,contextAdapter);
        HttpServletResponseAdapter responseAdapter=new HttpServletResponseAdapter(request);
        contextAdapter.setAttribute(Fuseki.attrVerbose, config.isSparqlVerbose());
        contextAdapter.setAttribute(Fuseki.attrOperationRegistry, operationRegistry);
        contextAdapter.setAttribute(Fuseki.attrNameRegistry, dataAccessPointRegistry);
        AgentHttpAction action = new AgentHttpAction(++count, monitorWrapper, requestAdapter,responseAdapter, skill, graph);
        // Should we check whether this already has been done? the context should be quite static
        action.setRequest(api, api.getDataService());
        ServiceExecutorRegistry.set(action.getContext(),registry);
        action.getContext().set(DataspaceServiceExecutor.targetUrl,request);
        if(skill!=null) {
            action.getContext().set(DataspaceServiceExecutor.asset,skill);
        } else if(graph!=null) {
            action.getContext().set(DataspaceServiceExecutor.asset,graph);
        }
        execute(action);
        return responseAdapter.toResponse();
    }

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

    /**
     * regexes to deal with url parameters
     */
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
        String uriParams=action.getRequest().getQueryString();
        if(uriParams!=null) {
            params = URLDecoder.decode(uriParams, UTF_8);
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
                throw new BadRequestException(String.format("Error: Got variables %s on top-level but no bindings.",Arrays.toString(variables.toArray())));
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
            throw new BadRequestException(String.format("Error: Could not bind variables"),e);
        }
        if(action.getContext().isDefined(DataspaceServiceExecutor.asset)) {
            Request request=action.getContext().get(DataspaceServiceExecutor.targetUrl);
            String asset=action.getContext().get(DataspaceServiceExecutor.asset);
            String graphPattern=String.format("GRAPH\\s*<%s>",asset);
            Matcher graphMatcher=Pattern.compile(graphPattern).matcher(queryString);
            replaceQuery=new StringBuilder();
            lastStart=0;
            while(graphMatcher.find()) {
                replaceQuery.append(queryString.substring(lastStart,graphMatcher.start()-1));
                replaceQuery.append(String.format("SERVICE <%s>",request.url().uri().toString()));
                lastStart=graphMatcher.end();
            }
            replaceQuery.append(queryString.substring(lastStart));
            queryString=replaceQuery.toString();
        }
        super.execute(queryString,action);
    }

    /**
     * deal with predefined assets=local graphs
     */
    @Override
    protected Pair<DatasetGraph, Query> decideDataset(HttpAction action, Query query, String queryStringLog) {
        // These will have been taken care of by the "getDatasetDescription"
        if ( query.hasDatasetDescription() ) {
            // Don't modify input.
            query = query.cloneQuery();
            query.getNamedGraphURIs().clear();
            query.getGraphURIs().clear();
        }
        return Pair.create(dataset, query);
     }
}

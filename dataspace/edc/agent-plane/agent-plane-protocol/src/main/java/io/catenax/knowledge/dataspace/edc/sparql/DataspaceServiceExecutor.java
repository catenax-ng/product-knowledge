//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.sparql;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.catenax.knowledge.dataspace.edc.AgentConfig;
import io.catenax.knowledge.dataspace.edc.IAgreementController;
import io.catenax.knowledge.dataspace.edc.http.HttpClientAdapter;
import jakarta.ws.rs.WebApplicationException;
import okhttp3.OkHttpClient;
import org.apache.jena.atlas.logging.Log;
import org.apache.jena.graph.Node;
import org.apache.jena.graph.NodeFactory;
import org.apache.jena.query.Query;
import org.apache.jena.query.QueryExecException;
import org.apache.jena.sparql.algebra.Op;
import org.apache.jena.sparql.algebra.OpAsQuery;
import org.apache.jena.sparql.algebra.Transformer;
import org.apache.jena.sparql.algebra.op.*;
import org.apache.jena.sparql.algebra.table.TableData;
import org.apache.jena.sparql.core.Var;
import org.apache.jena.sparql.engine.ExecutionContext;
import org.apache.jena.sparql.engine.QueryIterator;
import org.apache.jena.sparql.engine.binding.Binding;
import org.apache.jena.sparql.engine.binding.BindingBuilder;
import org.apache.jena.sparql.engine.http.HttpParams;
import org.apache.jena.sparql.engine.iterator.QueryIter;
import org.apache.jena.sparql.engine.iterator.QueryIter1;
import org.apache.jena.sparql.engine.iterator.QueryIterPlainWrapper;
import org.apache.jena.sparql.exec.RowSet;
import org.apache.jena.sparql.exec.http.*;
import org.apache.jena.sparql.graph.NodeTransformLib;
import org.apache.jena.sparql.service.bulk.ChainingServiceExecutorBulk;
import org.apache.jena.sparql.service.bulk.ServiceExecutorBulk;
import org.apache.jena.sparql.service.single.ServiceExecutor;
import org.apache.jena.sparql.util.Context;
import org.apache.jena.sparql.util.Symbol;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.types.TypeManager;
import org.eclipse.dataspaceconnector.spi.types.domain.edr.EndpointDataReference;

import java.net.http.HttpClient;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * A service executor (single and bulk mode) which replaces outgoing http calls
 * by appropriate dataspace agreements/calls.
 * Register in the ServiceExecutorRegistry via
 * - add(...) for single execution
 * - addBulkLink(...) for multiple execution
 */
public class DataspaceServiceExecutor implements ServiceExecutor, ChainingServiceExecutorBulk {

    /**
     * EDC services
     */
    final Monitor monitor;
    final IAgreementController agreementController;
    final AgentConfig config;
    final HttpClient client;
    final ExecutorService executor;
    final ObjectMapper objectMapper;
    final AgentConfig agentConfig;

    /**
     * some constants
     */
    public final static Symbol authKey = Symbol.create("cx:authKey");
    public final static Symbol authCode = Symbol.create("cx:authCode");
    public final static Pattern EDC_TARGET_ADDRESS = Pattern.compile("(?<protocol>edc|edcs)://(?<connector>[^#?]*)(#(?<asset>[^/?]*))?(\\?(?<params>.*))?");
    public final static Symbol targetUrl = Symbol.create("cx:targetUrl");
    public final static Symbol asset = Symbol.create("cx:asset");

    /**
     * create a new executor
     *
     * @param monitor    logging subsystem
     * @param controller dataspace agreement
     */
    public DataspaceServiceExecutor(Monitor monitor, IAgreementController controller, AgentConfig config, OkHttpClient client, ExecutorService executor, TypeManager typeManager, AgentConfig agentConfig) {
        this.monitor = monitor;
        this.agreementController = controller;
        this.config = config;
        this.client=new HttpClientAdapter(client);
        this.executor=executor;
        this.objectMapper=typeManager.getMapper();
        this.agentConfig=agentConfig;
    }

    /**
     * derive unique asset name from embedded graph operators
     * @param operator embedding operator
     * @return unique graph asset found, null if there is none
     */
    protected String getUniqueGraph(Op operator, List<Binding> bindings) {
        if(operator instanceof OpGraph) {
            Node graphNode = ((OpGraph) operator).getNode();
            if(graphNode.isVariable()) {
                Var var = (Var) graphNode;
                Node resolveNode=null;
                for(Binding binding : bindings) {
                    Node resolveNode2=binding.get(var);
                    if(resolveNode!=null && !resolveNode.equals(resolveNode2)) {
                        throw new QueryExecException(String.format("got two different graph bindings for %s. Found %s and %s.", var, resolveNode,resolveNode2));
                    } else {
                        resolveNode = resolveNode2;
                    }
                }
                graphNode=resolveNode;
            }
            if(graphNode==null || !graphNode.isURI()) {
                throw new QueryExecException(String.format("Could not derive asset name from graph operator %s which is not bound to an uri.",operator));
            } else {
                return graphNode.getURI();
            }
        } else if(operator instanceof Op2) {
            String asset=getUniqueGraph(((Op2) operator).getLeft(),bindings);
            String asset2=getUniqueGraph(((Op2) operator).getRight(),bindings);
            if(asset!=null) {
                if(asset2!=null) {
                    if(!(asset.equals(asset2))) {
                        throw new QueryExecException(String.format("Only a single graph asset is allowed in EDC-Protocol Services. Found %s and %s.", asset, asset2));
                    }
                }
                return asset;
            }
            return asset2;
        } else if(operator instanceof Op1) {
            // currently, we need to stop looking for graphes
            // in remote services
            if(!(operator instanceof OpService))
                return getUniqueGraph(((Op1) operator).getSubOp(),bindings);
        }
        return null;
    }

    /**
     * bulk execution call
     * @param opService bound operator
     * @param queryIterator incoming bindings (may set service uri and input params)
     * @param executionContext context
     * @param serviceExecutorBulk bulk executor
     * @return binding generating iterator
     * TODO implement batch size per service and not globally
     */
    @Override
    public QueryIterator createExecution(OpService opService, QueryIterator queryIterator, ExecutionContext executionContext, ServiceExecutorBulk serviceExecutorBulk) {
        Node serviceNode=opService.getService();
        Set<String> boundVars=new HashSet<>();
        long batchSize=config.getFederationServiceBatchSize();
        // return an iterator over batches
        return new QueryIter1(queryIterator,executionContext) {

            // the iterator over the current batch
            private QueryIterator batchIterator;

            @Override
            protected boolean hasNextBinding() {
                return (batchIterator!=null && batchIterator.hasNext()) || hasNextResultBinding();
            }

            public boolean hasNextResultBinding() {
                // do we have additional input bindings
                if(this.getInput().hasNext()) {
                    // yes then read the next batch
                    Map<String,List<Binding>> bindings=new HashMap<>();
                    long batchLength=0;
                    while(this.getInput().hasNext() && batchLength++<batchSize) {
                        Binding binding = this.getInput().next();
                        Iterator<Var> vars=binding.vars();
                        while(vars.hasNext()) {
                            boundVars.add(vars.next().getVarName());
                        }
                        // detect the service uri under the current binding
                        Node keyNode = serviceNode;
                        if (keyNode.isVariable())
                            keyNode = binding.get((Var) keyNode);
                        if (keyNode.isURI()) {
                            String key = keyNode.getURI();
                            if (!bindings.containsKey(key)) {
                                bindings.put(key, new ArrayList<>());
                            }
                            bindings.get(key).add(binding);
                        } else {
                            monitor.warning(String.format("Omitting a call because of lacking service binding"));
                        }
                    }
                    ExecutionContext ctx=this.getExecContext();

                    List<Future<QueryIterator>> futureBindings=bindings.entrySet().stream().map(serviceSpec -> executor.submit(() ->
                            createExecution(opService, serviceSpec.getKey(), boundVars, serviceSpec.getValue(), ctx))).collect(Collectors.toList());

                    batchIterator=new QueryIterFutures(config,monitor,config.getControlPlaneManagementUrl(),config.getDefaultAsset(),serviceNode.getURI(), serviceNode.getURI(), ctx.getContext(),futureBindings);
                    return hasNextBinding();
                } else {
                    return false;
                }
            }

            @Override
            protected Binding moveToNextBinding() {
                return batchIterator.next();
            }

            @Override
            protected void requestSubCancel() {

            }

            @Override
            protected void closeSubIterator() {

            }

        };
    }

    /**
     * single execution mode
     * @param opExecute  the bound operator (if variable is used in service description)
     * @param opOriginal the unbound operator
     * @param binding    the current binding
     * @param execCxt    the execution context
     * @return a set of query results
     */
    @Override
    public QueryIterator createExecution(OpService opExecute, OpService opOriginal, Binding binding, ExecutionContext execCxt) {
        // it maybe that a subselect has "masked" some input variables
        Node serviceNode=opExecute.getService();
        if(serviceNode.isVariable()) {
            serviceNode=binding.get((Var) serviceNode);
        }
        if (!serviceNode.isURI())
            throw new QueryExecException("Service URI not bound: " + opExecute.getService());
        // check whether we need to route over EDC
        String target = serviceNode.getURI();
        Set<String> allowedVars=new HashSet<>();
        Iterator<Var> allAllowedVars = binding.vars();
        while(allAllowedVars.hasNext()) {
            allowedVars.add(allAllowedVars.next().getVarName());
        }
        return createExecution(opOriginal,target,allowedVars,List.of(binding),execCxt);
    }

    /**
     * (re-) implements the http service execution
     * @param opOriginal the unbound operator
     * @param serviceURL uri of the target service
     * @param boundVars a set of all bound variables
     * @param bindings   the current bindings
     * @param execCxt    the execution context
     * @return a set of query results
     */
     public QueryIterator createExecution(OpService opOriginal, String serviceURL, Set<String> boundVars, List<Binding> bindings, ExecutionContext execCxt) {
        Context context = execCxt.getContext();
        boolean silent = opOriginal.getSilent();

        Matcher edcMatcher = EDC_TARGET_ADDRESS.matcher(serviceURL);
        if (edcMatcher.matches()) {
            monitor.info(String.format("About to execute edc target %s via dataspace", serviceURL));
            String remoteUrl = edcMatcher.group("connector");
            if (remoteUrl == null || remoteUrl.length() == 0) {
                remoteUrl = config.getControlPlaneIdsUrl();
            } else {
                if ("edcs".equals(edcMatcher.group("protocol"))) {
                    remoteUrl = "https://" + remoteUrl;
                } else {
                    remoteUrl = "http://" + remoteUrl;
                }
            }
            String asset = edcMatcher.group("asset");
            if (asset == null || asset.length() == 0) {
                GraphRewrite gr=new GraphRewrite(monitor,bindings);
                opOriginal= (OpService) Transformer.transform(gr,opOriginal);
                if(gr.getGraphNames().isEmpty()) {
                    throw new QueryExecException("There is no graph asset under EDC-based service: " + serviceURL);
                }
                if(gr.getGraphNames().size()>1) {
                    throw new QueryExecException("There are several graph assets (currently not supported due to negotiation strategy, please rewrite your query) under EDC-based service: " + serviceURL);
                }
                asset=gr.getGraphNames().stream().findFirst().get();
            }
            EndpointDataReference endpoint = agreementController.get(asset);
            if (endpoint == null) {
                try {
                    endpoint = agreementController.createAgreement(remoteUrl, asset);
                } catch (WebApplicationException e) {
                    if (silent) {
                        monitor.warning(String.format("Could not get an agreement from connector %s to asset %s", remoteUrl, asset), e.getCause());
                        return QueryIterPlainWrapper.create(bindings.iterator(), execCxt);
                    }
                    throw e;
                }
            }
            // put the endpoint information into a new service operator
            // and cater for the EDC public api slash problem
            serviceURL = endpoint.getEndpoint();
            if(!serviceURL.endsWith("/")) {
                serviceURL=serviceURL+"/";
            }
            if (edcMatcher.group("params") != null) {
                serviceURL = serviceURL + "?" + edcMatcher.group("params");
            }
            Map<String, Map<String, List<String>>> allServiceParams = context.get(Service.serviceParams);
            if (allServiceParams == null) {
                allServiceParams = new HashMap<>();
                context.put(Service.serviceParams, allServiceParams);
            }
            Map<String, List<String>> serviceParams = allServiceParams.computeIfAbsent(serviceURL, k -> new HashMap<>());
            serviceParams.put("cx_accept",List.of("application/json"));
            execCxt.getContext().put(authKey, endpoint.getAuthKey());
            execCxt.getContext().put(authCode, endpoint.getAuthCode());
        } else {
            monitor.info(String.format("About to execute http target %s without dataspace", serviceURL));
        }

        // http execute with headers and such
        try {
            // [QExec] Add getSubOpUnmodified();
            Op opRemote = opOriginal.getSubOp();
            int hashCode=Math.abs(opRemote.hashCode());
            String bindingVarName="binding"+hashCode;
            Var idVar= Var.alloc(bindingVarName);
            VariableDetector vd = new VariableDetector(boundVars);
            opRemote=NodeTransformLib.transform(vd,opRemote);
            List<Var> neededVars=vd.getVariables();
            Map<String,Binding> resultingBindings=new HashMap<>();
            Map<Node,List<Binding>> newBindings=new HashMap<>();
            for(Binding originalBinding : bindings) {
                StringBuilder keyBuilder = new StringBuilder();
                BindingBuilder bb=BindingBuilder.create();
                for(Var neededVar : neededVars) {
                    Node node=originalBinding.get(neededVar);
                    keyBuilder.append(neededVar.getVarName());
                    keyBuilder.append("#");
                    keyBuilder.append(node.toString());
                    bb.add(neededVar,node);
                }
                String key=keyBuilder.toString();
                Node keyNode;
                if(resultingBindings.containsKey(key)) {
                    Binding existingBinding=resultingBindings.get(key);
                    keyNode=existingBinding.get(idVar);
                } else {
                    keyNode=NodeFactory.createLiteral(String.valueOf(resultingBindings.size()));
                    bb.add(idVar,keyNode);
                    newBindings.put(keyNode,new ArrayList<>());
                    Binding newBinding=bb.build();
                    bb=BindingBuilder.create(newBinding);
                    resultingBindings.put(key,newBinding);
                }
                final BindingBuilder bb2=BindingBuilder.create(originalBinding);
                bb2.set(idVar,keyNode);
                newBindings.get(keyNode).add(bb2.build());
            }
            neededVars.add(idVar);
            TableData table = new TableData(neededVars,new ArrayList<>(resultingBindings.values()));
            OpTable opTable = OpTable.create(table);
            Op join = OpSequence.create(opTable,opRemote);
            Query query = OpAsQuery.asQuery(join);
            //query.addProjectVars(List.of(idVar));

            monitor.debug(String.format("Prepared target %s for query %s",serviceURL,query));

            // -- Setup
            //boolean withCompression = context.isTrueOrUndef(httpQueryCompression);
            long timeoutMillis = config.getReadTimeout();

            // RegistryServiceModifier is applied by QueryExecHTTP
            Params serviceParams = getServiceParamsFromContext(serviceURL, context);
            HttpClient httpClient = chooseHttpClient(serviceURL, context);

            QuerySendMode querySendMode = chooseQuerySendMode(serviceURL, context, QuerySendMode.asGetWithLimitBody);
            // -- End setup

            // Build the execution
            QueryExecBuilder qExecBuilder = QueryExec.newBuilder()
                    .endpoint(serviceURL)
                    .timeout(timeoutMillis, TimeUnit.MILLISECONDS)
                    .query(query)
                    .params(serviceParams)
                    .context(context)
                    .httpClient(httpClient)
                    .objectMapper(objectMapper)
                    .agentConfig(agentConfig)
                    .sendMode(querySendMode);

            if (context.isDefined(authKey)) {
                String authKeyProp=context.get(authKey);
                monitor.debug(String.format("About to use authentication header %s on http target %s", authKeyProp,serviceURL));
                String authCodeProp=context.get(authCode);
                qExecBuilder=qExecBuilder.httpHeader(authKeyProp,authCodeProp);
            }

            try(QueryExec qExec = qExecBuilder.build()) {
                // Detach from the network stream.
                RowSet rowSet = qExec.select().materialize();
                QueryIterator qIter = QueryIterPlainWrapper.create(rowSet);
                qIter = QueryIter.makeTracked(qIter, execCxt);
                return new QueryIterJoin(qIter, newBindings, idVar, execCxt);
            }
        } catch (RuntimeException ex) {
            if (silent) {
                Log.warn(this, "SERVICE " + serviceURL + " : " + ex.getMessage());
                // Return the input
                return QueryIterPlainWrapper.create(bindings.iterator(), execCxt);
            }
            throw ex;
        }
    }

    /**
     * choose an appropriate client
     *
     * @param serviceURL target url
     * @param context    query context
     * @return http client
     */
    protected HttpClient chooseHttpClient(String serviceURL, Context context) {
        if(context==null) {
            monitor.warning(String.format("Context is null when obtaining http client for %s",serviceURL));
        }
        return client;
    }

    /**
     * choose an appropriate send mode
     *
     * @param serviceURL target url
     * @param context    query content
     * @param dftValue   default send mode of dft
     * @return decided send mode
     */
    protected QuerySendMode chooseQuerySendMode(String serviceURL, Context context, QuerySendMode dftValue) {
        if(dftValue!=QuerySendMode.asPost) {
            monitor.warning(String.format("Default send mode %s for %s is not post",dftValue,serviceURL));
        }
        if(context==null) {
            monitor.warning(String.format("Context is null when obtaining send mode for %s",serviceURL));
        }
        return QuerySendMode.asPost;
    }

    /**
     * extract http params from query
     *
     * @param serviceURI target url
     * @param context    query context
     * @return query params
     * @throws QueryExecException in case there is something wrong
     */
    protected Params getServiceParamsFromContext(String serviceURI, Context context) throws QueryExecException {
        Params params = Params.create();

        Object obj = context.get(Service.serviceParams);

        if (obj == null)
            return params;

        // Old style.
        try {
            @SuppressWarnings("unchecked")
            Map<String, Map<String, List<String>>> serviceParams = (Map<String, Map<String, List<String>>>) obj;
            Map<String, List<String>> paramsMap = serviceParams.get(serviceURI);
            if (paramsMap != null) {
                for (String param : paramsMap.keySet()) {
                    if (HttpParams.pQuery.equals(param))
                        throw new QueryExecException("ARQ serviceParams overrides the 'query' SPARQL protocol parameter");
                    List<String> values = paramsMap.get(param);
                    for (String value : values)
                        params.add(param, value);
                }
            }
            return params;
        } catch (Throwable ex) {
            monitor.warning("Failed to process " + obj + " : context value of ARQ.serviceParams");
            return null;
        }
    }

    /**
     * read timeout param
     *
     * @param context query context
     * @return parsed param
     */
    protected long timeoutFromContext(Context context) {
        return parseTimeout(context.get(Service.httpQueryTimeout));
    }

    /**
     * Find the timeout. Return -1L for no setting.
     *
     * @param obj config object
     * @return parsed long
     */
    protected long parseTimeout(Object obj) {
        if (obj == null)
            return -1L;
        try {
            if (obj instanceof Number)
                return ((Number) obj).longValue();
            if (obj instanceof String)
                return Long.parseLong((String) obj);
            monitor.warning("Can't interpret timeout: " + obj);
            return -1L;
        } catch (Exception ex) {
            monitor.warning("Exception setting timeout (context) from: " + obj);
            return -1L;
        }
    }
}
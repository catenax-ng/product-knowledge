//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.sparql;

import io.catenax.knowledge.dataspace.edc.AgentConfig;
import io.catenax.knowledge.dataspace.edc.AgreementController;
import io.catenax.knowledge.dataspace.edc.http.HttpClientWrapper;
import jakarta.ws.rs.WebApplicationException;
import okhttp3.OkHttpClient;
import org.apache.jena.atlas.logging.FmtLog;
import org.apache.jena.atlas.logging.Log;
import org.apache.jena.graph.Node;
import org.apache.jena.graph.NodeFactory;
import org.apache.jena.http.HttpEnv;
import org.apache.jena.http.RegistryHttpClient;
import org.apache.jena.query.Query;
import org.apache.jena.query.QueryExecException;
import org.apache.jena.query.QueryFactory;
import org.apache.jena.riot.out.NodeFmtLib;
import org.apache.jena.sparql.algebra.Op;
import org.apache.jena.sparql.algebra.OpAsQuery;
import org.apache.jena.sparql.algebra.OpVars;
import org.apache.jena.sparql.algebra.op.OpService;
import org.apache.jena.sparql.core.Var;
import org.apache.jena.sparql.engine.ExecutionContext;
import org.apache.jena.sparql.engine.QueryIterator;
import org.apache.jena.sparql.engine.Rename;
import org.apache.jena.sparql.engine.binding.Binding;
import org.apache.jena.sparql.engine.http.HttpParams;
import org.apache.jena.sparql.engine.iterator.QueryIter;
import org.apache.jena.sparql.engine.iterator.QueryIterCommonParent;
import org.apache.jena.sparql.engine.iterator.QueryIterPlainWrapper;
import org.apache.jena.sparql.engine.iterator.QueryIterSingleton;
import org.apache.jena.sparql.exec.RowSet;
import org.apache.jena.sparql.exec.http.*;
import org.apache.jena.sparql.service.single.ServiceExecutorHttp;
import org.apache.jena.sparql.syntax.Element;
import org.apache.jena.sparql.syntax.ElementSubQuery;
import org.apache.jena.sparql.util.Context;
import org.apache.jena.sparql.util.Symbol;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.types.domain.edr.EndpointDataReference;

import java.net.http.HttpClient;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * A service executor which replaces outgoing http calls
 * by appropriate dataspace agreements/calls
 */
public class DataspaceServiceExecutor extends ServiceExecutorHttp {

    /**
     * EDC services
     */
    final Monitor monitor;
    final AgreementController agreementController;
    final AgentConfig config;
    final HttpClient client;


    /**
     * some constants
     */
    public final static Symbol authKey = Symbol.create("cx:authKey");
    public final static Symbol authSecret = Symbol.create("cx:authSecret");
    public final static Pattern EDC_TARGET_ADDRESS = Pattern.compile("(?<protocol>edc|edcs)://(?<connector>[^#?]*)(#(?<asset>[^/?]*))?(\\?(?<params>.*))?");

    /**
     * create a new executor
     *
     * @param monitor    logging subsystem
     * @param controller dataspace agreement
     */
    public DataspaceServiceExecutor(Monitor monitor, AgreementController controller, AgentConfig config, OkHttpClient client) {
        this.monitor = monitor;
        this.agreementController = controller;
        this.config = config;
        this.client=new HttpClientWrapper(client);
    }


    /**
     * (re-) implements the http service execution
     *
     * @param opExecute  the bound operator (if variable is used in service description)
     * @param opOriginal the unbound operator
     * @param binding    the current binding
     * @param execCxt    the execution context
     * @return a set of query results
     * TODO check what happens with "multiple" bindings of service URI and variables
     */
    @Override
    public QueryIterator createExecution(OpService opExecute, OpService opOriginal, Binding binding,
                                         ExecutionContext execCxt) {
        Context context = execCxt.getContext();
        if (!opExecute.getService().isURI())
            throw new QueryExecException("Service URI not bound: " + opExecute.getService());

        boolean silent = opExecute.getSilent();
        OpService realOpExecute = opExecute;

        // check whether we need to route over EDC
        String target = opExecute.getService().getURI();
        Matcher edcMatcher = EDC_TARGET_ADDRESS.matcher(target);
        if (edcMatcher.matches()) {

            monitor.info(String.format("About to execute edc target %s via dataspace", target));
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
                asset = config.getDefaultAsset();
            }
            EndpointDataReference endpoint = agreementController.get(asset);
            if (endpoint == null) {
                try {
                    endpoint = agreementController.createAgreement(remoteUrl, asset);
                } catch (WebApplicationException e) {
                    if (silent) {
                        monitor.warning(String.format("Could not get an agreement from connector %s to asset %s", remoteUrl, asset), e.getCause());
                        return QueryIterSingleton.create(binding, execCxt);
                    }
                    throw e;
                }
            }
            // put the endpoint information into a new service operator
            String targetUrl = endpoint.getEndpoint();
            if (edcMatcher.group("params") != null) {
                targetUrl = targetUrl + "?" + edcMatcher.group("params");
            }
            Node newServiceNode = NodeFactory.createURI(targetUrl);
            Map<String, Map<String, List<String>>> allServiceParams = context.get(Service.serviceParams);
            if (allServiceParams == null) {
                allServiceParams = new HashMap<>();
                context.put(Service.serviceParams, allServiceParams);
            }
            Map<String, List<String>> serviceParams = allServiceParams.computeIfAbsent(targetUrl, k -> new HashMap<>());
            serviceParams.put("Accept",List.of("application/json"));
            realOpExecute = new OpService(newServiceNode, opExecute.getSubOp(), opExecute.getServiceElement(), silent);
            execCxt.getContext().put(authKey, endpoint.getAuthKey());
            execCxt.getContext().put(authSecret, endpoint.getAuthCode());
        } else {
            monitor.info(String.format("About to execute http target %s without dataspace", target));
        }

        // http execute with headers and such
        try {
            // [QExec] Add getSubOpUnmodified();
            String serviceURL = realOpExecute.getService().getURI();

            Op opRemote = realOpExecute.getSubOp();

            // This relies on the observation that the query was originally correct,
            // so reversing the scope renaming is safe (it merely restores the
            // algebra expression).
            //
            // Any variables that reappear should be internal ones that were hidden
            // by renaming in the first place.
            //
            // Any substitution is also safe because it replaces variables by
            // values.
            //
            // It is safer to rename/unrename than skipping SERVICE during rename
            // to avoid substituting hidden variables.

            Op opRestored = Rename.reverseVarRename(opRemote, true);
            Query query = OpAsQuery.asQuery(opRestored);
            // Transforming: Same object means "no change"
            boolean requiresRemapping = false;
            Map<Var, Var> varMapping = null;
            if (!opRestored.equals(opRemote)) {
                varMapping = new HashMap<>();
                Set<Var> originalVars = OpVars.visibleVars(realOpExecute);
                Set<Var> remoteVars = OpVars.visibleVars(opRestored);

                for (Var v : originalVars) {
                    if (v.getName().contains("/")) {
                        // A variable which was scope renamed so has a different name
                        String origName = v.getName().substring(v.getName().lastIndexOf('/') + 1);
                        Var remoteVar = Var.alloc(origName);
                        if (remoteVars.contains(remoteVar)) {
                            varMapping.put(remoteVar, v);
                            requiresRemapping = true;
                        }
                    } else {
                        // A variable which does not have a different name
                        if (remoteVars.contains(v))
                            varMapping.put(v, v);
                    }
                }
            }

            // -- Setup
            //boolean withCompression = context.isTrueOrUndef(httpQueryCompression);
            long timeoutMillis = context.getLong(Service.httpQueryTimeout, -1);

            // RegistryServiceModifier is applied by QueryExecHTTP
            Params serviceParams = getServiceParamsFromContext(serviceURL, context);
            HttpClient httpClient = chooseHttpClient(serviceURL, context);

            QuerySendMode querySendMode = chooseQuerySendMode(serviceURL, context, QuerySendMode.asGetWithLimitBody);
            // -- End setup

            // Build the execution
            QueryExecHTTPBuilder qExecBuilder = QueryExecHTTP.newBuilder()
                    .endpoint(serviceURL)
                    .timeout(timeoutMillis, TimeUnit.MILLISECONDS)
                    .query(query)
                    .params(serviceParams)
                    .context(context)
                    .httpClient(httpClient)
                    .sendMode(querySendMode);

            if (context.isDefined(authKey)) {
                qExecBuilder.httpHeader(context.get(authKey), context.get(authSecret));
            }

            QueryExecHTTP qExec = qExecBuilder.build();

            // Detach from the network stream.
            RowSet rowSet = qExec.select().materialize();
            QueryIterator qIter = QueryIterPlainWrapper.create(rowSet);
            if (requiresRemapping)
                qIter = QueryIter.map(qIter, varMapping);
            qIter = QueryIter.makeTracked(qIter, execCxt);
            return new QueryIterCommonParent(qIter, binding, execCxt);
        } catch (RuntimeException ex) {
            if (silent) {
                Log.warn(this, "SERVICE " + NodeFmtLib.strTTL(opExecute.getService()) + " : " + ex.getMessage());
                // Return the input
                return QueryIterSingleton.create(binding, execCxt);
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
        if (context == null)
            return dftValue;
        Object querySendMode = context.get(Service.httpServiceSendMode, dftValue);
        if (querySendMode == null)
            return dftValue;

        if (querySendMode instanceof QuerySendMode)
            // handle enum type from Java API
            return (QuerySendMode) querySendMode;

        if (querySendMode instanceof String) {
            String str = (String) querySendMode;
            // Specials.
            if ("POST".equalsIgnoreCase(str))
                return QuerySendMode.asPost;
            if ("GET".equalsIgnoreCase(str))
                return QuerySendMode.asGetAlways;
            try {
                // "asGetWithLimitForm", "asGetWithLimitBody", "asGetAlways", "asPostForm", "asPost"
                return QuerySendMode.valueOf((String) querySendMode);
            } catch (IllegalArgumentException ex) {
                throw new QueryExecException("Failed to interpret '" + querySendMode + "' as a query send mode");
            }
        }
        FmtLog.warn(Service.class,
                "Unrecognized object type '%s' as a query send mode - ignored", querySendMode.getClass().getSimpleName());
        return dftValue;
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
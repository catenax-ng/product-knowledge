//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.sparql;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.catenax.knowledge.dataspace.edc.AgentConfig;
import org.apache.jena.http.sys.ExecHTTPBuilder;
import org.apache.jena.query.Query;
import org.apache.jena.sparql.exec.QueryExecMod;
import org.apache.jena.sparql.exec.http.Params;
import org.apache.jena.sparql.exec.http.QueryExecHTTP;
import org.apache.jena.sparql.exec.http.QueryExecHTTPBuilder;
import org.apache.jena.sparql.util.Context;

import java.net.http.HttpClient;
import java.util.HashMap;
import java.util.concurrent.TimeUnit;

import static org.apache.jena.http.HttpLib.copyArray;

/**
 * A builder for KA Remote Query Execs
 */
public class QueryExecBuilder extends ExecHTTPBuilder<QueryExec, QueryExecBuilder> implements QueryExecMod, org.apache.jena.sparql.exec.QueryExecBuilder {

    public static QueryExecBuilder create() { return new QueryExecBuilder(); }

    public static QueryExecBuilder service(String serviceURL) { return create().endpoint(serviceURL); }

    private QueryExecBuilder() {}

    @Override
    protected QueryExecBuilder thisBuilder() {
        return this;
    }

    protected ObjectMapper objectMapper;
    protected AgentConfig agentConfig;

    @Override
    protected QueryExec buildX(HttpClient hClient, Query queryActual, String queryStringActual, Context cxt) {
        return new QueryExec(serviceURL, queryActual, queryStringActual, urlLimit,
                hClient, new HashMap<>(httpHeaders), Params.create(params), cxt,
                copyArray(defaultGraphURIs),
                copyArray(namedGraphURIs),
                sendMode, appAcceptHeader,
                timeout, timeoutUnit, objectMapper,agentConfig);
    }

    @Override
    public QueryExecBuilder initialTimeout(long timeout, TimeUnit timeUnit) {
        throw new UnsupportedOperationException();
    }

    public QueryExecBuilder objectMapper(ObjectMapper objectMapper) {
        this.objectMapper=objectMapper;
        return this;
    }

    public QueryExecBuilder agentConfig(AgentConfig agentConfig) {
        this.agentConfig=agentConfig;
        return this;
    }

    @Override
    public QueryExecBuilder overallTimeout(long timeout, TimeUnit timeUnit) {
        super.timeout(timeout, timeUnit);
        return thisBuilder();
    }

    @Override
    public Context getContext() {
        return null;
    }
}

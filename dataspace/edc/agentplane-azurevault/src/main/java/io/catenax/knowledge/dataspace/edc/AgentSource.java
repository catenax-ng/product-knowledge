//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import dev.failsafe.RetryPolicy;
import io.catenax.knowledge.dataspace.edc.sparql.SparqlQueryProcessor;
import okhttp3.OkHttpClient;
import okhttp3.Response;
import org.eclipse.dataspaceconnector.dataplane.http.pipeline.HttpRequestParams;
import org.eclipse.dataspaceconnector.dataplane.spi.pipeline.DataSource;
import org.eclipse.dataspaceconnector.spi.EdcException;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.DataFlowRequest;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.stream.Stream;

import static dev.failsafe.Failsafe.with;
import static java.lang.String.format;

/**
 * An agent-enabled http-transfer source
 * there are two modes of operation: Routing transfer and
 * calling a single (in the future: several) graph endpoint
 * (in which case we rather need to
 * invoke the surrounding plane sparql engine to
 * perform some joins/pre and postprocessing and event
 * further delegations) and that engine will in turn
 * delegate to the final endpoint (for which we
 * replace any "GRAPH" occurences with "SERVICE" references
 * in the processor)
 * TODO generalize to shield several endpoints/assets
 */
public class AgentSource implements DataSource {
    protected String name;
    protected HttpRequestParams params;
    protected String requestId;
    protected RetryPolicy<Object> retryPolicy;
    protected OkHttpClient httpClient;
    protected boolean isTransfer;
    protected SparqlQueryProcessor processor;
    protected SkillStore skillStore;

    protected DataFlowRequest request;

    /**
     * creates new agent source
     */
    public AgentSource() {
    }

    @Override
    public Stream<Part> openPartStream() {
        return Stream.of(getPart());
    }

    /**
     * main logic calling the agent
     * @return the result as a named byte array
     */
    protected AgentPart getPart() {
        if(!isTransfer) {
            String skill=null;
            String graph=null;
            String asset= request.getSourceDataAddress().getProperties().get("asset:prop:id");
            if(asset!=null && asset.length() > 0) {
                Matcher graphMatcher=AgentExtension.GRAPH_PATTERN.matcher(asset);
                if(graphMatcher.matches()) {
                    graph=asset;
                }
                Matcher skillMatcher=SkillStore.SKILL_PATTERN.matcher(asset);
                if(skillMatcher.matches()) {
                    skill=asset;
                }
            }
            String authKey=request.getSourceDataAddress().getProperties().getOrDefault("authKey",null);
            String authCode=request.getSourceDataAddress().getProperties().getOrDefault("authCode",null);
            try (Response response = processor.execute(params.toRequest(),skill,graph,authKey,authCode)) {
                return getPart(response);
            } catch (IOException e) {
                throw new EdcException(e);
            }
        } else {
            try (var response = with(retryPolicy).get(() -> httpClient.newCall(params.toRequest()).execute())) {
                return getPart(response);
            } catch (IOException e) {
                throw new EdcException(e);
            }
        }
    }

    /**
     * helper to perform the body processing
     * @param response a given response from the agent
     * @return body as named byte array
     * @throws IOException in case anything goes wrong
     * TODO proper status handling in case of expected failures
     */
    protected AgentPart getPart(Response response) throws IOException {
        var body = response.body();
        var stringBody = body != null ? body.string() : null;
        if (stringBody == null) {
            throw new EdcException(format("Received empty response body transferring HTTP data for request %s: %s", requestId, response.code()));
        }
        if (response.isSuccessful()) {
            return new AgentPart(name, stringBody.getBytes());
        } else {
            throw new EdcException(format("Received code transferring HTTP data for request %s: %s - %s. %s", requestId, response.code(), response.message(), stringBody));
        }
    }

    /**
     * the agent source builder
     */
    public static class Builder {
        protected final AgentSource dataSource;

        public static AgentSource.Builder newInstance() {
            return new AgentSource.Builder();
        }

        public AgentSource.Builder params(HttpRequestParams params) {
            dataSource.params = params;
            return this;
        }

        public AgentSource.Builder name(String name) {
            dataSource.name = name;
            return this;
        }

        public AgentSource.Builder requestId(String requestId) {
            dataSource.requestId = requestId;
            return this;
        }

        public AgentSource.Builder retryPolicy(RetryPolicy<Object> retryPolicy) {
            dataSource.retryPolicy = retryPolicy;
            return this;
        }

        public AgentSource.Builder httpClient(OkHttpClient httpClient) {
            dataSource.httpClient = httpClient;
            return this;
        }

        public AgentSource.Builder isTransfer(boolean isTransfer) {
            dataSource.isTransfer=isTransfer;
            return this;
        }

        public AgentSource.Builder processor(SparqlQueryProcessor processor) {
            dataSource.processor=processor;
            return this;
        }

        public AgentSource.Builder skillStore(SkillStore skillStore) {
            dataSource.skillStore=skillStore;
            return this;
        }

        public AgentSource.Builder request(DataFlowRequest request) {
            dataSource.request=request;
            return this;
        }

        public AgentSource build() {
            Objects.requireNonNull(dataSource.requestId, "requestId");
            Objects.requireNonNull(dataSource.httpClient, "httpClient");
            Objects.requireNonNull(dataSource.retryPolicy, "retryPolicy");
            return dataSource;
        }

        public Builder() {
            dataSource = new AgentSource();
        }
    }

    private static class AgentPart implements Part {
        private final String name;
        private final byte[] content;

        AgentPart(String name, byte[] content) {
            this.name = name;
            this.content = content;
        }

        @Override
        public String name() {
            return name;
        }

        @Override
        public long size() {
            return content.length;
        }

        @Override
        public InputStream openStream() {
            return new ByteArrayInputStream(content);
        }

    }
}

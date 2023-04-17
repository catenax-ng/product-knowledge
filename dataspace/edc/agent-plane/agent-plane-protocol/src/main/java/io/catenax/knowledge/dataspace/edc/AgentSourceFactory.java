//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import io.catenax.knowledge.dataspace.edc.sparql.SparqlQueryProcessor;
import okhttp3.OkHttpClient;
import org.eclipse.dataspaceconnector.dataplane.spi.pipeline.DataSource;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import dev.failsafe.RetryPolicy;
import org.eclipse.dataspaceconnector.spi.types.domain.HttpDataAddress;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.DataFlowRequest;

/**
 * A factory for Agent Sources (representing backend SparQL endpoints)
 */
public class AgentSourceFactory extends org.eclipse.dataspaceconnector.dataplane.http.pipeline.HttpDataSourceFactory {

    final AgentSourceRequestParamsSupplier supplier;
    final Monitor monitor;
    final OkHttpClient httpClient;
    final RetryPolicy<Object> retryPolicy;
    final SparqlQueryProcessor processor;
    final SkillStore skillStore;

    /**
     * create a new agent source factory
     * @param httpClient http outgoing system
     * @param retryPolicy a retry policy to use
     * @param supplier a parameter supplier helper
     * @param skillStore store for skills
     */
    public AgentSourceFactory(OkHttpClient httpClient, RetryPolicy<Object> retryPolicy, AgentSourceRequestParamsSupplier supplier, Monitor monitor, SparqlQueryProcessor processor, SkillStore skillStore) {
        super(httpClient,retryPolicy,supplier);
        this.supplier=supplier;
        this.monitor=monitor;
        this.httpClient=httpClient;
        this.retryPolicy=retryPolicy;
        this.skillStore=skillStore;
        this.processor=processor;
    }

    /**
     * choose the agent protocol
     * @param request the request to check
     * @return flag
     */
    @Override
    public boolean canHandle(DataFlowRequest request) {
        return AgentProtocol.SPARQL_HTTP.getProtocolId().equals(request.getSourceDataAddress().getType());
    }

    /**
     * depending on the transfer mode,  choose to manipulate the
     * target address.
     * @param request incoming agent protocol request
     * @return new data source
     */
    @Override
    public DataSource createSource(DataFlowRequest request) {
        boolean isTransfer=isTransferRequest(request);
        var dataAddress = HttpDataAddress.Builder.newInstance()
                .copyFrom(request.getSourceDataAddress())
                .build();
        AgentSource dataSource= AgentSource.Builder.newInstance()
                .httpClient(httpClient)
                .requestId(request.getId())
                .name(dataAddress.getName())
                .params(supplier.apply(request))
                .retryPolicy(retryPolicy)
                .isTransfer(isTransfer)
                .skillStore(skillStore)
                .processor(processor)
                .request(request)
                .build();
        monitor.debug(String.format("Created a new agent source %s in transfer mode %b for destination type %s",
                dataSource,isTransfer,
                request.getDestinationDataAddress().getType()));
        return dataSource;
    }

    /**
     * a check that distinguishes between http transfer and http data requests
     * @param request incoming data flow request
     * @return flag indicating whether its a transfer or protocol request
     */
    public static boolean isTransferRequest(DataFlowRequest request) {
        return request.getSourceDataAddress().getProperties().getOrDefault("asset:prop:id", null)==null;
    }
}
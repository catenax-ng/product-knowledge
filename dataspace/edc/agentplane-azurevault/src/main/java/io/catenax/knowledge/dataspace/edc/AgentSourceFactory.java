//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
package io.catenax.knowledge.dataspace.edc;

import okhttp3.OkHttpClient;
import org.eclipse.dataspaceconnector.dataplane.http.pipeline.HttpDataSource;
import org.eclipse.dataspaceconnector.dataplane.http.pipeline.HttpRequestParamsSupplier;
import org.eclipse.dataspaceconnector.dataplane.spi.pipeline.DataSource;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.security.Vault;
import dev.failsafe.RetryPolicy;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.DataFlowRequest;

/**
 * A factory for Agent Sources (representing backend SparQL endpoints)
 */
public class AgentSourceFactory extends org.eclipse.dataspaceconnector.dataplane.http.pipeline.HttpDataSourceFactory {

    final HttpRequestParamsSupplier supplier;
    final Monitor monitor;

    /**
     * create a new agent source factory
     * @param httpClient http outgoing system
     * @param retryPolicy a retry ppolicy to use
     * @param supplier a parameter supplier hellper
     */
    public AgentSourceFactory(OkHttpClient httpClient, RetryPolicy<Object> retryPolicy, HttpRequestParamsSupplier supplier, Monitor monitor) {
        super(httpClient,retryPolicy,supplier);
        this.supplier=supplier;
        this.monitor=monitor;
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
     * soon, we will create a special source tied to fuseki
     * @param request incoming agent protocol request
     * @return new data source
     */
    @Override
    public DataSource createSource(DataFlowRequest request) {
        HttpDataSource dataSource=(HttpDataSource) super.createSource(request);
        monitor.debug(String.format("Created a new agent source %s for destination type %s and params %s",dataSource,request.getDestinationDataAddress().getType(),supplier.apply(request).toRequest()));
        return dataSource;
    }
}
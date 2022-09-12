//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import okhttp3.OkHttpClient;
import org.eclipse.dataspaceconnector.dataplane.http.pipeline.HttpRequestParamsSupplier;
import org.eclipse.dataspaceconnector.dataplane.spi.pipeline.DataSink;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.DataFlowRequest;

import java.util.concurrent.ExecutorService;

/**
 * implements an agent specific protocol sink for invoking federated
 * services
 */
public class AgentSinkFactory extends org.eclipse.dataspaceconnector.dataplane.http.pipeline.HttpDataSinkFactory {

    final HttpRequestParamsSupplier supplier;
    final Monitor monitor;

    /**
     * creates the sink factory
     * @param httpClient http outgoing system
     * @param executorService multithreading system
     * @param partitionSize number of concurrent partitions to use
     * @param monitor logging reference
     * @param supplier parameter supplier
     */
    public AgentSinkFactory(OkHttpClient httpClient,
                            ExecutorService executorService,
                            int partitionSize,
                            Monitor monitor,
                            HttpRequestParamsSupplier supplier) {
        super(httpClient,executorService,partitionSize,monitor,supplier);
        this.supplier=supplier;
        this.monitor=monitor;
    }

    /**
     * switch to the right protocol
     * @param request to check
     * @return flag
     */
    @Override
    public boolean canHandle(DataFlowRequest request) {
        return AgentProtocol.SPARQL_HTTP.getProtocolId().equals(request.getDestinationDataAddress().getType());
    }

    @Override
    public DataSink createSink(DataFlowRequest request) {
        DataSink sink=super.createSink(request);
        monitor.debug(String.format("Created a new agent sink %s for destination %s and params %s",sink,request.getDestinationDataAddress().getType(),supplier.apply(request).toRequest()));
        return sink;

    }
}



//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import okhttp3.OkHttpClient;
import org.eclipse.dataspaceconnector.dataplane.http.pipeline.HttpRequestParamsSupplier;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.DataFlowRequest;

import java.util.concurrent.ExecutorService;

/**
 * implements an agent specific protocol sink for invoking federated
 * services
 */
public class AgentSinkFactory extends org.eclipse.dataspaceconnector.dataplane.http.pipeline.HttpDataSinkFactory {

    /**
     * constant
     */
    public static String AGENT_TYPE_SERVER="HttpData";
    public static String AGENT_TYPE_CLIENT="HttpProxy";

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
    }

    /**
     * switch to the right protocol
     * @param request to check
     * @return flag
     */
    @Override
    public boolean canHandle(DataFlowRequest request) {
        return AGENT_TYPE_SERVER.equals(request.getDestinationDataAddress().getType());
    }
}



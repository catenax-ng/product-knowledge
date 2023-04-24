//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.http.transfer;

import io.catenax.knowledge.dataspace.edc.AgentConfig;
import org.eclipse.edc.connector.dataplane.http.params.decorators.BaseCommonHttpParamsDecorator;
import org.eclipse.edc.connector.dataplane.http.params.decorators.BaseSinkHttpParamsDecorator;
import org.eclipse.edc.connector.dataplane.http.spi.HttpParamsDecorator;
import org.eclipse.edc.connector.dataplane.http.spi.HttpRequestParams;
import org.eclipse.edc.connector.dataplane.http.spi.HttpRequestParamsProvider;
import org.eclipse.edc.spi.monitor.Monitor;
import org.eclipse.edc.spi.security.Vault;
import org.eclipse.edc.spi.types.TypeManager;
import org.eclipse.edc.spi.types.domain.HttpDataAddress;
import org.eclipse.edc.spi.types.domain.transfer.DataFlowRequest;
import java.util.ArrayList;
import java.util.List;


/**
 * request params supplier which correctly double encodes
 * valid url symbols in the parameter section, extracts
 * original headers like accept from special parameters and caters for
 * translating url-encoded form bodies into their
 * "normal" param+body form
 */
public class AgentSourceRequestParamsSupplier implements HttpRequestParamsProvider {
    protected final List<HttpParamsDecorator> sourceDecorators = new ArrayList<>();
    protected final List<HttpParamsDecorator> sinkDecorators = new ArrayList<>();

    /**
     * the edc config section
     */
    protected final AgentConfig config;

    /**
     * logging subsystem
     */
    protected  Monitor monitor;

    /**
     * creates a supplier
     * @param vault secret host
     * @param config edc config section
     * @param monitor logging reference
     */
    public AgentSourceRequestParamsSupplier(Vault vault, TypeManager typeManager, AgentConfig config, Monitor monitor) {
        BaseCommonHttpParamsDecorator commonHttpParamsDecorator = new BaseCommonHttpParamsDecorator(vault, typeManager);
        this.registerSinkDecorator(commonHttpParamsDecorator);
        this.registerSourceDecorator(commonHttpParamsDecorator);
        this.registerSourceDecorator(new AgentSourceHttpParamsDecorator(config,monitor));
        this.registerSinkDecorator(new BaseSinkHttpParamsDecorator());
        this.config=config;
        this.monitor=monitor;
    }

    @Override
    public void registerSourceDecorator(HttpParamsDecorator decorator) {
        this.sourceDecorators.add(decorator);
    }

    @Override
    public void registerSinkDecorator(HttpParamsDecorator decorator) {
        this.sinkDecorators.add(decorator);
    }

    @Override
    public HttpRequestParams provideSourceParams(DataFlowRequest request) {
        HttpRequestParams.Builder params = HttpRequestParams.Builder.newInstance();
        HttpDataAddress address = org.eclipse.edc.spi.types.domain.HttpDataAddress.Builder.newInstance().copyFrom(request.getSourceDataAddress()).build();
        this.sourceDecorators.forEach((decorator) -> decorator.decorate(request, address, params));
        return params.build();
    }

    @Override
    public HttpRequestParams provideSinkParams(DataFlowRequest request) {
        HttpRequestParams.Builder params = HttpRequestParams.Builder.newInstance();
        HttpDataAddress address = org.eclipse.edc.spi.types.domain.HttpDataAddress.Builder.newInstance().copyFrom(request.getDestinationDataAddress()).build();
        this.sinkDecorators.forEach((decorator) -> decorator.decorate(request, address, params));
        return params.build();
    }
}

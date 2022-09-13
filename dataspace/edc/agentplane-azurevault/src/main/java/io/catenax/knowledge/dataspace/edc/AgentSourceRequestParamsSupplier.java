//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import io.catenax.knowledge.dataspace.edc.http.HttpUtils;
import org.apache.http.HttpStatus;
import org.eclipse.dataspaceconnector.dataplane.http.pipeline.HttpSourceRequestParamsSupplier;
import org.eclipse.dataspaceconnector.spi.EdcException;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.security.Vault;
import org.eclipse.dataspaceconnector.spi.types.domain.DataAddress;
import org.eclipse.dataspaceconnector.spi.types.domain.HttpDataAddress;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.DataFlowRequest;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.util.Collection;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.eclipse.dataspaceconnector.dataplane.spi.schema.DataFlowRequestSchema.QUERY_PARAMS;

/**
 * request params supplier which correctly double encodes
 * valid url symbols in the parameter section
 */
public class AgentSourceRequestParamsSupplier extends HttpSourceRequestParamsSupplier {

    final AgentConfig config;
    final Monitor monitor;

    /**
     * creates a supplier
     * @param vault secret host
     */
    public AgentSourceRequestParamsSupplier(Vault vault, AgentConfig config, Monitor monitor) {
        super(vault);
        this.config=config;
        this.monitor=monitor;
    }

    public static Pattern CX_ACCEPT_PARAM= Pattern.compile("cx_accept=?(?<Accept>[^&]*)&?");

    @Override
    protected @Nullable String extractQueryParams(HttpDataAddress address, DataFlowRequest request) {
        if (request.getSourceDataAddress().getProperties().getOrDefault("baseUrl", "").contains("api/public"))
            return super.extractQueryParams(address,request);
        return address.getProperty(QUERY_PARAMS);
    }

    @Override
    protected @NotNull DataAddress selectAddress(DataFlowRequest request) {
        try {
            DataAddress superAddress = super.selectAddress(request);
            if (request.getSourceDataAddress().getProperties().getOrDefault("baseUrl", "").contains("api/public"))
                return superAddress;
            monitor.debug(String.format("Rewriting params/headers of request %s before hitting backend.",request));
            boolean fixedHeader=superAddress.getProperty(HttpDataAddress.ADDITIONAL_HEADER+"Accept")!=null;
            boolean fixedHost=superAddress.getProperty(HttpDataAddress.ADDITIONAL_HEADER+"Host")!=null;
            String oldQueryParams=request.getProperties().getOrDefault(QUERY_PARAMS,"");

            String accept="*/*";
            StringBuilder newQueryParams=new StringBuilder();
            int lastStart=0;
            Matcher acceptMatcher = CX_ACCEPT_PARAM.matcher(oldQueryParams);
            while (acceptMatcher.find()) {
                int yetString=Math.max(acceptMatcher.start() - 1,lastStart);
                newQueryParams.append(oldQueryParams.substring(lastStart, yetString));
                String newAccept= acceptMatcher.group("Accept");
                if(newAccept!=null && newAccept.length()>0) {
                    accept=newAccept.replace("%2F","/");
                }
                lastStart = acceptMatcher.end();
            }
            newQueryParams.append(oldQueryParams.substring(lastStart));
            String targetQueryParams=HttpUtils.encodeParameter(newQueryParams.toString());

            var addressBuilder =
                HttpDataAddress.Builder.newInstance().copyFrom(superAddress);

            addressBuilder.property(QUERY_PARAMS,targetQueryParams);

            if(!fixedHeader) {
                addressBuilder.addAdditionalHeader("Accept", accept);
            }
            if(!fixedHost) {
                URL controlPlane=new URL(config.getControlPlaneManagementUrl());
                String hostPart=controlPlane.getHost();
                int portPart = controlPlane.getPort();
                String host=String.format("%s:%d",hostPart,portPart);
                addressBuilder.addAdditionalHeader("Host", host);
            }
            return addressBuilder.build();
        } catch (Throwable e) {
            monitor.severe("Cannot encode query params",e);
            throw new EdcException("Cannot encode query params.",e);
        }
    }
}

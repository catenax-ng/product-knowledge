//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import io.catenax.knowledge.dataspace.edc.http.HttpUtils;
import org.eclipse.dataspaceconnector.dataplane.http.pipeline.HttpSourceRequestParamsSupplier;
import org.eclipse.dataspaceconnector.spi.EdcException;
import org.eclipse.dataspaceconnector.spi.security.Vault;
import org.eclipse.dataspaceconnector.spi.types.domain.HttpDataAddress;
import org.eclipse.dataspaceconnector.spi.types.domain.transfer.DataFlowRequest;

import java.io.UnsupportedEncodingException;

/**
 * request params supplier which correctly double encodes
 * valid url symbols in the parameter section
 */
public class AgentSourceRequestParamsSupplier extends HttpSourceRequestParamsSupplier {

    /**
     * creates a supplier
     * @param vault secret host
     */
    public AgentSourceRequestParamsSupplier(Vault vault) {
        super(vault);
    }

    /**
     * make sure curly braces and question marks are correctly envoded
     * @param address data source address
     * @param request data request
     * @return parameter string
     */
    @Override
    protected String extractQueryParams(HttpDataAddress address, DataFlowRequest request) {
        try {
            return HttpUtils.urlEncodeParameter(super.extractQueryParams(address, request));
        } catch(UnsupportedEncodingException uee) {
            throw new EdcException("Cannot extract query params.",uee);
        }
    }
}

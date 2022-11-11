//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import jakarta.ws.rs.WebApplicationException;
import org.eclipse.dataspaceconnector.spi.types.domain.edr.EndpointDataReference;

/**
 * mock agreement controller for testing purposes
 */
public class MockAgreementController implements IAgreementController {

    @Override
    public EndpointDataReference get(String assetId) {
        EndpointDataReference.Builder builder= EndpointDataReference.Builder.newInstance();
        builder.endpoint("http://localhost:8080/sparql#"+assetId);
        return builder.build();
    }

    @Override
    public EndpointDataReference createAgreement(String remoteUrl, String asset) throws WebApplicationException {
        return get(asset);
    }

}

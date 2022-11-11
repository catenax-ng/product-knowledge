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
 * Interface to any agreement controller
 */
public interface IAgreementController {

    /**
     * check whether an agreement for the asset already exists
     * @param asset id of the asset
     * @return endpoint data reference, null if non-existant
     */
    EndpointDataReference get(String asset);
    /**
     * negotiates an endpoint for the given asset
     * @param remoteUrl the connector
     * @param asset id of the asset
     * @return endpoint data reference
     * @throws WebApplicationException in case agreement could not be made (in time)
     */
    EndpointDataReference createAgreement(String remoteUrl, String asset) throws WebApplicationException;
}

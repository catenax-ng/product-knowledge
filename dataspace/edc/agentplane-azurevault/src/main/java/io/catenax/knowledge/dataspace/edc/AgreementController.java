
//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.MediaType;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.types.domain.edr.EndpointDataReference;

import com.auth0.jwt.JWT;
import com.auth0.jwt.interfaces.DecodedJWT;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * An endpoint/service that receives information from the control plane
 */
@Consumes({MediaType.APPLICATION_JSON})
@Path("/endpoint-data-reference")
public class AgreementController {

    private final Monitor monitor;
    private final Map<String, EndpointDataReference> store = new HashMap<>();
    private final String controlPlaneUrl;

    /** creates a new agreement controller */
    public AgreementController(Monitor monitor, AgentConfig config) {
        this.monitor = monitor;
        this.controlPlaneUrl=config.getDefaultAsset();
    }

    @Override
    public String toString() {
        return super.toString()+"/endpoint-data-reference";
    }

    /**
     * this is called by the control plan when an agreement has been made
     * @param dataReference contains the actual call token 
     */
    @POST
    public void receiveEdcCallback(EndpointDataReference dataReference) {
        var agreementId = dataReference.getProperties().get("cid");
        synchronized(store) {
            store.put(agreementId, dataReference);
        }
        monitor.debug(String.format("An endpoint data reference for agreement %s has been posted.",agreementId));
    }

    /**
     * accesses the agreements
     */
    public EndpointDataReference get(String agreementId) {
        synchronized(store) {
            EndpointDataReference result = store.get(agreementId);
            if(result!=null) {
                String token = result.getAuthCode();
                if(token!=null) {
                    DecodedJWT jwt = JWT.decode(token);
                    if(!jwt.getExpiresAt().before(new Date(System.currentTimeMillis() + 30 * 1000))) {
                        return result;
                    }
                }
                store.remove(agreementId);
            }
            return null;
        }
    }

}

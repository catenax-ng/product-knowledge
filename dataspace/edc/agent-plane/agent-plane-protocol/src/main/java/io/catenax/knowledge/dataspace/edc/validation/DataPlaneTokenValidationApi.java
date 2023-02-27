//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.validation;

import jakarta.ws.rs.core.Response;

/**
 * Rest interface to the token validator
 */
public interface DataPlaneTokenValidationApi {
    Response validate(String token);
}

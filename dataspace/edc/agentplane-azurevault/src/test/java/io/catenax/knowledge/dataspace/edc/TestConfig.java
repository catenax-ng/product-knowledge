//
// EDC Data Plane Agent Extension Test
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import org.eclipse.dataspaceconnector.spi.system.configuration.ConfigImpl;
import java.util.HashMap;

/**
 * test config impl
 */
public class TestConfig extends ConfigImpl {

    public TestConfig() {
        super("edc", new HashMap<String,String>());
    }
    
}

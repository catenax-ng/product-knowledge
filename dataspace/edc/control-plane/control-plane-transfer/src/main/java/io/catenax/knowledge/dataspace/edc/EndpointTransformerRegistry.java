//
// EDC Control Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.eclipse.dataspaceconnector.spi.transfer.edr.EndpointDataReferenceTransformer;
import org.eclipse.dataspaceconnector.spi.transfer.edr.EndpointDataReferenceTransformerRegistry;
import org.eclipse.dataspaceconnector.spi.transfer.flow.DataFlowController;
import org.eclipse.dataspaceconnector.spi.transfer.flow.DataFlowManager;

import java.util.List;

/**
 * A helper to ensure the right priority
 * for transformers as long as the core
 * transformers are implemented "suboptimally"
 */
public class EndpointTransformerRegistry {

    /** its a hidden thingy in the manager */
    protected java.lang.reflect.Field transformersField=null;

    /**
     * sets up the special registry access
     * @param monitor
     */
    public EndpointTransformerRegistry(Monitor monitor) {
        try {
            transformersField= EndpointDataReferenceTransformerRegistry.class.getClassLoader().loadClass("org.eclipse.dataspaceconnector.transfer.core.edr.EndpointDataReferenceTransformerRegistryImpl").getDeclaredField("transformers");
            transformersField.trySetAccessible();
        } catch(SecurityException | NoSuchFieldException | ClassNotFoundException e) {
            monitor.warning(String.format("Could not hookup priorised transformer access. Using non-priorised setup because of %s",e.getMessage()));
        }
    }

    /**
     * register the given transformer with priority if possible
     * @param registry to register at
     * @param transformer to register
     */
    public void registerWithPriority(EndpointDataReferenceTransformerRegistry registry, EndpointDataReferenceTransformer transformer) {
        if(transformersField!=null) {
            try {
                ((List<EndpointDataReferenceTransformer>)transformersField.get(registry)).add(0,transformer);
            } catch (IllegalAccessException e) {
                throw new RuntimeException(e);
            }
        } else {
            registry.registerTransformer(transformer);
        }
    }
}

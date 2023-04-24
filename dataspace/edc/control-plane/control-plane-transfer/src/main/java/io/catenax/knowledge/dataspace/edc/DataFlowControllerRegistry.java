//
// EDC Control Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import org.eclipse.edc.connector.transfer.spi.flow.DataFlowController;
import org.eclipse.edc.connector.transfer.spi.flow.DataFlowManager;
import org.eclipse.edc.spi.monitor.Monitor;

import java.util.List;

/**
 * A helper to ensure the right priority
 * for data flow controllers as long as the core
 * controllers are implemented "suboptimally"
 */
public class DataFlowControllerRegistry {

    /** its a hidden thingy in the manager */
    protected java.lang.reflect.Field controllersField=null;

    /**
     * sets up the special registry access
     * @param monitor logging facility
     */
    public DataFlowControllerRegistry(Monitor monitor) {
        try {
            controllersField= DataFlowManager.class.getClassLoader().loadClass("org.eclipse.edc.connector.transfer.flow.DataFlowManagerImpl").getDeclaredField("controllers");
            controllersField.trySetAccessible();
        } catch(SecurityException | NoSuchFieldException | ClassNotFoundException e) {
            monitor.warning(String.format("Could not hookup priorised controller access. Using non-priorised setup because of %s",e.getMessage()));
        }
    }

    /**
     * register the given controll with priority if possible
     * @param manager to register at
     * @param controller to register
     */
    public void registerWithPriority(DataFlowManager manager, DataFlowController controller) {
        if(controllersField!=null) {
            try {
                ((List<DataFlowController>)controllersField.get(manager)).add(0,controller);
            } catch (IllegalAccessException e) {
                throw new RuntimeException(e);
            }
        } else {
            manager.register(controller);
        }
    }
}

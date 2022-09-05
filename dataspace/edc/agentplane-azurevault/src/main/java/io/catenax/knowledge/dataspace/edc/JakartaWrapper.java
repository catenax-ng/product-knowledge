//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import java.lang.reflect.*;
import java.util.Arrays;

import org.eclipse.dataspaceconnector.spi.monitor.Monitor;

/**
 * An invocation handler which maps all jakarta objects
 * to a javax.servlet level
 */
public class JakartaWrapper implements InvocationHandler, IJakartaWrapper<Object> {
    
    Object jakartaDelegate;
    Monitor monitor;

    public JakartaWrapper(Object jakartaDelegate, Monitor monitor) {
        this.jakartaDelegate=jakartaDelegate;
        this.monitor=monitor;
    }

    @Override
    public Object getDelegate() {
        return jakartaDelegate;
    }

    @Override
    public Monitor getMonitor() {
        return monitor;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        Class[] types=method.getParameterTypes();
        args=IJakartaWrapper.unwrap(types,args);
        Method targetMethod=jakartaDelegate.getClass().getMethod(method.getName(),types);
        Object result=targetMethod.invoke(jakartaDelegate,args);
        //monitor.debug(String.format("Jakarta wrapper mapped method %s to target method %s on args %s with result %s",method,targetMethod,Arrays.toString(args),result));
        if((!method.getReturnType().isAssignableFrom(targetMethod.getReturnType())) && result!=null) {
            result=IJakartaWrapper.javaxify(result,method.getReturnType(),monitor);
        }
        return result;
    }

}

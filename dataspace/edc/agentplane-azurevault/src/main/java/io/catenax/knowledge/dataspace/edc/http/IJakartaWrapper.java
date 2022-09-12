//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.http;

import java.lang.reflect.*;

import org.eclipse.dataspaceconnector.spi.monitor.Monitor;

/**
 * An invocation handler which maps all jakarta objects
 * to a javax.servlet level
 */
public interface IJakartaWrapper<Target> {

    /**
     * @return the wrapper object
     */
    Target getDelegate();

    /**
     * @return EDC logging support
     */
    Monitor getMonitor();

    /**
     * unwrap logic
     * @param types array of type annotations
     * @param args array of objects
     * @return unwrapped array of objects
     * @throws Throwable
     */
    static Object[] unwrap(Class[] types, Object[] args) throws Throwable {
        if(args==null) args=new Object[0];
        for(int count=0;count<args.length;count++) {
            if(types[count].getCanonicalName().startsWith("javax.servlet") && args[count]!=null) {
                IJakartaWrapper<Object> wrapper=null;
                if(args[count] instanceof IJakartaWrapper) {
                    wrapper=(IJakartaWrapper<Object>) args[count];
                } else {
                    // we assume its a proxy
                    wrapper=(IJakartaWrapper<Object>) Proxy.getInvocationHandler(args[count]);
                }
                args[count]=wrapper.getDelegate();
                Class jakartaClass=IJakartaWrapper.class.getClassLoader().loadClass(types[count].getCanonicalName().replace("javax.servlet","jakarta.servlet"));
                types[count]=jakartaClass;
            }
        }
        return args;
    }

    /**
     * wrap logic
     * @param jakarta original object
     * @param javaxClass target interfaces
     * @param monitor EDC loggin subsystem
     * @param <Target> target interfaces as generics
     * @return wrapped object
     */
    static <Target> Target javaxify(Object jakarta, Class<Target> javaxClass, Monitor monitor) {
        if(javax.servlet.ServletInputStream.class.equals(javaxClass)) {
            return (Target) new JakartaServletInputStreamWrapper((jakarta.servlet.ServletInputStream) jakarta,monitor);
        }
        if(javax.servlet.ServletOutputStream.class.equals(javaxClass)) {
            return (Target) new JakartaServletOutputStreamWrapper((jakarta.servlet.ServletOutputStream) jakarta,monitor);
        }
        return (Target) Proxy.newProxyInstance(JakartaWrapper.class.getClassLoader(),
            new Class[] { javaxClass },
            new JakartaWrapper(jakarta,monitor));
    }

}

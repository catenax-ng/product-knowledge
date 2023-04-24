//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.http;

import java.io.IOException;

import javax.servlet.ReadListener;

import jakarta.servlet.ServletInputStream;
import org.eclipse.edc.spi.monitor.Monitor;
import org.jetbrains.annotations.NotNull;

/**
 * An invocation handler which maps all jakarta input stream
 * to a javax.servlet level
 */
public class JakartaServletInputStreamAdapter extends javax.servlet.ServletInputStream implements IJakartaAdapter<ServletInputStream> {
    
    jakarta.servlet.ServletInputStream jakartaDelegate;
    Monitor monitor;

    public JakartaServletInputStreamAdapter(jakarta.servlet.ServletInputStream jakartaDelegate, Monitor monitor) {
        this.jakartaDelegate=jakartaDelegate;
        this.monitor=monitor;
    }

    @Override
    public jakarta.servlet.ServletInputStream getDelegate() {
        return jakartaDelegate;
    }

    @Override
    public Monitor getMonitor() {
        return monitor;
    }

    @Override
    public boolean isFinished() {
        return jakartaDelegate.isFinished();
    }

    @Override
    public boolean isReady() {
        return jakartaDelegate.isReady();
    }

    @Override
    public void setReadListener(ReadListener readListener) {
        //jakartaDelegate.setReadListener(readListener);
    }

    @Override
    public int read() throws IOException {
        return jakartaDelegate.read();
    }

    @Override
    public int read(byte @NotNull [] buf) throws IOException {
        return jakartaDelegate.read(buf);
    }

    @Override
    public int read(byte @NotNull [] b, int off, int len) throws IOException {
        return jakartaDelegate.read(b, off, len);
    }

}

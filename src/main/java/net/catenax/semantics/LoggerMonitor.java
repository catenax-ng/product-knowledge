/*
 * Copyright (c) 2021-2022 T-Systems International GmbH (Catena-X Consortium)
 *
 * See the AUTHORS file(s) distributed with this work for additional
 * information regarding authorship.
 *
 * See the LICENSE file(s) distributed with this work for
 * additional information regarding license terms.
 */
package net.catenax.semantics;

import org.eclipse.dataspaceconnector.spi.monitor.Monitor;

import java.util.function.Supplier;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * A simple adapter from EDC Monitor to JDK logging in case you want
 * to test/run some code without EDC packaging/initialisation
 */
public class LoggerMonitor implements Monitor {

    /**
     * embedded logger
     * TODO filter out this class from the stacktraces
     */
    protected final Logger logger = Logger.getLogger(getClass().getName());

    /**
     * general log adapter
     * @param level
     * @param supplier
     * @param errors
     */
    public void log(Level level, Supplier<String> supplier, Throwable... errors) {
        if(errors.length>0) {
            logger.log(level,supplier.get(),errors[0]);
        } else {
            logger.log(level,supplier.get());
        }
    }

    @Override
    public void severe(Supplier<String> supplier, Throwable... errors) {
        log(Level.SEVERE,supplier,errors);
    }

    @Override
    public void warning(Supplier<String> supplier, Throwable... errors) {
        log(Level.WARNING,supplier,errors);
    }

    @Override
    public void info(Supplier<String> supplier, Throwable... errors) {
        log(Level.INFO,supplier,errors);
    }

    @Override
    public void debug(Supplier<String> supplier, Throwable... errors) {
        log(Level.FINER,supplier,errors);
    }

}

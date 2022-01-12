package net.catenax.semantics.connector;

import org.eclipse.dataspaceconnector.spi.monitor.Monitor;

import java.util.function.Supplier;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * A simple adapter from EDC Monitor to JDK logging
 */
public class LoggerMonitor implements Monitor {

    protected final Logger logger = Logger.getLogger(getClass().getName());

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

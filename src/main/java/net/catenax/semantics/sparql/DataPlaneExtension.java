/*
 *  Copyright (c) 2021 T-Systems International GmbH
 *
 *  This program and the accompanying materials are made available under the
 *  terms of the Apache License, Version 2.0 which is available at
 *  https://www.apache.org/licenses/LICENSE-2.0
 *
 *  SPDX-License-Identifier: Apache-2.0
 *
 *  Contributors:
 *       T-Systems International GmbH - initial API and implementation
 *
 */

package net.catenax.semantics.sparql;

import org.eclipse.dataspaceconnector.spi.protocol.web.WebService;
import org.eclipse.dataspaceconnector.spi.system.ServiceExtension;
import org.eclipse.dataspaceconnector.spi.system.ServiceExtensionContext;

import java.util.Set;

/**
 * A protocol extension providing a query and event API
 */
public class DataPlaneExtension implements ServiceExtension {
    private static final String ENDPOINT_SETTING = "catenax.sparql.endpoint";

    @Override
    public Set<String> provides() {
        return Set.of("edc:webservice") ;
    }

    @Override
    public void initialize(ServiceExtensionContext context) {
        var webService = context.getService(WebService.class);
        var endpoint=context.getSetting(ENDPOINT_SETTING,"http://localhost:2121/hub/query");
        webService.registerController(new SparqlController(context.getMonitor(),endpoint));
    }
}

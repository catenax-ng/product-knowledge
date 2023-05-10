//
// EDC JWT Auth Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package org.eclipse.tractusx.edc.auth;

import org.eclipse.edc.api.auth.spi.AuthenticationService;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

public class CompositeAuthenticationService implements AuthenticationService {

    protected final Collection<AuthenticationService> subServices=new ArrayList<>();

    public CompositeAuthenticationService() {
    }

    @Override
    public boolean isAuthenticated(Map<String, List<String>> map) {
        return subServices.stream().noneMatch(service-> !service.isAuthenticated(map));
    }

    public static class Builder {
        CompositeAuthenticationService service;

        public Builder() {
            service=new CompositeAuthenticationService();
        }

        public Builder addService(AuthenticationService subService) {
            service.subServices.add(subService);
            return this;
        }

        public CompositeAuthenticationService build() {
            return service;
        }

    }
}
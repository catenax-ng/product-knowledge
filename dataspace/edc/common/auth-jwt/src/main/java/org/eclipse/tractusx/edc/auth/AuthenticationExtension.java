//
// EDC JWT Auth Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package org.eclipse.tractusx.edc.auth;

import org.eclipse.edc.api.auth.spi.AuthenticationRequestFilter;
import org.eclipse.edc.api.auth.spi.AuthenticationService;
import org.eclipse.edc.runtime.metamodel.annotation.Extension;
import org.eclipse.edc.runtime.metamodel.annotation.Inject;
import org.eclipse.edc.runtime.metamodel.annotation.Provides;
import org.eclipse.edc.runtime.metamodel.annotation.Setting;
import org.eclipse.edc.spi.system.ServiceExtension;
import org.eclipse.edc.spi.system.ServiceExtensionContext;
import org.eclipse.edc.spi.system.configuration.Config;
import org.eclipse.edc.spi.types.TypeManager;
import org.eclipse.edc.web.spi.WebService;

/**
 * Service extension that introduces the configurable composite authentication service
 * including JWT authentication as well as its registration via authentication filters
 */
@Provides(AuthenticationService.class)
@Extension(value = "Extended authentication")
public class AuthenticationExtension implements ServiceExtension {

    @Setting(
            value = "Defines a set/list of authentication services."
    )
    public static String AUTH_SETTING="tractusx.auth";

    @Setting(
            value = "Whether the auth service should be registered.",
            defaultValue = "false",
            type="boolean"
    )
    public static String REGISTER_SETTING="register";

    @Setting(
            value = "The type of authentication service to use. Maybe jwt or composite"
    )
    public static String TYPE_SETTING="type";

    @Setting(
            value = "On which paths should the corresponding filter be installed."
    )
    public static String PATH_SETTING="paths";

    @Setting(
            value = "The BASE64 encoded public key or a url where to obtain it."
    )
    public static String KEY_SETTING="publickey";

    @Setting(
            value = "URL indicating where to get the public key for verifying the token.",
            defaultValue = "true",
            type="boolean"
    )
    public static String EXPIRE_SETTING="checkexpiry";

    @Setting(
            value = "embedded authentication services."
    )
    public static String SERVICE_SETTING="service";

    /**
     * dependency injection part
     */
    @Inject
    protected WebService webService;
    @Inject
    protected TypeManager typeManager;

    @Override
    public void initialize(ServiceExtensionContext ctx) {
        ctx.getConfig(AUTH_SETTING).partition().forEach( authenticationServiceConfig ->
                createAuthenticationService(ctx,authenticationServiceConfig));
    }

    public AuthenticationService createAuthenticationService(ServiceExtensionContext ctx, Config authenticationServiceConfig) {
        String type=authenticationServiceConfig.getString(TYPE_SETTING);
        AuthenticationService newService=null;
        if("jwt".equals(type)) {
            CompositeJwsVerifier.Builder jwsVerifierBuilder = new CompositeJwsVerifier.Builder(typeManager.getMapper());
            String key = authenticationServiceConfig.getString(KEY_SETTING);
            if (key != null) {
                jwsVerifierBuilder.addKey(key);
            }
            newService = new JwtAuthenticationService.Builder().
                    setVerifier(jwsVerifierBuilder.build()).
                    setCheckExpiry(authenticationServiceConfig.getBoolean(EXPIRE_SETTING, true)).
                    build();
        } else if("composite".equals(type)) {
            CompositeAuthenticationService.Builder builder=new CompositeAuthenticationService.Builder();
            authenticationServiceConfig.getConfig(SERVICE_SETTING).partition().forEach( subServiceConfig ->
                    builder.addService(createAuthenticationService(ctx, subServiceConfig))
            );
            newService=builder.build();
        }
        if(newService!=null) {
            String[] paths = authenticationServiceConfig.getString(PATH_SETTING, "").split(",");
            for (String path : paths) {
                webService.registerResource(path, new AuthenticationRequestFilter(newService));
            }
            if (authenticationServiceConfig.getBoolean(REGISTER_SETTING, false)) {
                ctx.registerService(AuthenticationService.class, newService);
            }
        }
        return newService;
    }

}

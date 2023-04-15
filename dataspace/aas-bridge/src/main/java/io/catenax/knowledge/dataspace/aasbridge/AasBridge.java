//
// Knowledge Agent AAS Bridge
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.aasbridge;

import de.fraunhofer.iosb.ilt.faaast.service.Service;
import de.fraunhofer.iosb.ilt.faaast.service.assetconnection.AssetConnectionException;
import de.fraunhofer.iosb.ilt.faaast.service.config.CoreConfig;
import de.fraunhofer.iosb.ilt.faaast.service.config.ServiceConfig;
import de.fraunhofer.iosb.ilt.faaast.service.endpoint.http.HttpEndpointConfig;
import de.fraunhofer.iosb.ilt.faaast.service.exception.ConfigurationException;
import de.fraunhofer.iosb.ilt.faaast.service.exception.EndpointException;
import de.fraunhofer.iosb.ilt.faaast.service.exception.MessageBusException;
import de.fraunhofer.iosb.ilt.faaast.service.messagebus.internal.MessageBusInternalConfig;
import de.fraunhofer.iosb.ilt.faaast.service.persistence.memory.PersistenceInMemoryConfig;
import io.adminshell.aas.v3.model.AssetAdministrationShell;
import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import io.adminshell.aas.v3.model.Identifier;
import io.adminshell.aas.v3.model.impl.DefaultAssetAdministrationShellEnvironment;
import io.catenax.knowledge.dataspace.aasbridge.aspects.MaterialForRecyclingMapper;
import io.catenax.knowledge.dataspace.aasbridge.aspects.PartAsPlannedMapper;
import io.catenax.knowledge.dataspace.aasbridge.aspects.PartSiteInformationAsPlannedMapper;
import io.catenax.knowledge.dataspace.aasbridge.aspects.SingleLevelBomAsPlannedMapper;
import io.openmanufacturing.sds.aspectmodel.urn.AspectModelUrn;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * Main Entry Point/Submodel Server
 */
public class AasBridge {

    private Set<AspectMapper> mappers;
    private HttpClient client=HttpClient.newBuilder().executor(Executors.newFixedThreadPool(5)).build();

    private final Map<AspectModelUrn, Class<? extends AspectMapper>> implMap =
            Map.of(
                    AspectModelUrn.fromUrn("urn:bamm:io.catenax.material_for_recycling:1.1.0#MaterialForRecycling"),
                    MaterialForRecyclingMapper.class,
                    AspectModelUrn.fromUrn("urn:bamm:io.catenax.part_as_planned:1.0.0#PartAsPlanned"),
                    PartAsPlannedMapper.class,
                    AspectModelUrn.fromUrn("urn:bamm:io.catenax.single_level_bom_as_planned:1.0.1#SingleLevelBomAsPlanned"),
                    SingleLevelBomAsPlannedMapper.class,
                    AspectModelUrn.fromUrn("urn:bamm:io.catenax.part_site_information_as_planned:1.0.0#PartSiteInformationAsPlanned"),
                    PartSiteInformationAsPlannedMapper.class
            );


    public static void main(String[] args) throws ConfigurationException, AssetConnectionException, MessageBusException, EndpointException, UnsupportedEncodingException {

        AasBridge aasBridge = new AasBridge(
                System.getProperty("PROVIDER_SPARQL_ENDPOINT",System.getenv("PROVIDER_SPARQL_ENDPOINT")) +
                        "?OemProviderAgent=" +
                        URLEncoder.encode(System.getProperty("PROVIDER_AGENT_PLANE",System.getenv("PROVIDER_AGENT_PLANE")), StandardCharsets.ISO_8859_1),
                        System.getProperty("PROVIDER_CREDENTIAL_BASIC",System.getenv("PROVIDER_CREDENTIAL_BASIC")),
                        Integer.parseInt(System.getProperty("TIMEOUT_SECONDS",System.getenv().getOrDefault("TIMEOUT_SECONDS","10")))
        );

        Service faaast = new Service(ServiceConfig.builder()
                .core(CoreConfig.builder()
                        .requestHandlerThreadPoolSize(5)
                        .build())
                .persistence(PersistenceInMemoryConfig.builder()
                        .environment(aasBridge.mergeAasEnvs(
                                aasBridge.getMappers().stream().map(AspectMapper::getAasInstances).collect(Collectors.toSet()))).build())
                .endpoint(HttpEndpointConfig.builder().build())
                .messageBus(MessageBusInternalConfig.builder().build())
                .build());

        faaast.start();
    }

    public AasBridge(String endpoint, String credentials, long timeoutSeconds) {
        Class[] parameters = new Class[4];
        parameters[0] = String.class;
        parameters[1] = String.class;
        parameters[2] = HttpClient.class;
        parameters[3] = long.class;

        this.mappers = implMap.values().stream().map(aClass -> {
            try {
                return aClass.getDeclaredConstructor(parameters).newInstance(endpoint, credentials, client, timeoutSeconds);
            } catch (NoSuchMethodException | InstantiationException | IllegalAccessException |
                     InvocationTargetException e) {
                throw new RuntimeException(e);
            }
        }).collect(Collectors.toSet());
    }


    private Class<? extends AspectMapper> resolve(AspectModelUrn urn) {
        return this.implMap.get(urn);
    }

    private AssetAdministrationShellEnvironment mergeAasEnvs(Set<AssetAdministrationShellEnvironment> aasEnvs) {
        return aasEnvs.stream().reduce((env1, env2) -> {

                    Map<Identifier, List<AssetAdministrationShell>> groups = Stream.concat(env1.getAssetAdministrationShells().stream(), env2.getAssetAdministrationShells().stream())
                            .collect(Collectors.groupingBy(AssetAdministrationShell::getIdentification));

                    return new DefaultAssetAdministrationShellEnvironment.Builder()
                            .assetAdministrationShells(
                                    groups.values()
                                            .stream()
                                            .map(assetAdministrationShells -> assetAdministrationShells
                                                    .stream()
                                                    .reduce((aas1, aas2) ->
                                                    {
                                                        aas1.setSubmodels(
                                                                Stream.concat(aas1.getSubmodels().stream(), aas2.getSubmodels().stream()).collect(Collectors.toList()));
                                                        return aas1;
                                                    }))
                                            .filter(Optional::isPresent)
                                            .map(Optional::get)
                                            .collect(Collectors.toList()))
                            .submodels(
                                    Stream.concat(env1.getSubmodels().stream(), env2.getSubmodels().stream())
                                            .distinct().collect(Collectors.toList()))
                            .assets(
                                    Stream.concat(env1.getAssets().stream(), env2.getAssets().stream())
                                            .distinct().collect(Collectors.toList()))
                            .conceptDescriptions(
                                    Stream.concat(env1.getConceptDescriptions().stream(), env2.getConceptDescriptions().stream())
                                            .distinct().collect(Collectors.toList()))
                            .build();
                }
        ).orElseThrow(() -> new RuntimeException("No merged AasEnvironment found!"));
    }

    public Set<AspectMapper> getMappers() {
        return this.mappers;
    }


}

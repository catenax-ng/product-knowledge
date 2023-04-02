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
import io.openmanufacturing.sds.aspectmodel.urn.AspectModelUrn;

import java.lang.reflect.InvocationTargetException;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class AasBridge {

    private Set<AspectMapper> mappers;
    private final Map<AspectModelUrn, Class<? extends AspectMapper>> implMap =
            Map.of(
                    AspectModelUrn.fromUrn("urn:bamm:io.catenax.material_for_recycling:1.1.0#MaterialForRecycling"),
                    MaterialForRecyclingMapper.class,
                    AspectModelUrn.fromUrn("urn:bamm:io.catenax.part_as_planned:1.0.0#PartAsPlanned"),
                    PartAsPlannedMapper.class);

    public static void main(String[] args) throws ConfigurationException, AssetConnectionException, MessageBusException, EndpointException {

        // unsafe
        Set<AspectModelUrn> urns = Stream.of(Arrays.copyOfRange(args, 0, args.length-1))
                .map(AspectModelUrn::fromUrn)
                .collect(Collectors.toSet());

        AasBridge aasBridge = new AasBridge(urns, args[args.length-1]);

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

    public AasBridge(Set<AspectModelUrn> urns, String endpoint){

        Class[] parameters = new Class[1];
        parameters[0] = String.class;
        this.mappers = urns.stream().map(urn -> {
            try {
                return resolve(urn).getDeclaredConstructor(parameters).newInstance(endpoint);
            } catch (NoSuchMethodException | InstantiationException | IllegalAccessException | InvocationTargetException e) {
                throw new RuntimeException(e);
            }
        }).collect(Collectors.toSet());
    }


    private Class<? extends AspectMapper> resolve(AspectModelUrn urn){
        return this.implMap.get(urn);
    }

    private AssetAdministrationShellEnvironment mergeAasEnvs(Set<AssetAdministrationShellEnvironment> aasEnvs){
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

    public Set<AspectMapper> getMappers(){
        return this.mappers;
    }





}

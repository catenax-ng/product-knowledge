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
import io.catenax.knowledge.dataspace.aasbridge.aspects.MaterialForRecyclingMapper;
import io.catenax.knowledge.dataspace.aasbridge.aspects.PartAsPlannedMapper;
import io.catenax.knowledge.dataspace.aasbridge.aspects.PartSiteInformationAsPlannedMapper;
import io.catenax.knowledge.dataspace.aasbridge.aspects.SingleLevelBomAsPlannedMapper;
import io.openmanufacturing.sds.aspectmodel.urn.AspectModelUrn;

import java.lang.reflect.InvocationTargetException;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

/**
 * Main Entry Point/Submodel Server
 */
public class AasBridge {

    private final List<AspectMapper> mappers;
    private final HttpClient client = HttpClient.newBuilder().executor(Executors.newFixedThreadPool(5)).build();





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


    public static void main(String[] args) throws ConfigurationException, AssetConnectionException, MessageBusException, EndpointException, NumberFormatException {

        AasBridge aasBridge = new AasBridge(
                System.getProperty("PROVIDER_SPARQL_ENDPOINT", System.getenv("PROVIDER_SPARQL_ENDPOINT")) +
                        "?OemProviderAgent=" +
                        URLEncoder.encode(System.getProperty("PROVIDER_AGENT_PLANE", System.getenv("PROVIDER_AGENT_PLANE")), StandardCharsets.ISO_8859_1),
                System.getProperty("PROVIDER_CREDENTIAL_BASIC", System.getenv("PROVIDER_CREDENTIAL_BASIC")),
                Integer.parseInt(System.getProperty("TIMEOUT_SECONDS", System.getenv().getOrDefault("TIMEOUT_SECONDS", "10")))
        );

        Service faaast = new Service(ServiceConfig.builder()
                .core(CoreConfig.builder()
                        .requestHandlerThreadPoolSize(5)
                        .build())
                .persistence(PersistenceInMemoryConfig.builder()
                        .initialModel(AasUtils.mergeAasEnvs(
                                aasBridge.getMappers().stream().map(AspectMapper::getAasInstances).collect(Collectors.toList()))).build())
                .endpoint(HttpEndpointConfig.builder().cors(true).build())
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
        }).collect(Collectors.toList());
    }


    private Class<? extends AspectMapper> resolve(AspectModelUrn urn) {
        return this.implMap.get(urn);
    }


    public List<AspectMapper> getMappers() {
        return this.mappers;
    }


}

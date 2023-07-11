package io.catenax.knowledge.dataspace.aasbridge;

import io.adminshell.aas.v3.model.AssetAdministrationShell;
import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import io.adminshell.aas.v3.model.impl.DefaultAssetAdministrationShellEnvironment;
import org.eclipse.digitaltwin.aas4j.mapping.MappingSpecificationParser;
import org.eclipse.digitaltwin.aas4j.mapping.model.MappingSpecification;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

public class AasUtils {

    public static List<MappingConfiguration> loadConfigsFromResources() {
        try {
            return Files.walk(Path.of(System.getProperty("user.dir") + "/src/main/resources/paramSelectQueries"))
                    .filter(obj -> !obj.endsWith("paramSelectQueries"))
                    .map(getOnePath -> {
                        String nameInclSelect = getOnePath.getFileName().toString();
                        String mappingFileFolder = getOnePath.getParent().getParent().toString() + "/mappingSpecifications/";
                        String mappingFileName = nameInclSelect.split("-")[0] + "-mapping.json";
                        MappingSpecification spec =
                                null;
                        try {
                            spec = new MappingSpecificationParser().loadMappingSpecification(mappingFileFolder + mappingFileName);
                        } catch (IOException e) {
                            throw new RuntimeException(e);
                        }
                        String getAllPath = getOnePath.getParent().getParent().toString() + "/selectQueries/"+nameInclSelect;
                        return new MappingConfiguration(
                                spec,
                                new File(getOnePath.toString()),
                                new File(getAllPath),
                                spec.getHeader().getNamespaces().get("semanticId")
                        );
                    })
                    .collect(Collectors.toList());

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static AssetAdministrationShellEnvironment mergeAasEnvs(List<AssetAdministrationShellEnvironment> aasEnvs) {
        Set<AssetAdministrationShell> collect = aasEnvs.stream().flatMap(env -> env.getAssetAdministrationShells().stream()).collect(Collectors.toSet());
        Map<String, List<AssetAdministrationShell>> collect1 = collect.stream().collect(Collectors.groupingBy(aas -> aas.getAssetInformation().getGlobalAssetId().getKeys().get(0).getValue()));
        List<AssetAdministrationShell> mergedShells = collect1.values().stream().map(group ->
                group.stream().reduce((aas1, aas2) -> {
                    aas1.getSubmodels().addAll(aas2.getSubmodels());
                    return aas1;
                }).get()).collect(Collectors.toList());

        return new DefaultAssetAdministrationShellEnvironment.Builder()
                .assetAdministrationShells(mergedShells)
                .submodels(aasEnvs.stream().flatMap(env -> env.getSubmodels().stream()).collect(Collectors.toList()))
                .conceptDescriptions(aasEnvs.stream().flatMap(env -> env.getConceptDescriptions().stream()).collect(Collectors.toList()))
                .build();
    }
}

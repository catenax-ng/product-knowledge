package io.catenax.knowledge.dataspace.aasbridge;

import io.adminshell.aas.v3.model.AssetAdministrationShell;
import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import io.adminshell.aas.v3.model.impl.DefaultAssetAdministrationShellEnvironment;
import org.eclipse.digitaltwin.aas4j.mapping.MappingSpecificationParser;
import org.eclipse.digitaltwin.aas4j.mapping.model.MappingSpecification;
import org.reflections.Reflections;
import org.reflections.scanners.ResourcesScanner;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class AasUtils {

    public static List<MappingConfiguration> loadConfigsFromResources() {

        Reflections reflections = new Reflections(new ResourcesScanner());
        Set<String> files = reflections.getResources(Pattern.compile(".*paramSelectQueries\\.rq"));
        return files.stream()
                    .filter(obj -> !obj.endsWith("paramSelectQueries"))
                .map(Path::of)
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


    }

    public static AssetAdministrationShellEnvironment mergeAasEnvs(Set<AssetAdministrationShellEnvironment> aasEnvs) {
        Set<AssetAdministrationShell> collect = aasEnvs.stream()
                .flatMap(env -> env.getAssetAdministrationShells().stream())
                .collect(Collectors.toSet());
        Map<String, List<AssetAdministrationShell>> collect1 = collect.stream()
                .collect(Collectors.groupingBy(aas ->
                        // TODO: if gaid not available, match for any said-k-v-pair
                        aas.getAssetInformation().getGlobalAssetId().getKeys().get(0).getValue()));
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

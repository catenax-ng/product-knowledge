package io.catenax.knowledge.dataspace.aasbridge;

import io.adminshell.aas.v3.dataformat.DeserializationException;
import io.adminshell.aas.v3.dataformat.SerializationException;
import io.adminshell.aas.v3.dataformat.json.JsonDeserializer;
import io.adminshell.aas.v3.dataformat.json.JsonSerializer;
import io.adminshell.aas.v3.model.*;
import io.adminshell.aas.v3.model.impl.DefaultAssetAdministrationShellEnvironment;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

public class AasUtils {

    public static AssetAdministrationShellEnvironment mergeAasEnvs(List<AssetAdministrationShellEnvironment> aasEnvs){
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
    public static <T extends Referable> T cloneReferable(T original, Class<T> clazz) {
        JsonSerializer jsonSerializer = new JsonSerializer();
        JsonDeserializer jsonDeserializer = new JsonDeserializer();

        try {
            return jsonDeserializer.readReferable(jsonSerializer.write((Referable) original), clazz);
        } catch (DeserializationException | SerializationException e) {
            throw new RuntimeException(e);
        }
    }

    public static AssetAdministrationShellEnvironment cloneAasEnv(AssetAdministrationShellEnvironment original){
        JsonSerializer jsonSerializer = new JsonSerializer();
        JsonDeserializer jsonDeserializer = new JsonDeserializer();

        try {
            return jsonDeserializer.read(jsonSerializer.write(original));
        } catch (DeserializationException | SerializationException e) {
            throw new RuntimeException(e);
        }
    }

    public static Submodel getSubmodelFromAasenv(AssetAdministrationShellEnvironment aasenv, String submodelSemanticId) {
        return aasenv.getSubmodels().stream()
                .filter(sub -> sub.getSemanticId().getKeys().stream()
                        .anyMatch(key -> key.getValue().equals(submodelSemanticId))
                )
                .findFirst().orElseThrow(() -> new RuntimeException("Desired Submodel " + submodelSemanticId + " not found in Template"));
    }

    public static SubmodelElementCollection getSmecFromSubmodel(Submodel sm, String smecIdShort) {
        return sm.getSubmodelElements().stream()
                .filter(sme -> sme.getIdShort().equals(smecIdShort)).map(comp -> (SubmodelElementCollection) comp)
                .findFirst().orElseThrow(() -> new RuntimeException("Desired path of smec entry(" + smecIdShort + ") not found"));
    }

    public static SubmodelElement getChildFromParentSmec(SubmodelElementCollection parent, String childIdShort) {
        return parent.getValues().stream().filter(sme -> sme.getIdShort().equals(childIdShort))
                //.map(sme -> (SubmodelElementCollection) sme)
                .findFirst().orElseThrow(() -> new RuntimeException("Desired path of smel entry(" + childIdShort + ") not found"));
    }

    public static  <T extends Identifiable> List<T> join(List<T> left, List<T> right) {
        List<String> rightIds = right.stream().map(leftCd -> leftCd.getIdentification().getIdentifier()).collect(Collectors.toList());
        right.addAll(left.stream()
                .filter(l -> rightIds.stream().noneMatch(rightId -> l.getIdentification().getIdentifier().equals(rightId)))
                .collect(Collectors.toList()));
        return right;
    }



}

package io.catenax.knowledge.dataspace.aasbridge;

import io.adminshell.aas.v3.dataformat.DeserializationException;
import io.adminshell.aas.v3.dataformat.xml.XmlDeserializer;
import io.adminshell.aas.v3.model.AssetAdministrationShellEnvironment;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)

class AasUtilsTest {

    XmlDeserializer deser = new XmlDeserializer();
    List<AssetAdministrationShellEnvironment> envs;

    AssetAdministrationShellEnvironment merged;

    @BeforeAll
    void instantiate() throws IOException, DeserializationException {

        envs = Arrays.asList(deser.read(fromResource("PartAsPlanned.xml")),
                deser.read(fromResource("PartSiteInformation.xml")),
                deser.read(fromResource("SingleLevelBomAsPlanned.xml")),
                deser.read(fromResource("MaterialForRecycling.xml")));

        merged = AasUtils.mergeAasEnvs(envs);
    }

    @Test
    void noDupeSubmodelIds(){
        List<String> smIds = envs.stream().flatMap(env -> env.getSubmodels().stream().map(sm -> sm.getIdentification().getIdentifier())).collect(Collectors.toList());
        List<String> distinctSmIds = smIds.stream().distinct().collect(Collectors.toList());
        assertEquals(smIds, distinctSmIds);
    }

    @Test
    void mergePreservesSubmodelIds(){
        Set<String> smIds = envs.stream().flatMap(env -> env.getSubmodels().stream().map(sm -> sm.getIdentification().getIdentifier())).collect(Collectors.toSet());
        Set<String> mergedSmIds = merged.getSubmodels().stream().map(sm -> sm.getIdentification().getIdentifier()).collect(Collectors.toSet());

        assertEquals(smIds.size(),mergedSmIds.size());
        assertEquals(smIds,mergedSmIds);
    }

    @Test
    void mergePreservesSubmodelIdsInReferences(){
        Set<String> smIds = envs.stream().flatMap(env -> env.getSubmodels().stream().map(sm -> sm.getIdentification().getIdentifier())).collect(Collectors.toSet());
        Set<String> referenceIds = merged.getAssetAdministrationShells().stream()
                .flatMap(aas -> aas.getSubmodels().stream().map(sm -> sm.getKeys().get(0).getValue())).collect(Collectors.toSet());

        assertEquals(smIds.size(),referenceIds.size());
        assertEquals(smIds,referenceIds);
    }
    @Test
    void mergeDoesNotEqualizeSubmodelIds() {

        // All SubmodelReferences in an AAS hold different targets
        merged.getAssetAdministrationShells().stream().forEach(aas->
        {
            List<String> referredSubmodelIds = aas.getSubmodels().stream().map(sm ->
                    sm.getKeys().get(0).getValue()).collect(Collectors.toList());
            List<String> distinctReferredSubmodelIds = referredSubmodelIds.stream().distinct().collect(Collectors.toList());
            assertEquals(referredSubmodelIds,distinctReferredSubmodelIds);
        });
    }

    @Test
    void mergeReducesAasNumber(){
        merged.getAssetAdministrationShells().size();
        assertTrue(merged.getAssetAdministrationShells().size()<=envs.stream().mapToLong(env->env.getAssetAdministrationShells().size()).sum());
    }

    String fromResource(String name) throws IOException {
        return new String(getClass().getClassLoader()
                .getResourceAsStream("exampleAasEnvs/"+name)
                .readAllBytes());
    }
}
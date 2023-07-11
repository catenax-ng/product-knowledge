package io.catenax.knowledge.dataspace.aasbridge.managers;

import de.fraunhofer.iosb.ilt.faaast.service.model.asset.AssetIdentification;
import de.fraunhofer.iosb.ilt.faaast.service.model.asset.GlobalAssetIdentification;
import de.fraunhofer.iosb.ilt.faaast.service.model.asset.SpecificAssetIdentification;
import io.adminshell.aas.v3.model.*;
import io.catenax.knowledge.dataspace.aasbridge.MappingConfiguration;
import io.catenax.knowledge.dataspace.aasbridge.MappingExecutor;
import io.catenax.knowledge.dataspace.aasbridge.PersistenceInKnowledgeConfig;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class IdentifiableKnowledgeManager {


    private final MappingExecutor executor;

    public IdentifiableKnowledgeManager(PersistenceInKnowledgeConfig config) {
        this.executor = new MappingExecutor(
                config.getProviderSparqlEndpoint(),
                config.getProviderAgentPlane(),
                config.getCredentials(),
                config.getTimeoutSeconds(),
                config.getThreadPoolSize(),
                config.getMappings()
        );
    }

    public Identifiable getIdentifiableById(Identifier identifier, Class<? extends Identifiable> type) {
        if (type.isAssignableFrom(Submodel.class)) {
            String submodelSemanticId = identifier.getIdentifier().split("/")[0];
            MappingConfiguration mapping = executor.getMappings().stream()
                    .filter(m -> m.getSemanticId().equals(submodelSemanticId))
                    .findFirst().orElseThrow();
            String parametrized = parametrizeQuery(mapping.getGetOneQueryTemplate(), identifier.getIdentifier().split("/")[1]);
            return executor.executeMapping(parametrized, mapping.getMappingSpecification())
                    .getSubmodels()
                    .get(0); //should only be one
            // maybe separate by cd, sm, aas later
        } else if (type.isAssignableFrom(AssetAdministrationShell.class)) {

            // check for existence of submodels
            // create new AAS maybe (maybe even here)
        } else if (type.isAssignableFrom(ConceptDescription.class)) {
            // execute all conceptDescriptionMappings on startup
            // keep in memory, never update, just query
        } else {
            throw new RuntimeException(String.format("Identifiable %s is neither AAS, Submodel or CD", identifier.getIdentifier()));
        }

        return null;
    }

    private String parametrizeQuery(File queryTemplate, String parameter) {
        try {
            return String.format(Files.readString(queryTemplate.toPath()), parameter);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public List<AssetAdministrationShell> getAASs(String idShort, List<AssetIdentification> assetIds) {
        // idShort will be disregarded since determined at mapping-time
        // will always just look at the assetId, write query looking for any catena-X ID
        Set<String> candidateIds = assetIds.stream().map(id -> {
                    if (id.getClass().isAssignableFrom(GlobalAssetIdentification.class)) {
                        GlobalAssetIdentification gaid = (GlobalAssetIdentification) id;
                        return gaid.getReference().getKeys().get(0).getValue();
                    } else if (id.getClass().isAssignableFrom(SpecificAssetIdentification.class)) {
                        SpecificAssetIdentification said = (SpecificAssetIdentification) id;
                        return said.getValue();
                    } else {
                        throw new IllegalArgumentException("can't fetch AAS since id is neither global nor specific");
                    }
                })
                .collect(Collectors.toSet());

        // check for existence of submodels
        // create new AAS maybe (maybe even here)

        return null;
    }

    public List<Submodel> getSubmodels(String idShort, Reference semanticId) {
        if (semanticId == null) {
            return executor.executeGetAllMappings().getSubmodels();
        } else {

            MappingConfiguration mappingConfiguration = executor.getMappings().stream()
                    .filter(m -> m.getSemanticId().equals(semanticId.getKeys().get(0).getValue()))
                    .findFirst().orElseThrow();
            try {
                String query = Files.readString(mappingConfiguration.getGetAllQuery().toPath());
                return executor.executeMapping(query, mappingConfiguration.getMappingSpecification())
                        .getSubmodels();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            // maybe remove the conceptdescriptions and aas-part from mappings

        }
    }
}

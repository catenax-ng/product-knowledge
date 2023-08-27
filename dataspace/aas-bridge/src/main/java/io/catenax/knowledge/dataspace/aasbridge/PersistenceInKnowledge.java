package io.catenax.knowledge.dataspace.aasbridge;

import de.fraunhofer.iosb.ilt.faaast.service.ServiceContext;
import de.fraunhofer.iosb.ilt.faaast.service.config.CoreConfig;
import de.fraunhofer.iosb.ilt.faaast.service.exception.ConfigurationInitializationException;
import de.fraunhofer.iosb.ilt.faaast.service.exception.ResourceNotFoundException;
import de.fraunhofer.iosb.ilt.faaast.service.model.aasx.AASXPackage;
import de.fraunhofer.iosb.ilt.faaast.service.model.aasx.PackageDescription;
import de.fraunhofer.iosb.ilt.faaast.service.model.api.modifier.QueryModifier;
import de.fraunhofer.iosb.ilt.faaast.service.model.api.operation.OperationHandle;
import de.fraunhofer.iosb.ilt.faaast.service.model.api.operation.OperationResult;
import de.fraunhofer.iosb.ilt.faaast.service.model.asset.AssetIdentification;
import de.fraunhofer.iosb.ilt.faaast.service.persistence.Persistence;
import de.fraunhofer.iosb.ilt.faaast.service.persistence.util.QueryModifierHelper;
import de.fraunhofer.iosb.ilt.faaast.service.typing.TypeInfo;
import de.fraunhofer.iosb.ilt.faaast.service.util.Ensure;
import io.adminshell.aas.v3.model.*;
import io.adminshell.aas.v3.model.impl.DefaultAssetAdministrationShellEnvironment;

import java.util.List;
import java.util.Set;

public class PersistenceInKnowledge implements Persistence<PersistenceInKnowledgeConfig> {

    private static final String MSG_MODIFIER_NOT_NULL = "The message modifier cannot be null";
    PersistenceInKnowledgeConfig persistenceConfig;
    CoreConfig coreConfig;
    ServiceContext serviceContext;
    AssetAdministrationShellEnvironment model;
    MappingExecutor executor;

    public PersistenceInKnowledge() {
    }

    @Override
    public void init(CoreConfig coreConfig, PersistenceInKnowledgeConfig persistenceInKnowledgeConfig, ServiceContext serviceContext) throws ConfigurationInitializationException {
        Ensure.requireNonNull(coreConfig, "coreConfig must be non-null");
        Ensure.requireNonNull(persistenceInKnowledgeConfig, "config must be non-null");
        Ensure.requireNonNull(serviceContext, "context must be non-null");
        this.persistenceConfig = persistenceInKnowledgeConfig;
        this.coreConfig = coreConfig;
        this.serviceContext = serviceContext;
        this.executor = new MappingExecutor(
                persistenceConfig.getProviderSparqlEndpoint(),
                persistenceConfig.getCredentials(),
                persistenceConfig.getTimeoutSeconds(),
                persistenceConfig.getThreadPoolSize(),
                persistenceConfig.getMappings());
        this.model = new DefaultAssetAdministrationShellEnvironment.Builder().build();
    }

    @Override
    public <T extends Identifiable> T get(Identifier id, QueryModifier modifier, Class<T> type) throws ResourceNotFoundException {
        Ensure.requireNonNull(id, "id must be non-null");
        Ensure.requireNonNull(modifier, MSG_MODIFIER_NOT_NULL);
        Ensure.requireNonNull(type, "type must be non-null");
        Identifiable result = executor.queryIdentifiableById(id, type);
        if (result == null) {
            throw new ResourceNotFoundException(id, type);
        }
        if (!type.isAssignableFrom(result.getClass())) {
            throw new ResourceNotFoundException(String.format("Resource found but does not match expected type (id: %s, expected type: %s, actual type: %s)",
                    id,
                    type,
                    result.getClass()));
        }
        return QueryModifierHelper.applyQueryModifier(
                type.cast(result),
                modifier);
    }

    @Override
    public SubmodelElement get(Reference reference, QueryModifier queryModifier) throws ResourceNotFoundException {
        throw new UnsupportedOperationException();
    }

    @Override
    public List<AssetAdministrationShell> get(String idShort, List<AssetIdentification> assetIds, QueryModifier modifier) {
        Ensure.requireNonNull(modifier, MSG_MODIFIER_NOT_NULL);
        try {
            return QueryModifierHelper.applyQueryModifier(executor.queryAllShells(idShort, assetIds), modifier);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Submodel> get(String idShort, Reference semanticId, QueryModifier modifier) {
        Ensure.requireNonNull(modifier, MSG_MODIFIER_NOT_NULL);
        return QueryModifierHelper.applyQueryModifier(executor.queryAllSubmodels(idShort, semanticId), modifier);
    }

    @Override
    public List<SubmodelElement> getSubmodelElements(Reference reference, Reference reference1, QueryModifier queryModifier) throws ResourceNotFoundException {
        throw new UnsupportedOperationException();
    }

    @Override
    public List<ConceptDescription> get(String s, Reference reference, Reference reference1, QueryModifier queryModifier) {
        throw new UnsupportedOperationException();
    }

    @Override
    public AASXPackage get(String s) {
        throw new UnsupportedOperationException();
    }

    @Override
    public AssetAdministrationShellEnvironment getEnvironment() {
        return model;
    }

    @Override
    public <T extends Identifiable> T put(T t) {
        throw new UnsupportedOperationException();
    }

    @Override
    public SubmodelElement put(Reference reference, Reference reference1, SubmodelElement submodelElement) throws ResourceNotFoundException {
        throw new UnsupportedOperationException();
    }

    @Override
    public AASXPackage put(String s, Set<Identifier> set, AASXPackage aasxPackage, String s1) {
        throw new UnsupportedOperationException();
    }

    @Override
    public void remove(Identifier identifier) throws ResourceNotFoundException {
        throw new UnsupportedOperationException();
    }

    @Override
    public void remove(Reference reference) throws ResourceNotFoundException {
        throw new UnsupportedOperationException();

    }

    @Override
    public void remove(String s) {
        throw new UnsupportedOperationException();

    }

    @Override
    public List<PackageDescription> get(Identifier identifier) {
        throw new UnsupportedOperationException();
    }

    @Override
    public String put(Set<Identifier> set, AASXPackage aasxPackage, String s) {
        throw new UnsupportedOperationException();
    }

    @Override
    public OperationResult getOperationResult(String s) {
        throw new UnsupportedOperationException();
    }

    @Override
    public OperationHandle putOperationContext(String s, String s1, OperationResult operationResult) {
        throw new UnsupportedOperationException();
    }

    @Override
    public TypeInfo<?> getTypeInfo(Reference reference) {
        throw new UnsupportedOperationException();
    }

    @Override
    public OperationVariable[] getOperationOutputVariables(Reference reference) {
        throw new UnsupportedOperationException();
    }

    @Override
    public PersistenceInKnowledgeConfig asConfig() {
        return persistenceConfig;
    }
    
}

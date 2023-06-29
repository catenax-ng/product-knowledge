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
import de.fraunhofer.iosb.ilt.faaast.service.persistence.manager.IdentifiablePersistenceManager;
import de.fraunhofer.iosb.ilt.faaast.service.persistence.manager.PackagePersistenceManager;
import de.fraunhofer.iosb.ilt.faaast.service.persistence.manager.ReferablePersistenceManager;
import de.fraunhofer.iosb.ilt.faaast.service.persistence.util.QueryModifierHelper;
import de.fraunhofer.iosb.ilt.faaast.service.typing.TypeInfo;
import de.fraunhofer.iosb.ilt.faaast.service.util.Ensure;
import io.adminshell.aas.v3.model.*;

import java.util.List;
import java.util.Set;

public class PersistenceInKnowledge implements Persistence<PersistenceInKnowledgeConfig> {

    private static final String MSG_MODIFIER_NOT_NULL = "The message modifier cannot be null";
    PersistenceInKnowledgeConfig persistenceConfig;
    CoreConfig coreConfig;
    ServiceContext serviceContext;
    AssetAdministrationShellEnvironment model;
    MappingExecutor executor;

    IdentifiablePersistenceManager identifiablePersistenceManager;
    ReferablePersistenceManager referablePersistenceManager;
    PackagePersistenceManager packagePersistenceManager;

    public PersistenceInKnowledge() {
        identifiablePersistenceManager = new IdentifiablePersistenceManager();
        referablePersistenceManager = new ReferablePersistenceManager();
        packagePersistenceManager = new PackagePersistenceManager();
    }

    @Override
    public void init(CoreConfig coreConfig, PersistenceInKnowledgeConfig persistenceInKnowledgeConfig, ServiceContext serviceContext) throws ConfigurationInitializationException {
        Ensure.requireNonNull(coreConfig, "coreConfig must be non-null");
        Ensure.requireNonNull(persistenceInKnowledgeConfig, "config must be non-null");
        Ensure.requireNonNull(serviceContext, "context must be non-null");
        this.persistenceConfig = persistenceInKnowledgeConfig;
        this.coreConfig = coreConfig;
        this.serviceContext = serviceContext;
        this.executor = new MappingExecutor(persistenceConfig.getProviderSparqlEndpoint(), persistenceConfig.getProviderAgentPlane(), persistenceConfig.getCredentials(), persistenceConfig.getTimeoutSeconds(), persistenceConfig.getThreadPoolSize(), persistenceConfig.getMappings());
        this.model = executor.executeMappings();
    }

    @Override
    public <T extends Identifiable> T get(Identifier identifier, QueryModifier queryModifier, Class<T> aClass) throws ResourceNotFoundException {
        throw new UnsupportedOperationException();
    }

    @Override
    public SubmodelElement get(Reference reference, QueryModifier queryModifier) throws ResourceNotFoundException {
        throw new UnsupportedOperationException();
    }

    @Override
    public List<AssetAdministrationShell> get(String idShort, List<AssetIdentification> assetIds, QueryModifier modifier) {
        updatePersistenceManagers();
        Ensure.requireNonNull(modifier, MSG_MODIFIER_NOT_NULL);
        return QueryModifierHelper.applyQueryModifier(identifiablePersistenceManager.getAASs(idShort, assetIds), modifier);
    }

    @Override
    public List<Submodel> get(String idShort, Reference semanticId, QueryModifier modifier) {
        updatePersistenceManagers();
        Ensure.requireNonNull(modifier, MSG_MODIFIER_NOT_NULL);
        return QueryModifierHelper.applyQueryModifier(identifiablePersistenceManager.getSubmodels(idShort, semanticId), modifier);
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

    private void updatePersistenceManagers() {
        AssetAdministrationShellEnvironment newEnv = executor.executeMappings();
        identifiablePersistenceManager.setAasEnvironment(newEnv);
        referablePersistenceManager.setAasEnvironment(newEnv);
        packagePersistenceManager.setAasEnvironment(newEnv);
    }
}

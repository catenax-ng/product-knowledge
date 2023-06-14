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
import de.fraunhofer.iosb.ilt.faaast.service.typing.TypeInfo;
import io.adminshell.aas.v3.model.*;

import java.util.List;
import java.util.Set;

public class PersistenceInKnowledge implements Persistence<PersistenceInKnowledgeConfig> {

    @Override
    public <T extends Identifiable> T get(Identifier identifier, QueryModifier queryModifier, Class<T> aClass) throws ResourceNotFoundException {
        return null;
    }

    @Override
    public SubmodelElement get(Reference reference, QueryModifier queryModifier) throws ResourceNotFoundException {
        return null;
    }

    //TODO: Implement, think about semi-persistent identification
    @Override
    public List<AssetAdministrationShell> get(String s, List<AssetIdentification> list, QueryModifier queryModifier) {
        return null;
    }

    // TODO: Implement with KG
    @Override
    public List<Submodel> get(String s, Reference reference, QueryModifier queryModifier) {
        String semanticIdValue = reference.getKeys().get(0).getValue();

        return null;
    }

    @Override
    public List<SubmodelElement> getSubmodelElements(Reference reference, Reference reference1, QueryModifier queryModifier) throws ResourceNotFoundException {
        return null;
    }

    @Override
    public List<ConceptDescription> get(String s, Reference reference, Reference reference1, QueryModifier queryModifier) {
        return null;
    }

    @Override
    public AASXPackage get(String s) {
        return null;
    }

    // TODO: Implement
    @Override
    public AssetAdministrationShellEnvironment getEnvironment() {
        return null;
    }

    @Override
    public <T extends Identifiable> T put(T t) {
        return null;
    }

    @Override
    public SubmodelElement put(Reference reference, Reference reference1, SubmodelElement submodelElement) throws ResourceNotFoundException {
        return null;
    }

    @Override
    public AASXPackage put(String s, Set<Identifier> set, AASXPackage aasxPackage, String s1) {
        return null;
    }

    @Override
    public void remove(Identifier identifier) throws ResourceNotFoundException {

    }

    @Override
    public void remove(Reference reference) throws ResourceNotFoundException {

    }

    @Override
    public void remove(String s) {

    }

    @Override
    public List<PackageDescription> get(Identifier identifier) {
        return null;
    }

    @Override
    public String put(Set<Identifier> set, AASXPackage aasxPackage, String s) {
        return null;
    }

    @Override
    public OperationResult getOperationResult(String s) {
        return null;
    }

    @Override
    public OperationHandle putOperationContext(String s, String s1, OperationResult operationResult) {
        return null;
    }

    @Override
    public TypeInfo<?> getTypeInfo(Reference reference) {
        return null;
    }

    @Override
    public OperationVariable[] getOperationOutputVariables(Reference reference) {
        return new OperationVariable[0];
    }

    @Override
    public void init(CoreConfig coreConfig, PersistenceInKnowledgeConfig persistenceInKnowledgeConfig, ServiceContext serviceContext) throws ConfigurationInitializationException {

    }

    @Override
    public PersistenceInKnowledgeConfig asConfig() {
        return null;
    }
}

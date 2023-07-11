package io.catenax.knowledge.dataspace.aasbridge;

import org.eclipse.digitaltwin.aas4j.mapping.model.MappingSpecification;

import java.io.File;

public class MappingConfiguration {
    private MappingSpecification mappingSpecification;
    private File getOneQueryTemplate;
    private File getAllQuery;
    private String semanticId;

    public MappingConfiguration(MappingSpecification mappingSpecification, File getOneQueryTemplate, File getAllQuery, String semanticId) {
        this.mappingSpecification = mappingSpecification;
        this.getOneQueryTemplate = getOneQueryTemplate;
        this.getAllQuery = getAllQuery;
        this.semanticId = semanticId;
    }


    public MappingSpecification getMappingSpecification() {
        return mappingSpecification;
    }

    public File getGetOneQueryTemplate() {
        return getOneQueryTemplate;
    }

    public File getGetAllQuery() {
        return getAllQuery;
    }

    public String getSemanticId() {
        return semanticId;
    }
}

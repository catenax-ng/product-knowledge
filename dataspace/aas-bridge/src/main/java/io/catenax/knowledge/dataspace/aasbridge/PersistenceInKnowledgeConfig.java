package io.catenax.knowledge.dataspace.aasbridge;

import de.fraunhofer.iosb.ilt.faaast.service.persistence.PersistenceConfig;
import org.eclipse.digitaltwin.aas4j.mapping.model.MappingSpecification;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.util.Map;

public class PersistenceInKnowledgeConfig extends PersistenceConfig<PersistenceInKnowledge> {

    private static final Logger LOGGER = LoggerFactory.getLogger(PersistenceInKnowledgeConfig.class);
    private Map<String,MappingSpecification> mappings;

}

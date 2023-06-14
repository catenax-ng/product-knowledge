package io.catenax.knowledge.dataspace.aasbridge;

import com.sap.dsc.aas.lib.mapping.model.MappingSpecification;
import de.fraunhofer.iosb.ilt.faaast.service.persistence.PersistenceConfig;

import java.io.File;

public class PersistenceInKnowledgeConfig extends PersistenceConfig<PersistenceInKnowledge> {

    private File sparqlQuery;

    private MappingSpecification template;


}

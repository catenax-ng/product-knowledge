//
// Catena-X Ontology Tools
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.tools;

import de.uni_stuttgart.vis.vowl.owl2vowl.model.entities.AbstractEntity;
import de.uni_stuttgart.vis.vowl.owl2vowl.model.entities.nodes.datatypes.DatatypeReference;
import de.uni_stuttgart.vis.vowl.owl2vowl.model.entities.properties.VowlDatatypeProperty;
import de.uni_stuttgart.vis.vowl.owl2vowl.model.entities.properties.VowlObjectProperty;
import org.semanticweb.owlapi.model.IRI;

import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * A modified vowl data model which suppresses redundant
 * object properties which have only a single domain and are
 * expected to have a someValue constraint on the subClass relation anyway.
 */
public class VowlData extends de.uni_stuttgart.vis.vowl.owl2vowl.model.data.VowlData {

    /**
     * flag whether we are still building or exporting
     */
    protected boolean isExport=false;

    /**
     * @return export flag
     */
    public boolean isExport() {
        return isExport;
    }

    /**
     * set
     * @param export flag
     */
    public void setExport(boolean export) {
        isExport = export;
    }

    /** filters entities based on redundancies */
    public boolean filter(Map<IRI, AbstractEntity> entities, AbstractEntity entity) {
        if (entity instanceof VowlObjectProperty && entity.getType().equals("owl:objectProperty")) {
            return ((VowlObjectProperty) entity).getDomains().size() != 1;
        } else if (entity instanceof VowlDatatypeProperty && entity.getType().equals("owl:datatypeProperty")) {
            return ((VowlDatatypeProperty) entity).getDomains().size() != 1;
        } else if (entity instanceof DatatypeReference && entity.getType().equals("rdfs:Datatype")) {
            Set<IRI> allIngoing=((DatatypeReference) entity).getInGoingProperties();
            return allIngoing.size() == 0 ||
                    allIngoing.stream().anyMatch(iri -> filter(entities, entities.get(iri)));
        }
        return true;
    }

    /**
     * filters the entities when in export mode
     * @return map of entities with object properties filtered
     */
    @Override
    public Map<IRI, AbstractEntity> getEntityMap() {
        Map<IRI, AbstractEntity> entities=super.getEntityMap();
        if(isExport) {
            // filter the entities for pure objectProperties with a single domain
            final Map<IRI, AbstractEntity> previousEntities=entities;
            entities=entities.entrySet().stream().filter( entityEntry -> filter(previousEntities,entityEntry.getValue())).collect(Collectors.toMap(Map.Entry::getKey,Map.Entry::getValue));
        }
        return entities;
    }

}

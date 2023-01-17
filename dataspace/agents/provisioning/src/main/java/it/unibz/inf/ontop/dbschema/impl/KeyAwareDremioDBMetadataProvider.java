//
// Extensions to Ontop VKP
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package it.unibz.inf.ontop.dbschema.impl;

import com.google.common.collect.ImmutableList;
import com.google.inject.assistedinject.Assisted;
import com.google.inject.assistedinject.AssistedInject;
import it.unibz.inf.ontop.dbschema.*;
import it.unibz.inf.ontop.exception.MetadataExtractionException;
import it.unibz.inf.ontop.exception.RelationNotFoundInMetadataException;
import it.unibz.inf.ontop.injection.CoreSingletons;
import it.unibz.inf.ontop.injection.OntopModelSettings;
import it.unibz.inf.ontop.model.type.DBTermType;
import it.unibz.inf.ontop.model.type.DBTypeFactory;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * metadata provider which may mimique primary and foreign keys from
 * the config
 */
public class KeyAwareDremioDBMetadataProvider extends DremioDBMetadataProvider {

    protected final OntopModelSettings dremioSettings;
    protected final AdditionalKeyMetadata additionalKeyMetadata;

    @AssistedInject
    public KeyAwareDremioDBMetadataProvider(@Assisted Connection connection, CoreSingletons coreSingletons) throws MetadataExtractionException {
        super(connection,coreSingletons);
        dremioSettings=coreSingletons.getSettings();
        additionalKeyMetadata=new AdditionalKeyMetadata(dremioSettings,rawIdFactory);
    }

    @Override
    public NamedRelationDefinition getRelation(RelationID id0) throws MetadataExtractionException {
        DBTypeFactory dbTypeFactory = dbParameters.getDBTypeFactory();
        RelationID id = getCanonicalRelationId(id0);
        List<QuotedID> pkCols=additionalKeyMetadata.getPrimaryKeys().get(getRelationSchema(id)+"."+getRelationName(id));
        try (ResultSet rs = metadata.getColumns(
                getRelationCatalog(id), // catalog is not escaped
                escapeRelationIdComponentPattern(getRelationSchema(id)),
                escapeRelationIdComponentPattern(getRelationName(id)),
                null)) {
            Map<RelationID, RelationDefinition.AttributeListBuilder> relations = new HashMap<>();

            while (rs.next()) {
                RelationID extractedId = getRelationID(rs, "TABLE_CAT", "TABLE_SCHEM","TABLE_NAME");
                checkSameRelationID(extractedId, id);

                RelationDefinition.AttributeListBuilder builder = relations.computeIfAbsent(extractedId,
                        i -> DatabaseTableDefinition.attributeListBuilder());

                QuotedID attributeId = rawIdFactory.createAttributeID(rs.getString("COLUMN_NAME"));
                // columnNoNulls, columnNullable, columnNullableUnknown
                boolean isNullable = rs.getInt("NULLABLE") != DatabaseMetaData.columnNoNulls;
                if(pkCols!=null) {
                    if(pkCols.contains(attributeId)) {
                        isNullable=false;
                    }
                }
                String typeName = rs.getString("TYPE_NAME");
                int columnSize = rs.getInt("COLUMN_SIZE");
                DBTermType termType = dbTypeFactory.getDBTermType(typeName, columnSize);

                String sqlTypeName = extractSQLTypeName(typeName, rs.getInt("DATA_TYPE"), columnSize,
                        () -> rs.getInt("DECIMAL_DIGITS"));
                builder.addAttribute(attributeId, termType, sqlTypeName, isNullable);
            }

            if (relations.entrySet().size() == 1) {
                Map.Entry<RelationID, RelationDefinition.AttributeListBuilder> r = relations.entrySet().iterator().next();
                return new DatabaseTableDefinition(getAllIDs(r.getKey()), r.getValue());
            }
            throw relations.isEmpty()
                    ? new RelationNotFoundInMetadataException(id, getRelationIDs())
                    : new MetadataExtractionException("Cannot resolve ambiguous relation id: " + id + ": " + relations.keySet());
        }
        catch (SQLException e) {
            throw new MetadataExtractionException(e);
        }
    }

    @Override
    public void insertIntegrityConstraints(NamedRelationDefinition relation, MetadataLookup metadataLookup) throws MetadataExtractionException {
        super.insertIntegrityConstraints(relation, metadataLookup);
        try {
            //patchPrimaryKey(relation);
            patchUniqueAttributes(relation);
            patchForeignKeys(relation, metadataLookup);
        }
        catch (
                SQLException e) {
            throw new MetadataExtractionException(e);
        }
    }

    /*private void patchPrimaryKey(NamedRelationDefinition relation) throws MetadataExtractionException {
        RelationID id = getCanonicalRelationId(relation.getID());
        List<QuotedID> pkCols=additionalKeyMetadata.getPrimaryKeys().get(getRelationSchema(id)+"."+getRelationName(id));
        if(pkCols!=null) {
            UniqueConstraint.Builder builder = UniqueConstraint.primaryKeyBuilder(relation, "PK_"+getRelationName(id));
            try {
                for (QuotedID col : pkCols)
                    builder.addDeterminant(col);
            } catch (AttributeNotFoundException e) {
                throw new MetadataExtractionException(e);
            }
            builder.build();
        }
    }*/

    private void patchUniqueAttributes(NamedRelationDefinition relation) throws MetadataExtractionException, SQLException {
        RelationID id = getCanonicalRelationId(relation.getID());
        Map<String,List<QuotedID>> constraints = additionalKeyMetadata.getUniqueKeys().get(getRelationSchema(id)+"."+getRelationName(id));
        if(constraints!=null) {
            for (Map.Entry<String, List<QuotedID>> constraint : constraints.entrySet()) {
                UniqueConstraint.Builder builder = UniqueConstraint.builder(relation, constraint.getKey());
                try {
                    for (QuotedID attribute : constraint.getValue()) {
                        builder.addDeterminant(attribute);
                    }
                } catch (AttributeNotFoundException e) {
                    throw new MetadataExtractionException(e);
                }
                builder.build();
            }
        }
    }

    private void patchForeignKeys(NamedRelationDefinition relation, MetadataLookup dbMetadata) throws MetadataExtractionException, SQLException {
        RelationID id = getCanonicalRelationId(relation.getID());
        Map<String,List<QuotedID>> foreigns=additionalKeyMetadata.getForeignKeys().get(getRelationSchema(id)+"."+getRelationName(id));
        Map<String,String> targets=additionalKeyMetadata.getForeignKeyTargets().get(getRelationSchema(id)+"."+getRelationName(id));
        Map<String,String> uniques=additionalKeyMetadata.getForeignKeyUniques().get(getRelationSchema(id)+"."+getRelationName(id));
        if(foreigns!=null) {
            for (Map.Entry<String, List<QuotedID>> constraint : foreigns.entrySet()) {
                String refTable=targets.get(constraint.getKey());
                List<QuotedID> pkIdComponents=new ArrayList<>(id.getComponents());
                pkIdComponents.remove(0);
                pkIdComponents.add(0,rawIdFactory.createAttributeID(refTable));
                RelationID pkId= new RelationIDImpl(new ImmutableList.Builder<QuotedID>().addAll(pkIdComponents).build());
                NamedRelationDefinition ref = dbMetadata.getRelation(pkId);
                ForeignKeyConstraint.Builder builder=ForeignKeyConstraint.builder(constraint.getKey(), relation, ref);

                List<QuotedID> atts=constraint.getValue();
                List<QuotedID> uatts=additionalKeyMetadata.getUniqueKeys().get(getRelationSchema(id)+"."+refTable).get(uniques.get(constraint.getKey()));
                try {
                    for(int count=0;count<atts.size();count++) {
                        builder.add(atts.get(count),uatts.get(count));
                    }
                } catch (AttributeNotFoundException e) {
                    throw new MetadataExtractionException(e);
                }
                builder.build();
            }
        }
    }

}

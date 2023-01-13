//
// Extensions to Ontop VKP
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package it.unibz.inf.ontop.dbschema.impl;

import it.unibz.inf.ontop.dbschema.QuotedID;
import it.unibz.inf.ontop.dbschema.QuotedIDFactory;
import it.unibz.inf.ontop.injection.OntopModelSettings;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class AdditionalKeyMetadata {

    protected final Map<String, List<QuotedID>> primaryKeys=new HashMap<>();

    public Map<String, List<QuotedID>> getPrimaryKeys() {
        return primaryKeys;
    }

    public Map<String, Map<String, List<QuotedID>>> getUniqueKeys() {
        return uniqueKeys;
    }

    public Map<String, Map<String, List<QuotedID>>> getForeignKeys() {
        return foreignKeys;
    }

    public Map<String, Map<String, String>> getForeignKeyTargets() {
        return foreignKeyTargets;
    }

    protected final Map<String,Map<String,List<QuotedID>>> uniqueKeys=new HashMap<>();
    protected final Map<String,Map<String,List<QuotedID>>> foreignKeys=new HashMap<>();
    protected final Map<String,Map<String,String>> foreignKeyTargets=new HashMap<>();
    protected final Map<String,Map<String,String>> foreignKeyUniques=new HashMap<>();
    protected final String jdbcDriver;

    public Map<String, Map<String, String>> getForeignKeyUniques() {
        return foreignKeyUniques;
    }

    public AdditionalKeyMetadata(OntopModelSettings settings, QuotedIDFactory idFactory) {
        jdbcDriver=settings.getProperty("jdbc.driver").orElse("");
        Stream<String> schemas=settings.getProperty(jdbcDriver+"-schemas").stream().
                flatMap(prop -> Arrays.stream(prop.split(","))).filter(schema -> !schema.isEmpty());
        schemas.forEach(schema -> {
            Stream<String> tables=settings.getProperty(jdbcDriver+"-tables."+schema).stream().
                    flatMap(prop -> Arrays.stream(prop.split(","))).filter(table -> !table.isEmpty());
            tables.forEach(table -> {
                Stream<QuotedID> columns = settings.getProperty(jdbcDriver+"-primary."+schema+"."+table).stream().
                        flatMap(prop -> Arrays.stream(prop.split(","))).filter(column -> !column.isEmpty()).map(idFactory::createAttributeID);
                List<QuotedID> pkColumns= columns.collect(Collectors.toList());
                if(!pkColumns.isEmpty()) {
                    primaryKeys.put(schema+"."+table,pkColumns);
                }
                Stream<String> constraints = settings.getProperty(jdbcDriver+"-unique."+schema+"."+table).stream().
                        flatMap(prop -> Arrays.stream(prop.split(","))).filter(constraint -> !constraint.isEmpty());
                Map<String,List<QuotedID>> uniques=new HashMap<>();
                constraints.forEach( constraint -> {
                    Stream<QuotedID> constraintColumns = settings.getProperty(jdbcDriver+"-constraint."+constraint).stream().
                            flatMap(prop -> Arrays.stream(prop.split(","))).filter(column -> !column.isEmpty()).map(idFactory::createAttributeID);
                    List<QuotedID> ucColumns = constraintColumns.collect(Collectors.toList());
                    if(!ucColumns.isEmpty()) {
                        uniques.put(constraint,ucColumns);
                    }
                });
                if(!uniques.isEmpty()) {
                    uniqueKeys.put(schema+"."+table,uniques);
                }
                Stream<String> fconstraints = settings.getProperty(jdbcDriver+"-foreign."+schema+"."+table).stream().
                        flatMap(prop -> Arrays.stream(prop.split(","))).filter(constraint -> !constraint.isEmpty());
                Map<String,List<QuotedID>> foreigns=new HashMap<>();
                Map<String,String> targets=new HashMap<>();
                Map<String,String> funiques=new HashMap<>();
                fconstraints.forEach( constraint -> {
                    String def=settings.getProperty(jdbcDriver+"-constraint."+constraint).orElse("");
                    int colonIndex=def.indexOf(":");
                    if(colonIndex>0) {
                        String target = def.substring(colonIndex + 1);
                        def = def.substring(0, colonIndex);
                        int plusIndex=target.indexOf("+");
                        if(plusIndex>0) {
                            String uniqueRef=target.substring(plusIndex+1);
                            target=target.substring(0,plusIndex);
                            Stream<QuotedID> constraintColumns = Arrays.stream(def.split(",")).
                                    flatMap(prop -> Arrays.stream(prop.split(","))).filter(column -> !column.isEmpty()).map(idFactory::createAttributeID);
                            List<QuotedID> fcColumns = constraintColumns.collect(Collectors.toList());
                            if (!fcColumns.isEmpty()) {
                                foreigns.put(constraint, fcColumns);
                                targets.put(constraint, target);
                                funiques.put(constraint,uniqueRef);
                            }
                        }
                    }
                });
                if(!foreigns.isEmpty()) {
                    foreignKeys.put(schema+"."+table,foreigns);
                    foreignKeyTargets.put(schema+"."+table,targets);
                    foreignKeyUniques.put(schema+"."+table,funiques);
                }
            });
        });

    }
}

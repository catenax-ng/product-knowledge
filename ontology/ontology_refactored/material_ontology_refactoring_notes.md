* All matrial classes, manufacturer classes and single objects that do not appear in an object property are implemented as skos:Concept in cx_taxonomy.ttl.
* All restrictions converted to SHACL constraints in material_ontology_constraints.shacl.
* Abstract super classes are deleted.
* Datatype properties for which exact super properties exist such as name, id, number are deleted.
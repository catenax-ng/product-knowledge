# Catena-X Knowledge Agents (Hey Catena!) Ontology Sources

This is the home of the Catena-X Ontology (or CX Ontology)

## Notice

* see copyright notice in the top folder
* see license file in the top folder
* see authors file in the top folder

## What's this?

The CX Ontology is a versioned folder of domain ontology files (and tools to process them)

Each domain ontology file is written in a format named [Turtle (TTL)](https://www.w3.org/TeamSubmission/turtle/).
Following the [Resource Description Framework (RDF)](https://en.wikipedia.org/wiki/Resource_Description_Framework), these files defines 
- semantic concepts (classes of entities/nodes, where a node can have multiple classes)
- properties (attributes of entities using primitive node types) and 
- relations/predicates (which are links between nodes where the source node is called subject and the target node is called the object) 

All definitions in a file should belong to the same namespace (which is the technical key of the domain) and should be using a common nickname (prefix) 
that is also the name of the file.

Domain ontologies can refer to concepts of other domains/prefixes. Relations are usually attributed to the concept/domain which cannot exist without the relation.

## Contents

- [Ontology Tools](tools)
- [Catena-X Common Domain (cx)](common_ontology.ttl)
- [Catena-X Vehicle Domain (cx)](vehicle_ontology.ttl)
- [Catena-X Traceability Domain (cx)](traceability_ontology.ttl)
- [Catena-X (Serialized) Part Domain (cx)](part_ontology.ttl)
- [Catena-X Diagnosis Domain (cx)](diagnosis_ontology.ttl)
- [Catena-X Prognosis Domain (cx)](prognosis_ontology.ttl)





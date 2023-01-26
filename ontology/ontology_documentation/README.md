
# Ontology Architecture
In [Catena-X](https://catena-x.net/) we want to build a federated virtual knowledge graph for the
[automotive industry](https://en.wikipedia.org/wiki/Automotive_industry) in order to enable data access across companies.

## Fundamental Principles
1. Maximise Semantics 
2. Reduce Complexity
3. Minimise Redundancy 

[Semantics](https://en.wikipedia.org/wiki/Semantics) is the **understanding of the meaning** of the data by the data producer and consumer. 
The main goal is to **bridge the semantic gap** between data producers and consumers.
See also [FAIR data](https://en.wikipedia.org/wiki/FAIR_data).
We follow the data-centric architecture, i.e. we start with data first and then comes the applications.

## Semantic Standards
We use the following [semantic web](https://en.wikipedia.org/wiki/Semantic_Web)
[W3C](https://de.wikipedia.org/wiki/World_Wide_Web_Consortium) standards:
* [RDF](https://en.wikipedia.org/wiki/Resource_Description_Framework) /
[RDFS](https://en.wikipedia.org/wiki/RDF_Schema) /
[OWL](https://de.wikipedia.org/wiki/Web_Ontology_Language) for ontology [modelling](https://en.wikipedia.org/wiki/Data_modeling),
* [SKOS](https://en.wikipedia.org/wiki/Simple_Knowledge_Organization_System) for [data dictionary](https://en.wikipedia.org/wiki/Data_dictionary) ([glossary](https://en.wikipedia.org/wiki/Glossary) and [thesaurus](https://en.wikipedia.org/wiki/Thesaurus)),
* [turtle](https://en.wikipedia.org/wiki/Turtle_(syntax)) as [file format](https://en.wikipedia.org/wiki/File_format) in [unicode](https://en.wikipedia.org/wiki/Unicode) for storing ontologies,
* [SPARQL](https://en.wikipedia.org/wiki/SPARQL) for [querying](https://en.wikipedia.org/wiki/Query_language),
* [R2RML](https://www.w3.org/TR/r2rml/) / [RML](https://rml.io/specs/rml/) / OBDA for [data mapping](https://en.wikipedia.org/wiki/Data_mapping) between an ontology and a [database schema](https://en.wikipedia.org/wiki/Database_schema),
* [Ontop](https://ontop-vkg.org/) for [data virtualisation](https://en.wikipedia.org/wiki/Data_virtualization),
* [SHACL](https://en.wikipedia.org/wiki/SHACL) for constraints,
* [URI](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) for identifiers.

# Basic Concepts
### Basic Elements
#### Identifier
In the semantic web (RDF/OWL) every element of an ontology (classes, relations, attributes) or
knowledge graph (individuals) is represented as a [resource](https://en.wikipedia.org/wiki/Web_resource) and has an 
**unique identifier** in form of an [Uniform Resource Identifier (URI)](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier).
An URI is a web address or internet link.

#### Namespace & Prefix
A [namespace](https://en.wikipedia.org/wiki/Namespace) is the **base URL**
for identifiers and are abbreviated by a **prefix**. We use base URI
 * `https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#`

with the prefix **cx** and separator **#**.
The ontology files can be directly accessed from the internet, e.g.
[cx_ontlogy.ttl](https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl) in github.
Furthermore, we use following namespaces for the W3C standards:

| **prefix** | namespace                               |
|------------|-----------------------------------------|
| **owl**    | <http://www.w3.org/2002/07/owl#>        |
| **rdfs**   | <http://www.w3.org/2000/01/rdf-schema#> |
| **skos**   | <http://www.w3.org/2004/02/skos/core#>  |
| **xsd**    | <http://www.w3.org/2001/XMLSchema#>     |

#### Literal
A [literal](https://en.wikipedia.org/wiki/Literal_(computer_programming)) is a
[typed](https://en.wikipedia.org/wiki/Primitive_data_type) **data value**, e.g.
`cx:Person cx:fullName 'Max Mustermann'; cx:hasAge 25`.
In RDF/OWL the data types are based on the
[XML schema](https://en.wikipedia.org/wiki/XML_Schema_(W3C)), e.g. `xsd:string`, `xsd:integer`.

### Ontology
An ontology is a [semantic data model](https://en.wikipedia.org/wiki/Semantic_data_model) that consists of classes,
relations, attributes. It corresponds to a
[logical data model](https://en.wikipedia.org/wiki/Logical_schema) or
[entity-relationship model (ERM)](https://en.wikipedia.org/wiki/Entity%E2%80%93relationship_model) of a
[relational database (RDB)](https://en.wikipedia.org/wiki/Relational_database).

| simple         | **OWL**              | **OOP**     | **UML**     | **RDB** | **ERM**           | CS     |
|----------------|----------------------|-------------|-------------|---------|-------------------|--------|
| **individual** | individual           | instance    | object      | row     | entity            | record |
| **class**      | owl:Class            | class       | class       | table   | entity type       | composite |
| **relation**   | owl:ObjectProrperty  | association | association | key     | relationship type |        |
| **attribute**  | owl:DatatypeProperty | field       | attribute   | column  | attribute type    | field  |

### Ontology Domain
The **scope** of a [domain-specific](https://en.wikipedia.org/wiki/Domain_knowledge)
ontology is called **domain**. This can encompass: field, subject, area, matter, topic,
specialty, discipline, expertise, [subject-matter](https://en.wikipedia.org/wiki/Subject-matter_expert).

### Individual
An individual is an instance or objects of a class, e.g. this car, this laptop.
It represents **individual things** that can be abstract or concrete.

### Class
A class is a set or group of individuals that share common structure and characteristics,
e.g. vehicle, person or process. It represents the **kinds of things**. 
A class can be related a sub-class by [subtyping](https://en.wikipedia.org/wiki/Subtyping),
thereby form a [class-hierarchy](https://en.wikipedia.org/wiki/Taxonomy)
where the properties of the super-class are passed to the sub-class 
by [inheritance](https://en.wikipedia.org/wiki/Inheritance_(object-oriented_programming)).

### Relation
A relation represents how individuals are related to one another.
It is [directed](https://en.wikipedia.org/wiki/Directed_graph) and 
has a [domain](https://en.wikipedia.org/wiki/Domain_of_a_function)
and [range](https://en.wikipedia.org/wiki/Range_of_a_function).
The **domain** is the list of the allowed classes where the relation is pointing **from**.
While the **range** is the list of the allowed classes where the relation is pointing **to**.

### Attribute
An attribute is a **data value** of an individual, e.g. full name of a person.
The domain of an attribute the list of the allowed classes where the attribute can be used.
The range of an attribute is the allowed **data type** of the attribute.

### Triple
A [triple](https://en.wikipedia.org/wiki/Semantic_triple) is a statement consisting 
of **subject**-**predicate**-**object**, e.g. `cx:Vehicle cx:isDrivenBy cx:Driver`.
It is defined by [RDF](https://en.wikipedia.org/wiki/Resource_Description_Framework)
and the basic unit of a [triplestore](https://en.wikipedia.org/wiki/Triplestore).

### Knowledge Graph
A [knowledge graph](https://en.wikipedia.org/wiki/Knowledge_graph) is a
[graph-structured database](https://en.wikipedia.org/wiki/Graph_database)
where knowledge is represented in the ontology and individuals.
There are two types of KGs: RDF ([Neptune](https://en.wikipedia.org/wiki/Amazon_Neptune), RDFox, AnzoGraph)
and LPG ([Neo4j](https://de.wikipedia.org/wiki/Neo4j), [Tinkerpop](https://tinkerpop.apache.org/)). We use RDF.

### Data Mapping
A [data mapping](https://en.wikipedia.org/wiki/Data_mapping) connects the classes, relations and 
attributes of an ontology with [physical data models](https://en.wikipedia.org/wiki/Physical_schema)
of the different data sources (RDB, CSV, JSON) that contain the actual data. It is a vital step for
[integrating the data](https://en.wikipedia.org/wiki/Data_integration)
into the cx ontology.

### Data Virtualization
In [data virtualization](https://en.wikipedia.org/wiki/Data_virtualization) the data is only linked or referenced
and **not** copied into the graph database, while in [materialisation](https://en.wikipedia.org/wiki/Materialized_view)
the data ingested into the graph database.

### Data Federation
A [federated query](https://en.wikipedia.org/wiki/Federated_database_system)
is a sub-query that is distributed to another data sources or SPARQL endpoints
so that it allows the access of heterogeneous data from a single endpoint.

# Ontology Modelling Standards

## Ontology Modelling
Ontology modelling is an **iterative, continuous development** process. It is always subject to potential changes in the
future. Therefore, we always start with a MVP ontology and extend it later on, i.e. an agile working model fits here well.
A semantic model is only useful, when it is used by someone (application integration).

### Ontology Planning
* What is the business problem we want to solve?
* Why do we need to answer this question?  (purpose)
* Who knows, produces, consumes the data? (name the stakeholders)
* Where are the data sources?
* When will the data be consumed? (real-time, daily)

### Ontology Scoping
* state the business questions
* specify the domain of the ontology
* identify necessary data sources
* specify the semantic data model requirements

### Ontology Reuse
* to avoid ontology redundancy we advocate modularity and reuse
* check if parts of the needs are covered in existing ontologies
* consider also extending different ontologies in a new one (modularity)
* define import dependency in ontology metadata

### Ontology Modelling Steps
Modelling consists of 3 main steps:
1. create classes,
2. create relations,
3. create attributes.

## Language
* bilingual (en, de)
* use generic terms for identifiers (domain-independent)
* use business terms for prefLabel (domain-specific)
* specify always annotations fully (definition, example, synonyms)

### Don't dos
* No branding or marketing lanugage, which can mislead the semantics

### Semantics
* use short, meaningful, unambiguous names
* note: natural language exhibits ambiguity, inaccuracy, uncertainty, vagueness
* use both English and German names, since it improves the semantics
* do not use vague terms, e.g. model, data, ...
* use only US English terms and name British terms as synonyms, e.g. meter/metre

* avoid bad naming, consider interpretation and context
* make names more specific if it has more than one interpretation
* avoid omitting definitions or bad definitions
* try to name examples, since it supports in the semantics

## Naming Convention

| **convention**  |  **identifier**  |   **name_en**  |    **name_de**    |
|-----------------|:----------------:|:--------------:|:-----------------:|
| **language**        | English          | English        | German            |
| **readability**     | machine-readable | human-readable | human-readable    |
| **terms**           | generic terms    | business terms | business terms    |
| **character range** | [A-z0-9]         | [A-z0-9 -]     | [A-z0-9 -ÄäÖöÜüß] |
| **separator**       | none             | whitespace     | whitespace        |
| **class case**      | PascalCase       | Title Case     | Title Case        |
| **relation case**   | camelCase        | lower case     | lower case        |
| **attribute case**  | camelCase        | Title Case     | Title Case        |
| **acronyms**        | no               | yes            | yes               |

### Naming Convention for Identifiers/URIs
* use only alphanumeric characters [A-z0-9] (IRI/URI standard)
* do not use acronyms or abbreviations allowed in URIs
* use PascalCase/UpperCamelCase for classes (RDF/OWL standard)
* use camelCase/lowerCamelCase for relations and attributes (RDF/OWL standard)

### Naming Convention for Names
* use only alphanumeric characters with whitespaces [A-z0-9 ] + Umlaute (ÄäÖöÜüß)
* use acronyms or abbreviations if it helps the understanding of the data for the consumers
* use title case with whitespaces for classes and attributes for better human-readability
* use lower case with whitespaces for relations

## Ontology Table Schema
| **simple_name** | **rdf_name**       |
|--------------------|-----------------------|
|   type             |   rdf:type            |
|   identifier       |                       |
|   parents          |   rdfs:subClassOf     |
|   relation_from    |   rdfs:domain         |
|   relation_to      |   rdfs:range          |
|   name_en          |   skos:prefLabel@en   |
|   name_de          |   skos:prefLabel@de   |
|   definition_en    |   skos:definition@en  |
|   example_en       |   skos:example@en     |
|   note_en          |   skos:note@en        |
|   synonyms_en      |   skos:altLabel@en    |
|   synonyms_de      |   skos:altLabel@de    |
|   links            |   rdfs:seeAlso        |


## Upper Ontology
* top level classes

# Advanced Topics

## Ontology Layers
Three model layers:
* [conceptual data model](https://en.wikipedia.org/wiki/Conceptual_schema)
* [logical data model](https://en.wikipedia.org/wiki/Logical_schema)
* [physical data model](https://en.wikipedia.org/wiki/Physical_schema)

## Ontology Scoping
* modular, reusable, non-redundant

### Business Question

## Open-world Assumption
The closed-world assumption has the presumption that a given statement is not known to be true,
can be inferred as false in a model. While the [open-world assumption](https://en.wikipedia.org/wiki/Open-world_assumption)
states a given statement is not known to be true, **cannot** be inferred as false.
It means that we can make inferences based only on known statements. In OWL the open-world
assumption is made and assumed that an ontology is not complete and can change over time.

## Unique Name Assumption
In OWL there is no [unique name assumption](https://en.wikipedia.org/wiki/Unique_name_assumption),
i.e. different names can refer to the same individual, which can clarified by `owl:sameAs` or
`owl:differentFrom`.

## Ontology Metadata
Annotations

### Types of relations
* association, 
* composition (part-of), 
* aggregation (has-a), 
* inheritance (is-a)

## Ontology Merging

### Individual Identifier
We use `underscore` as separator between classes and indiviual name in the identifier.
* class + '_' + primary_key

This is used in the template of R2RML mappings.

### Identifier Collision
Identifiers should be used globally uniquely so that during merging of domain ontologies
there is no [name collision](https://en.wikipedia.org/wiki/Name_collision).
The meaning should be also unique.

# Design Decisions

## Basics Decisions
### Single vs. Multiple Namespaces
* single namespace: `cx:` (better, since complexity)
* multiple namespaces: `cx:, cx-vehicle:, cx-common:`

### Prefix Naming
* short 2-3 characters
* characterspace [a-z], i.e. only lower case

### Number of allowed Datatypes
* few: string, integer (better, since complexity)
* more: string, int, integer, ...

### Using Enumerates
* yes
* no

### Arrays
* yes
* no
* how?

### Linking vs. Importing External Ontologies
* linking: `cx:Person owl:equivalentClass foaf:Person`
* import foaf

We instroduce **semantic debt**, when we import external ontologies, due to
their heterogenity.

## Ontology Decisions

### Instances or Subclasses
1. `cx:VehiclePlant cx:isOfType cx:PlantType_VehiclePlant`
2. `cx:VehiclePlant owl:subClassOf cx:Plant`

### Generic or Specific Relation Names
1. `cx:Vehicle cx:has cx:VehicleComponent`
2. `cx:Vehicle cx:hasVehicleComponent cx:VehicleComponent`

Specific (2) is better, since better semantics.

### Generic or Specific Attribute Names
1. `cx:Plant cx:id xsd:string`
2. `cx:Plant cx:plantId xsd:string`

Specific (2) is better, since better semantics.

### Instances or Attributes
1. `cx:Vehicle cx:hasColor cx:Color_Blue`
2. `cx:Vehicle cx:hasColor "blue"`

Both (1 & 2), due to the heterogenity of the underlying data.

### Everything is a Concept
* `cx:Vehicle rdf:type owl:Class; skos:Concept`

### Data Normalisation
[Normalisation](https://en.wikipedia.org/wiki/Database_normalization) is
necessary to minimise the redudnancy.

## Language Decisions
### Casing
1. Title Case
2. lower case

Title case (1) is better, since easier to read.

### Open vs. Closed Compound Words
1. data set
2. dataset

### Hyphenation
1. E-mail
2. Email

...
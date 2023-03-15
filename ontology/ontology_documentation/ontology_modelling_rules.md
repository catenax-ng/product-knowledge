# Ontology modelling rules

Here you can find modeling rules to reduce the complexity of ontologies and to design application-oriented ontologies. The goal of these rules is to simplify the binding of the ontologies to the applications (knowledge agent skills) and thus increase the reuse.

## When should a new class or relation be created in a domain ontology?
 
New classes or relations can be added to the domain ontology if there are no explicit classes or relations for data in the ontology. It is important to adapt or extend the ontology systematically and based on the use cases, existing or planned data. Ontologies can grow with the application development. Therefore, it is not necessary to complete the model before starting the implementation, as is the case with classical database development. On the other hand, ontologies that are not developed in an application-oriented way are often very theoretical and not well usable in practice.

For ontology changes, a workflow is defined under Catena-X project, which you please follow to make changes systematically and application-oriented.
-Link-

## How to create a new class or relation

When you create a new class or relation, you should define as clearly as possible what this class/relation stands for and what it is not. RDFS, SKOS, DC Vocabularies can be used for this as in the following example.

~~~s
#Class Part from part ontology
cx:Part a owl:Class ;
    rdfs:seeAlso <https://de.wikipedia.org/wiki/Bauteil_> ;
    skos:altLabel "Komponente"@de,
        "Teil"@de,
        "component"@en ;
    skos:definition "A part in the automotive context is a component of a vehicle, such as the engine, brakes, or transmission."@en ;
    skos:note "non-physical object"@en ;
    skos:prefLabel "Bauteil"@de,
        "Part"@en .
~~~

## Don't create subclasses if possible

There is no need for subclasses if it is possible to specify the instance of the class through further properties and terms. The hierarchy of terms can be defined in a thesauri (see example bellow). Otherwise, the ontology hierarchy constantly increases in size and complexity, making it less reusable.

```s
    #Example with subClassOf relation
    ex:Coffee a owl:Class.
	ex:Espresso a owl:Class;
        rdfs:subClassOf exp:Coffee.
	ex:Macchiato a owl Class;
        rdfs:subClassOf ex:Coffee.

    ex:milk_percentage a owl:DatatypeProperty;
        rdfs:domain ep:coffee;
        rdfs:range xsd:double.

    ex:coffee_percentage a owl:DatatypeProperty;
        rdfs:domain ex:coffee;
        rdfs:range xsd:double.

    #Example with SKOS thesauri
    # thin ontology
    ex:Coffee a owl:Class.

    ex:coffee_type a owl:ObjectProperty;
        rdfs:domain ex:Coffee;
        rdfs:range skos:Concept.

    #skos taxonomy
    ex:ConceptCoffee rdf:type skos:Concept;
        skos:prefLabel "Coffee"@en;
        skos:narrower ex:Espresso;
        skos:narrower ex:Macchiato.

    ex:Espresso rdf:type skos:Concept;
        skos:prefLabel "Espresso"@en;
        skos:broader ex:Coffee.
    
    ex:Macchiato rdf:type skos:Concept;
        skos:prefLabel "Macchiato"@en;
        skos:broader ex:Coffee.

```

## Don't use abstract classes and owl:Thing if possible

Abstract classes that have no property and do not perform any use case, but only stand for a certain set of classes, should be discarded. Additionally, if the classes are defined as subclasses of abstract class or owl:Thing, the reasoner handles all direct subclasses the same, which can lead to the desired results in the rdf graph.

## Rules for the creation of Properties
- In the creation of properties, care should be taken to ensure that they have exact domains and ranges. Multiple domains and ranges usually lead to inconsistent states after reasoning. *In OWL multiple rdfs:domain or rdfs:range axioms are allowed, but they are interpreted as conjunction, being, therefore, equivalent to the construct owl:intersectionOf.* ([Ontology pitfall catalogue](https://oops.linkeddata.es/))

- When creating the sub property, check if a specification like 'person_name' is necessary for the property 'name', otherwise the sub class can directly use the super class propertise. With the subPropertyOf relation, the sub property inherits the domain and ranges from the parent property, this can lead to inconsistent states, so verify if it is desired.


## Don't create instances in the ontology

- A clear line should be drawn between model and data/instances, i.e. no instance in the ontology, even if it is a single object  such as location, term, etc. The skos:Concept is better suited for this.

## Define what is expected from reasoning

Reasoning should add value and not increase complexity. Therefore, modelling should define what is expected from reasoning. OWL offers different [profiles](https://www.w3.org/TR/owl2-profiles/) QL, RL and EL that support different OWL reasoning. Depending on the language constructs used by OWL, the OWL profile is decided. Therefore, it should be documented in the ontology which OWL profile is used and why. For the start we recommend to use OWL 2 QL. Because this profile contains most of the main features of conceptual models such as UML class diagrams and ER diagrams and *OWL 2 QL is aimed at applications that use very large volumes of instance data, and where query answering is the most important reasoning task.*[OWL 2 Profiles](https://www.w3.org/TR/owl2-profiles/)

## Data quality check in SHACL instead of restrictions in the ontology

[OWL](https://www.w3.org/TR/owl2-syntax/) offers restrictions for the cardinality of object and data properties, for enumeration and data property axioms. With these constructs, the reasoner checks whether the modelling restrictions in the data are observed and otherwise reports conflicts. Accordingly, the reasoner must be set up for this. Reasoners offer these features but it is better to use reasoners to generate new relations and type instances. Because each reasoner has its own structure and the conflicts it finds are represented in different ways. Such constraints can be better defined and checked in SHACL with self-defined error messages. Therefore, we recommend Reasoner for generating new knowledge and SHACL for data quality checks.

# Ontology Table

## Create ontology table
Find a suitable ontology **domain name**, e.g. _vehicle test_, and create ontology table file including the author name:
```
create_ontology_table('vehicle test', 'Max Mustermann')
```
Now, the file vehicle_ontology.csv is created under the folder ontology/ontology_tables/.
Note: Ontology file names are written in snake_case and contain the **domain name** followed
by the suffix '**_ontology**', hence follow the convention _domain_ontology_.

## Create classes, relations and attributes
Now open the ontology table file and start creating the classes, relations and attributes.

### Add Metadata
1. Name coauthors in **# contributor**.
2. Name the scope of the ontology in **# description**, state also the _business questions_ here.
3. Name other ontologies that needs to be imported in **# import**.

### Create classes
A class depicts kinds of things, it is a set of individuals and maps to data tables.

1. Add a new row in ontology table for a new class.
2. Name _class_ in **type**.
3. Name the class URI name in **identifier**, e.g. _vehicle_.
4. Name the super class(es) in **parents**, e.g. _product_.

The super classes will construct a taxonomy.

### Create relations
A relations connects two classes and forms a triple (subject -predicate-> object).
1. Add a new row in ontology table for a new relation.
2. Name _relation_ in **type**.
3. Name the relation URI name in **identifier**, e.g. _is part of_.
4. Name the subject/domain in **relation_from**, e.g. _engine_.
5. Name the object/range in **relation_to**, e.g. _vehicle_.

This reads then as the following triple: _engine -is part of-> vehicle_.
Note: the relation should always contain a **verb**, so that complete, meaningful statements 
are given by the triples.

### Create attribute
An attribute is a data field with data type that belongs to a class and maps to data columns.

1. Add a new row in ontology table for a new attribute.
2. Name _attribute_ in **type**.
3. Name the attribute URI name in **identifier**, e.g. _vehicle identification number_.
4. Name the attached class in **relation_from**, e.g. _vehicle_.
5. Name the data type in **relation_to**, e.g. _xsd:string_.

### Add annotations to classes and attributes
An annotation is a human-readable element that helps to understand the meaning of the classes, relations and attributes.

* Add elements for the glossary: **name**, **definition**, **example**
* Add elements for the thesaurus: **synonyms**.
* Add also a **note** or further **links** as well.

The names and synonyms are specified in both English and German.
Note: Annotations are **not** necessary for relations.

## Convert csv file to turtle file
Execute the script with the domain name:
```
convert_csv_file('vehicle_test')
```
Then, the file vehicle_ontology.ttl is created under the folder ontology/.

# CX Ontology
## Convert all csv files to turtle files
```
convert_all_csv_files()
```

## Merge ontologies to CX ontology
```
merge_ontology()
```
The merged ontology is written in the file **cx_ontology.ttl** in the folder ontology/.

# Ontology Tools
## Ontology Viewer/Editor
* [**Protege**](https://protege.stanford.edu/) is an open-source ontology editor. 
It can be used as a viewer (e.g. taxnomoy/class hierarchy).
* [**Webvowl**](http://vowl.visualdataweb.org/webvowl.html) is an ontology viewer (editor).

## CSV Editor
* Excel
* Numbers (OSX)
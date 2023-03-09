# Catena-X Knowledge Agents (Hey Catena!) Ontology Tool Sources

## Notice

* see copyright notice in the top folder
* see license file in the top folder
* see authors file in the top folder

## What's this?

The CX Ontology Tools are little helpers to deal with CX ontologies.

## Build

Run the following command to test and build the tool binaries

```console
mvn package
```

## Run

### Ontology Merger

Run the following command to merge the CX ontology to the standard output (RDF XML format)

```console
java -jar target/tools-0.8.1-SNAPSHOT.jar ../*_ontology.ttl 
```

To run the merger with an XML-based stylesheet, for example to render the ontology as a graph

```console
java -jar target/tools-0.8.1-SNAPSHOT.jar -styleSheet src/main/resources/graph.xslt ../*_ontology.ttl
```

To run the merger with RDF JSON LD output

```console
java -jar target/tools-0.8.1-SNAPSHOT.jar +jsonld ../*_ontology.ttl
```

To run the merger with VOWL stylesheet on all domain ontologies and create vowl graphs

```console
for file in ../*_ontology.ttl; 
do 
  echo Processing ${file:t} into ${file:t:r}.json 
  java -jar target/tools-0.8.1-SNAPSHOT.jar -styleSheet src/main/resources/vowl.xslt $file 1>../vowl/${file:t:r}.json 
done
```

### JSON Converters

Run the following command to convert a given json file into an SQL script.

```console
node src/main/node/json2Sql.js
```

Run the following command to convert a given json file into separate data jsons

```console
node src/main/node/json2json.js
```

### JSON Testdata Generation

Run the following command to generate test data (currently: for the Traceability Use Case)

```console
node tools/src/main/node/testdata.js
```

The resulting testdata can be found under [this file](tools/src/test/resources/CX_Testdata_v1.4.1-AsPlanned.json)




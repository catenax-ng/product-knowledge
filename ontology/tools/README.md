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

Run the following command to merge the CX ontology to the standard output.

```console
java -jar target/tools-0.5.1-SNAPSHOT.jar ../*.ttl
```

### JSON2Sql Converter

Run the following command to convert a given json file into an SQL script.

```console
node src/main/node/json2Sql.js
```

## Contents

- [Dublin Core Meta-Model (dcterms)](dcterms.ttl)
- [Catena-X Common Domain (cx)](cx.ttl)
- [Catena-X Diagnosis Domain (cx)](diagnosis.ttl)






# Spike for an IDS/GAIA-X compliant semantics/triple-store/SPARQL backplane

This repository documents an experiment to implement a federated backplane to support all kinds of reasonable data services in a 
sovereign manner.

Federated means that the API (and hence the level of data sovereignity) of an individual service does not change when it is accessed 
through a centralized (possibly cached) wrapper.

We chose SPARQL over http/a triple store representation as the basis since
* the graph representation is the most general concept behind any tree, schema- or table-based approach
* the graph representation bridges the gap between data and meta-data representations
* SPARQL already has a builtin concept of separation/federation (GRAPHS or SERVICES)
* SPARQL allows to express all kinds of CRUD operations
* there are SPARQL bindings for all kind of performant storage engines (SQL databases, graph databases, ...)

## Given

- Open Source SPARQL engine (Apache Jena Fuseki)
- Ecplise Dataspace Connector


# Federated Catena-X Data Component Spike 

This repository documents an experiment to implement federated Catena-X data components.

## Introduction

### Catena-X Component

A Catena-X Component implements
- a service API on a data plane (=network)
- the IDS/GAIA-X connector API on a possibly separated control plane

A Catena-X Component may uses/delegate to
- a set of internal modules/services on an internal plane.

### Catena-X Data Component

A Catena-X Data Component implements at least one
- standardized synchronous query API (aka "pull API" although that is misleading the way that data actually flows), such as GraphQL, SparQL or REST/CRUD, or
- standardized asynchronous and batched event API (aka "push API", such as file-based HTTP/POST on top of csv, ttl, xml or json

### Catena-X Federated Component

A Catena-X Federated Component is a component whose service API 
will not change when building/deploying a merged/delegating instance.

### Catena-X Federated Data Component based on SparQL/Turtle

In this spike we demonstrate how to use existing modules to build a 
federated Catena-X data component:
- Eclipse Dataspace Connector
- Apache Fuseki

As the API, we chose
- as the query API: SPARQL over http 
- as the event API: TTL file upload

The reason for this is that
* the graph representation is the most general concept behind any tree, schema- or table-based approach
* the graph representation bridges the gap between data and meta-data representations
* SPARQL already has a builtin concept of separation/federation (GRAPHS or SERVICES)
* SPARQL allows to express all kinds of CRUD operations
* there are SPARQL bindings for all kind of performant storage engines (SQL databases, graph databases, ...)

## How to build and run

### Runs the central data component

```
./run_local.sh -all -build -edc
```

### Run a common internal FUSEKI

```
./run_local.sh -connector
```

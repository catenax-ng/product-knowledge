# Catena-X Knowledge Agents (Hey Catena!) Remoting Agent

The Remoting Agent will bind typical backend services in a secure manner to the dataspace.

This is a folder providing the FOSS implementations of a Hey Catena! Remoting Agent that binds Java classes and simple remote (REST) services to the dataspace.

## Architecture

The Remoting Agent relies on the [Eclipse RDF4J](https://rdf4j.org) for building a storage and inference layer (SAIL) which is backed by a remote REST service.

The [Remoting SAIL](src/main/java/io/catenax/knowledge/agents/remoting/RemotingSail.java) provides the implementation of a repository (=graph asset or named graph) by means of functions (or rather function invocations).

The Remoting SAIL is [configured](src/main/java/io/catenax/knowledge/agents/remoting/RemotingSailConfig.java) by declaring the functions and their binding (determined by a targetUri property). Currently, there are two bindings available
* Class Binding (targetUri follows the pattern "class:<className/>#<methodName/>") 
* REST Binding (targetUri follows the pattern "https?://<url>")


## Deployment

### Compile, Test & Package

```console
mvn package
```

This will generate 
- a [standalone jar](target/agents.remoting-0.5.2-SNAPSHOT.jar) containing all necessary rdf4j components to build your own repository server.
- a [pluging jar](target/original-agents.remoting-0.5.2-SNAPSHOT.jar) which maybe dropped into an rdf4j server for remoting support.

### Run Locally

The standalone jar](target/agents.remoting-0.5.2-SNAPSHOT.jar) contains an example application that runs a sample repository against a sample source

```console
java -jar target/agents.remoting-0.5.2-SNAPSHOT.jar -Dorg.slf4j.simpleLogger.defaultLogLevel=DEBUG
```

### Containerizing

```console
docker build -t ghcr.io/catenax-ng/product-knowledge/dataspace/remoting-agent:0.5.3 -f src/main/docker/Dockerfile .
```

will create a docker image including an extended rdf4j-server aw well as an interactive rdf4j-workbench.

### Run the Container Locally

see [the infrastructure](../../../infrastructure) folder how to configure a repository including a remoting source.


## Notice

* see copyright notice in the top folder
* see license file in the top folder
* see authors file in the top folder






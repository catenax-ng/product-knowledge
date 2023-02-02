# Catena-X Knowledge Agents (Hey Catena!) EDC Agent Protocols

This folder hosts the [Agent Data Protocols for the Eclipse Dataspace Connector (EDC)](https://projects.eclipse.org/projects/technology.dataspaceconnector).

## Architecture

This extension
- introduces a direct endpoint for submitting (federated) queries in the supported inference languages (currently: SparQL)
- may negotiate further agreements for delegating sub-queries on the fly
- implements special Sinks and Sources for dealing with specific endpoint protocols, such as SparQL-Over-Http.
- hosts a synchronisation schedule which regulary requests the catalogue from configured partner connectors and includes them into the default graph

The SparQL implementation currently relies on Apache Jena Fuseki as the SparQL engine.

### Security

There are three types of exposed interfaces:
* Interaction with the tenant (API) is usually shielded with a data plane api key (but may include oauth2 against a consumer-specific SSO)
* Interaction with the control plane (Management, Callback) uses the data plane api key
* Interaction with other data planes (Transfer) uses the "ordinary" synchronous transfer with the DAPS token mechanism

There are three types of called interfaces 
* Interaction with the control plane uses the control plane api key
* Interaction with the persistent storage layer of the embedded SparQL engine uses filesystem mounting and permissions
* Interaction with backend agents uses their individual security settings (typically given in the private data address of the assets, in addition to the DAPS token attachements)

## Building

You could invoke the following command to compile and test the EDC Agent extensions

```console
mvn -s ../../../settings.xml install
```

## Deployment & Usage

### Step 1: Dependency

Add the following dependency to your control-plane artifact pom:

```xml
        <dependency>
            <groupId>io.catenax.knowledge.dataspace.edc.control-plane</groupId>
            <artifactId>agent-plane-protocol</artifactId>
            <version>0.7.4-SNAPSHOT</version>
        </dependency>
```

and the following repo to your repositories section

```xml
    <repository>
      <id>github</id>
      <name>Catena-X Maven Repository on Github</name>
      <url>https://maven.pkg.github.com/catenax-ng/product-knowledge</url>
    </repository> 
```

### Step 1 (Alternative): Adding Jar

see the upcoming io.catenax.knowledge.dataspace.edc.agent-plane.agent-plane-protocol-complete module

### Step 2: Configuration  

The following is a list of configuration objects and properties that you might set in the corresponding mounted config files

| CONFIG FILE                   | SETTING                            | Required | Default/Example                                                | Description                                                                                         | List |
|-------------------------------|------------------------------------|----------|----------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|------|
| /app/configuration.properties | cx.agent.asset.default             |          | urn:graph:cx:Dataspace                                         | Name of the default (local) asset                                                                   |      | 
| /app/configuration.properties | cx.agent.asset.file                |          | dataspace.ttl                                                  | Name of the initial state file of the default (local) asset                                         |      | 
| /app/configuration.properties | cx.agent.accesspoint.name          |          | api                                                            | Internal name in Fuseki for the agent endpoint                                                      |      | 
| /app/configuration.properties | cx.agent.controlplane.url          | X        | http://oem-control-plane:8081/data                             | Data Management Endpoint of the consuming control plane                                             |      | 
| /app/configuration.properties | edc.api.control.auth.apikey.key    | (X)      | X-Api-Key                                                      | Authentication Header for consuming control plane                                                   |      | 
| /app/configuration.properties | edc.api.control.auth.apikey.value  | (X)      |                                                                | Authentication Secret for consuming control plane                                                   |      | 
| /app/configuration.properties | cx.agent.dataspace.synchronization |          | -1/60000                                                       | If positive, number of seconds between each catalogue synchronization attempt                       |      | 
| /app/configuration.properties | cx.agent.dataspace.remotes         |          | http://consumer-edc-control:8282,http://tiera-edc-control:8282 | Comma-separated list of Business Partner Control Plane Urls (which host the IDS catalogue endpoint) |      | 
| /app/configuration.properties | cx.agent.sparql.verbose            |          | false                                                          | Controls the verbosity of the SparQL Engine)                                                        |      | 
| /app/configuration.properties | cx.agent.threadpool.size           |          | 4                                                              | Number of threads for batch/synchronisation processing                                              |      | 
| /app/configuration.properties | cx.agent.federation.batch.max      |          | 9223372036854775807                                            | Maximal number of tuples to send in one query                                                       |      | 
| /app/configuration.properties | cx.agent.negotiation.poll          |          | 1000                                                           | Number of seconds between negotiation status checks                                                 |      | 
| /app/configuration.properties | cx.agent.negotiation.timeout       |          | 30000                                                          | Number of seconds after which a pending negotiation is regarded as stale                            |      | 

## Notice

* see copyright notice in the top folder
* see license file in the top folder
* see authors file in the top folder

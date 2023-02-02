# Catena-X Knowledge Agents (Hey Catena!) Control Plane Agent Transfer

This folder hosts the [Agent- (HttpProtocols-) Aware Control Plane Transfer Extensions for the Eclipse Dataspace Connector (EDC)](https://projects.eclipse.org/projects/technology.dataspaceconnector).

## Architecture

This Extension 
- supports routing synchronous sub-protocols of Http through attached data planes
- supports multiple endpoint receiver callbacks in its configuration

### Security

The mechanism for support sub-protocols is implemented by introducing an additional field "protocol" in the
proxy references (standard: HttpData) which corresponds to the type of the data address (and hence the type of DataSource
to use on provider side). Using that field, also the consumer data plane can find an appropriate Datasource proxy implementation.

## Building

You could invoke the following command to compile and test the EDC Control extensions

```console
mvn -s ../../../settings.xml install
```

## Deployment & Usage

### Step 1: Dependency

Add the following dependency to your control-plane artifact pom:

```xml
        <dependency>
            <groupId>io.catenax.knowledge.dataspace.edc.control-plane</groupId>
            <artifactId>control-plane-transfer</artifactId>
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

You may simply drop the jar which you can download from 'io.catenax.knowledge.dataspace.edc.control-plane.control-plane-transfer' into the [package registry](https://github.com/orgs/catenax-ng/packages?repo_name=product-knowledge) into
the 'lib/ext' folder of your EDC installation.

If you are employing a docker image, you can simply mount the jar from the host/the kubernetes environment.

### Step 2: Configuration 

The following is a list of configuration objects and properties that is introduced with this extension

| CONFIG FILE | SETTING        | Required  | Example                                                                | Description                          | List |
|---          |---	           |---	       |---	                                                                    |---                                   |--|
| /app/configuration.properties| edc.dataplane.selector.agentplane.url          |           | http://oem-data-plane:8082/  | Data Plane Api of the Agent Plane              |  | 
| /app/configuration.properties| edc.dataplane.selector.agentplane.sourcetypes           |           | urn:cx:Protocol:w3c:Http#SPARQL  | Source/Proxy Protocols   | X | 
| /app/configuration.properties| edc.dataplane.selector.agentplane.destinationtypes           |           | HttpProxy  | Transfer Protocols          |  | 
| /app/configuration.properties| edc.dataplane.selector.agentplane.properties           |           | { "publicApiUrl": "http://oem-data-plane:8185/api/public" } | Http transfer endpoint         |  | 
| /app/configuration.properties| edc.receiver.http.auth-codes.agent          |           | X-Api-Key  | Additional callback receiver auth key (if the default one is already used)              |  | 
| /app/configuration.properties| edc.receiver.http.auth-keys.agent           |           |   | Additional callback receiver auth key (if the default one is already used)    |  | 
| /app/configuration.properties| edc.receiver.http.endpoints.agent          |           | http://oem-data-plane:8186/callback/endpoint-data-reference | Additional callback receiver endpoont (if the default one is already used)   |  | 

## Notice

* see copyright notice in the top folder
* see license file in the top folder
* see authors file in the top folder

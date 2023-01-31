# Catena-X Knowledge Agents (Hey Catena!) Control Plane

This folder hosts the [Agent Aware In-Memory Control Plane for the Eclipse Dataspace Connector (EDC)](https://projects.eclipse.org/projects/technology.dataspaceconnector).

## Building

You could invoke the following command to compile and test the EDC Control extensions

```console
mvn -s ../../../settings.xml install
```

## Deployment & Usage

### Containerizing 

You could invoke the following command to compile and test the EDC Agent extensions

```console
mvn -s ../../../settings.xml install -Pwith-docker-image
```

Alternatively, the docker image of the http protocol aware control plane is built using

```console
docker build -t ghcr.io/catenax-ng/product-knowledge/control-plane-memory:latest -f src/main/docker/Dockerfile .
```

The image contains
* an EDC Control Plane with http protocols transfer and in-memory storage (and Hashicorp Vault access).

To run the docker image, you could invoke this command

```console
docker run -p 8082:8082 \
  -v $(pwd)/resources/controlplane.properties:/app/configuration.properties \
  -v $(pwd)/resources/opentelemetry.properties:/app/opentelemetry.properties \
  -v $(pwd)/resources/logging.properties:/app/logging.properties \
  ghcr.io/catenax-ng/product-knowledge/control-plane-memory:latest
````

Afterwards, you should be able to access the [data management api](http://localhost:8082/data) via

For a list of environment variables to configure the behaviour of the data plane, we refer to [the EDC documentation](https://github.com/catenax-ng/product-edc).

The following is a list of configuraton objects and properties that you might set in the corresponding mounted config files

| CONFIG FILE | SETTING        | Required  | Example                                                                | Description                          | List |
|---          |---	           |---	       |---	                                                                    |---                                   | ---  |
| /app/configuration.properties| edc.dataplane.selector.agentplane.url          |           | http://oem-data-plane:8082/  | Data Plane Api of the Agent Plane              |      | 
| /app/configuration.properties| edc.dataplane.selector.agentplane.sourcetypes           |           | urn:cx:Protocol:w3c:Http#SPARQL  | Source/Proxy Protocols   |  X    | 
| /app/configuration.properties| edc.dataplane.selector.agentplane.destinationtypes           |           | HttpProxy  | Transfer Protocols          |      | 
| /app/configuration.properties| edc.dataplane.selector.agentplane.properties           |           | { "publicApiUrl": "http://oem-data-plane:8185/api/public" } | Http transfer endpoint         |      | 
| /app/configuration.properties| edc.receiver.http.auth-codes.agent          |           | X-Api-Key  | Additional callback receiver auth key (if the default one is already used)              |      | 
| /app/configuration.properties| edc.receiver.http.auth-keys.agent           |           |   | Additional callback receiver auth key (if the default one is already used)    |     | 
| /app/configuration.properties| edc.receiver.http.endpoints.agent          |           | http://oem-data-plane:8186/callback/endpoint-data-reference | Additional callback receiver endpoont (if the default one is already used)   |       | 
| /app/logging.properties     |           |                                                            | Logging configuration | X    |
| /app/opentelemetry.properties     |           |                                                            | Telemetry configuration | X    |

## Notice

* see copyright notice in the top folder
* see license file in the top folder
* see authors file in the top folder

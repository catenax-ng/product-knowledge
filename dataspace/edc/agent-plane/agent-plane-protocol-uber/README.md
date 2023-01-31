# Catena-X Knowledge Agents (Hey Catena!) EDC Agent Protocols (Uber)

This folder hosts the [Agent Data Protocols Drop-In for the Eclipse Dataspace Connector (EDC)](https://projects.eclipse.org/projects/technology.dataspaceconnector).

## Architecture

see the [Agent Data Protocols Library](../agent-plane-protocol) for a functional description. This uber-module will
simply collect all the "non-standard" dependencies in a shaded uber jar for easy drop-in. 

## Deployment & Usage

### Step 1: Adding Jar

Simply drop the resulting jar into the lib/ext folder of your data plane installation.
Mount it as a volume if you are dealing with a ready docker container.

### Step 2: Configuration  

see the [Agent Data Protocols Library](../agent-plane-protocol) for the configuration.

## Notice

* see copyright notice in the top folder
* see license file in the top folder
* see authors file in the top folder

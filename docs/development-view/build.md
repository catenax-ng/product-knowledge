---
sidebar_position: 6
title: Building
---

If you do not want to compile the sources on your own, you may directly start with [Deployment](#deploying-packages)

If you are a member of the Catena-X consortium, you could directly start with [Interacting with the Pilot APIs](#interacting-with-the-pilot-apis-and-the-skill-gym).

## Source Repository

You will find the source code of the Pilot under [https://github.com/catenax-ng/product-knowledge](https://github.com/catenax-ng/product-knowledge/tree/v0.5.5-pilot) 

Be sure to initialise the git submodules after cloning the repo

```console
git submodule update --init --recursive
```

## Building Packages and Running Locally

You will need a JDK>=11 installed in the JAVA_HOME environment variable.
You will need internet access and (optionally) a proxy installed in the HTTP_PROXY_HOST and HTTP_PROXY_PORT environment variables.
You will need node.js/npm installed.
The build process will install a (local) maven build tool during the run.
You will need a valid github user with a reasonably permissive PAT (personal access token).

```console
export GITHUB_ACTOR=<yourgithubusername>
export GITHUB_TOKEN=<yourpat>
```

You will need to configure the skill gym with the right API Key and connector information for the localhost environment 

```console
cat > ux/skill_gym/.env << EOF
REACT_APP_SKILL_CONNECTOR_CONTROL=http://localhost:8282
REACT_APP_SKILL_CONNECTOR_DATA=http://localhost:8284
REACT_APP_SKILL_CONNECTOR_AUTH_HEADER_KEY=X-Api-Key
REACT_APP_SKILL_CONNECTOR_AUTH_HEADER_VALUE=bar
EOF
```

### Building Knowledge Agents

Building the packages can be done with or without docker images. If you are sitting behind a proxy, you could
use the appropriate environment variables HTTP_PROXY_HOST and HTTP_PROXY_PORT.

```console
./mvnw -s settings.xml install -Pwith-docker-image -Dhttps.proxyHost=${HTTP_PROXY_HOST} -Dhttps.proxyPort=${HTTP_PROXY_PORT} 
cd ux
npm install -g jest
npm run init:dev
cd ..
```

### Building under MacOS/M=>1

Since we are not (no more) using gradle, there is no particular MacOS environment kung-fu anymore, as there was in the [spike](spike). Also the default docker images (see above) 
tailored to linux/amd64 run perfectly under arm64-qemu.

Only if you want to build without emulation (and do not plan to publish the tags to our registries), you may want to call 

```bash
# Use the right docker platform when calling mvnw
./mvnw -s settings.xml install -Dplatform=linux/arm64
```

### Running Knowledge Agents (Locally)

Running Knowledge Agents locally simply uses the docker-compose infrastructure

```bash
cd infrastructure
docker-compose build
docker-compose up &
cd ..
cd ux
npm run start:skillgym
```

### Running under MacOS/M=>1

Only if you want to run without emulation (and do not plan to publish the tags to our registries), you may prepend

```bash
# Use the right docker platform when calling docker-compose
export DOCKER_PLATFORM=linux/arm64
```

For inquiries please contact [Tom Buchert](mailto:tom.buchert@t-systems.com)

  For more information see 
* Our [Adoption](../adoption-view/intro) guideline
* The [Layers & Modules](modules) Architecture
* Our [Build](build) instructions
* The [Deployment](../operation-view/deployment) guide 

# Knowledge Agents Spike (Deprecated)

If you do not want to compile the sources on your own, you may directly start with [Deployment](#deployment-using-docker)

If you are a member of the Catena-X consortium, you could directly start with [Interacting with the Spike APIs and the Portal](#interacting-with-the-spike-apis-and-the-portal).

## Source Repository

You will find the source code of the Spike  under [https://github.com/catenax-ng/product-knowledge](https://github.com/catenax-ng/product-knowledge/tree/feature/ART3-375-spike) 

Be sure to initialise the git submodules after cloning the repo

```console
git submodule update --init --recursive
```

## Building Packages and Running Locally

You will need a JDK>=11 installed in the JAVA_HOME environment variable.
You will need Apache Maven installed in the PATH environment variable.
You will need internet access and (optionally) a proxy installed in the HTTP_PROXY_HOST and HTTP_PROXY_PORT environment variables.
You will need node.js/npm installed.
The build process will install a (local) gradle build tool during the run.

### Building under MacOS/M=>1

There is currently [no auto-configurable Java 11 toolchain for gradle](https://github.com/square/okhttp/issues/6943).

We recommend to download/install the [Azul JDK 11](https://www.azul.com/downloads/?os=macos&architecture=arm-64-bit&package=jdk) and execute the 
following commands

```bash
# Adapt to the path of your Azul JDK11
export JDK11=~/Projects/jdk/zulu11.54.25-ca-jdk11.0.14.1-macosx_aarch64
export GRADLE_PROPS=(--no-parallel -Porg.gradle.java.installations.fromEnv=JDK11 -Pversion=0.0.3-CATENAX)
```

If you want to run the resulting docker images locally without emulation (and do not plan to publish them to non-Apple registries), 
you may also

```bash
# Use the right docker platform for running
export DOCKER_PLATFORM=linux/arm64
```

### Building/Patching Jena

```console
cd jena
git apply ../src/patch/jena.patch
cd jena-fuseki2
mvn install -DskipTests -Denforcer.skip=true -Dmaven.javadoc.skip=true
cd ..
git restore .
cd ..
```

### Building/Patching Eclipse Dataspace Connector

```console
cd DataSpaceConnector
./gradlew $GRADLE_PROPS -Dhttps.proxyHost=${HTTP_PROXY_HOST} -Dhttps.proxyPort=${HTTP_PROXY_PORT} publishToMavenLocal -x test
cd ..
```

### Building Knowledge Agents

```console
./gradlew $GRADLE_PROPS -Dhttps.proxyHost=${HTTP_PROXY_HOST} -Dhttps.proxyPort=${HTTP_PROXY_PORT} build
```

### Running the Spike components

```console
# Run a single backend data plane
./run_local.sh -complete -internal &
# Run three agents
./run_local.sh -tenant1 -external &
./run_local.sh -tenant2 -external &
./run_local.sh -central -external &
# Run the portal
cd tractusx/portal/code/tractus-x-portal
npm install npm@latest --force
npm start
```

## Deployment using Docker 

Once the packages are compiled, the following command will build all docker images

```console
docker compose build
```

If you are a member of the Catena-X consortium, you may also use a [script](https://github.com/catenax-ng/product-knowledge/blob/feature/ART3-375-spike/README.md) to publishes the resulting images (only linux/amd64) directly to the Catena-X registry (for which you need a valid and catenax-ng enabled github account).

The following images are built (and aalso publically available for direct pull under linux/amd64):

```console
docker pull ghcr.io/catenax-ng/product-knowledge/data-plane-agent:0.0.1
docker pull ghcr.io/catenax-ng/product-knowledge/control-plane:0.0.1
docker pull ghcr.io/catenax-ng/product-knowledge/portal:0.0.1
```

Running the spike via docker is then done via
```console
docker compose up
```

### Using a Helm Chart/Kubernetes Deployment

You could mount the [helm folder of the repository](https://github.com/catenax-ng/product-knowledge/tree/feature/ART3-375-spike/helm)  also in Argo CD or 
an equivalent mechanism. 

Please be aware that this is currently not configurable, e.g. to non-Catena-X environments.

## Interacting with the Spike APIs and the Portal

You should now be able to access the APIs via this public Postman Workspace https://www.postman.com/catena-x/workspace/catena-x-knowledge-agents (choose the "Localhost" environment - no additional credentials needed - and the "Hey Catena! Spike" Collection).

As an alternative, you may import the [Postman Collection](https://github.com/catenax-ng/product-knowledge/blob/feature/ART3-375-spike/federation.postman_collection.json) into the REST IDE of your choice.

If you are a member of the Catena-X consortium, you may also directly switch to the "Integration" environment and populate the lacking secrets with information from [our Catena-x confluence page](https://confluence.catena-x.net/x/1wHrAg). You will then access the already deployed system.

You may need to execute the first two upload commands in the Data Plane (internal) folder to populate the backend.

You should then be able to access the portal via http://localhost:3000 for which you need an account in the Catena-X Speedboat directory.
And you should use Google Chrome (because of the pre-installed HTML5-speechkit voices).

If you are a member of the Catena-X consortium, you may also directly login to the [Integration Environment](https://hey.int.demo.catena-x.net/portal) information from [our Catena-x confluence page](https://confluence.catena-x.net/x/1wHrAg). 

## What the demo shows

### Login and Welcome

After a successful login (for which you will need a login in a Speedboat-compatible Directory Service) you will enter the dashboard which shows your "booked" services and apps.

![Spike Login](/img/spike_login.png)

Here you will see that there are several agents (Cortana, TINA) subscribed (as computation services to which you can dump computations=queries).

You will also see that there are several skills (=predefined queries, such as Material Aggregation, Part Tracing and Lot Impact) already unlocked.

Both the agents and the skills will appear again in the Knowledge Explorer (linked in the welcome screen and as "knowledge" in the top menu).

### Knowledge Explorer

The Knowledge Explorer starts empty. 

![Spike Knowledge Explorer](/img/spike_knowledge_explorer.png)

Using the Help Button, you can branch into this and related Confluence pages.

Using the "Ask me!" box, you may either write down your question or even dictate a phrase when pressing the "X" button.

If you manually write your text, you must choose an appropriate skill in the Skill Combobox before pressing enter.

If you dictate, any recognized skill (depending on the phrase that is understood) will be automatically chosen und you just need to press enter (after eventually correcting any errors - the case and punctuation of the phrases is ignored/irrelevant btw).

When there is no skill or the phrase will not lead to any reasonable inference and hence knowledge result, Catena-X may answer "WTF?"

### Part Tracing Skill

Try to dictate "Show me all vehicles which contain glue" - the phrase which contain is the marker for Catena-X to choose the Part Tracing Skill. The following phrase glue will be used as the parameter to the skill and you could try to experiment with other materials such as palladium, copper or cathode material.

![Spike Part Tracing Skill](/img/spike_part_tracing_skill.png)


After successful execution (remember to press enter in the Ask Me! box), the explorer will show the generated knowledge results from the query in the form of little cards.

At the same time, the chosen agent will give you an aggregated summary in speech ("Hi Schorsch! There are 10 vehicles which contain glue." - the username is currently still hardoded, unfortunately).

### Switching Agents and the Material Aggregation Skill

No try to dictate or write "Hi Tina" which is the phrase to let Catena-X switch the underlying agent engine (other options are Cortana, Stefan, Helga). 

The agent will give you a hint by making a characteristic sound with its voice.

When uttering "How much cathode material is in vehicle model a", TINA will then compute the average weight of the chosen material in the given series (and the individual weight for each car on the resulting cards).

![Spike Material Skill](/img/spike_material_skill.png)

### German Speech Output and the Lot Impact Skill

Finally, you can switch to a German-Speaking Agent "Helga" by using the Agent Combobox selection.

Try to dictate - still in english, the input language is currently hardcoded -  "Which components are affected by lot 12949" (where you need to pronounce the digits each isolated - so like "one two nine four nine").

And Helga will give you a trace of aggregate components (and the material inside) and the number of cars affected by the given lot number (prefix). 

![Spike Lot Skill](/img/spike_material_skill.png)

### How to I extend skills?

[This piece of frontend code](https://github.com/drcgjung/tractusx/blob/dd67f0b99ad8c4c02acc644606908f566076212a/portal/code/tractus-x-portal/src/components/knowledgeagent/data.ts) shows how easy it is to implement new skills and conversations using this approach.




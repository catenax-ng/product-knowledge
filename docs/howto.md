---
sidebar_position: 3
title: How To (Spike)
---

# Source Repository

You will find the source code of the Spike  under [https://github.com/catenax-ng/product-knowledge](https://github.com/catenax-ng/product-knowledge/tree/feature/ART3-375-spike) 

Be sure to initialise the git submodules after cloning the repo

```console
git submodule update --init --recursive
```

# Building Packages and Running Locally

You will need a JDK>=11 installed in the JAVA_HOME environment variable.
You will need Apache Maven installed in the PATH environment variable.
You will need internet access and (optionally) a proxy installed in the HTTP_PROXY_HOST and HTTP_PROXY_PORT environment variables.
You will need node.js/npm installed.
The build process will install a (local) gradle build tool during the run.

## Building under MacOS/M=>1

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

## Building/Patching Jena

```console
cd jena
git apply ../src/patch/jena.patch
cd jena-fuseki2
mvn install -DskipTests -Denforcer.skip=true -Dmaven.javadoc.skip=true
cd ..
git restore .
cd ..
```

## Building/Patching Eclipse Dataspace Connector

```console
cd DataSpaceConnector
./gradlew $GRADLE_PROPS -Dhttps.proxyHost=${HTTP_PROXY_HOST} -Dhttps.proxyPort=${HTTP_PROXY_PORT} publishToMavenLocal -x test
cd ..
```

## Building Knowledge Agents

```console
./gradlew $GRADLE_PROPS -Dhttps.proxyHost=${HTTP_PROXY_HOST} -Dhttps.proxyPort=${HTTP_PROXY_PORT} build
```

## Running the Spike components

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

You should now be able to access the APIs via this Postman Workspace https://www.postman.com/catena-x/workspace/catena-x-knowledge-agents (choose the "Localhost" environment).

You may need to execute the first two upload commands in the Data Plane (internal) folder to populate the backend.

You should then be able to access the portal via http://localhost:3000 for which you need an account in the Catena-X Speedboat directory.
And you should use Google Chrome (because of the pre-installed HTML5-speechkit voices).

# Building Docker Images and Running Locally

Once the packages are compiled, the following command will build all docker images

```console
docker compose build
```

There is a [script](https://github.com/catenax-ng/product-knowledge/blob/feature/ART3-375-spike/README.md) which does that and 
also publishes the resulting images (only linux/amd64) directly to the Catena-X registry (for which you need a valid github account).

The following images are built (and are also available for direct pull under linux/amd64):
```console
docker pull ghcr.io/catenax-ng/product-knowledge/data-plane-agent:0.0.1
docker pull ghcr.io/catenax-ng/product-knowledge/control-plane:0.0.1
docker pull ghcr.io/catenax-ng/product-knowledge/portal:0.0.1
```

Running the spike via docker is then done via
```console
docker compose up
```

You should now be able to access the APIs via this Postman Workspace https://www.postman.com/catena-x/workspace/catena-x-knowledge-agents (choose the "Localhost" environment).

You may need to execute the first two upload commands in the Data Plane (internal) folder to populate the backend.

You should then be able to access the portal via http://localhost:3000 for which you need an account in the Catena-X Speedboat directory.
And you should use Google Chrome (because of the pre-installed HTML5-speechkit voices).

# Using a Helm Chart/Kubernetes Deployment

You could mount the [helm folder of the repository](https://github.com/catenax-ng/product-knowledge/tree/feature/ART3-375-spike/helm)  also in Argo CD or 
an equivalent mechanism. 

Please be aware that this is currently not configurable, e.g. to non-Catena-X environments.

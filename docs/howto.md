---
sidebar_position: 3
title: How To (Pilot)
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

## Deploying Packages

Deploying the maven packages can be done with or without docker images

```console
./mvnw -s settings.xml publish -Pwith-docker-image
```

Deploying the npm packages can be done as follows (where the username/password to be entered correspond to above github credentials)

```console
cd ux
npm login --scope=@catenax-ng --registry=https://npm.pkg.github.com
npm publish
````

The resulting maven and npm packages reside under [this repository](https://github.com/orgs/catenax-ng/packages?repo_name=product-knowledge).

The resulting docker images reside under [this repository](https://github.com/orgs/catenax-ng/packages?ecosystem=container&tab=packages&ecosystem=container&q=product-knowledge).

The following images are built (and also publically available for direct pull under linux/amd64):

```console
docker pull ghcr.io/catenax-ng/product-knowledge/backend/sql-virtualize-dremio-oss:22.0
docker pull ghcr.io/catenax-ng/product-knowledge/backend/lifetime-prognosis-mock:latest
docker pull ghcr.io/catenax-ng/product-knowledge/dataspace/remoting-agent:0.5.5-snapshot
docker pull ghcr.io/catenax-ng/product-knowledge/dataspace/provisioning-agent:0.5.5-snapshot
docker pull ghcr.io/catenax-ng/product-knowledge/dataspace/agentplane-azure-vault:0.5.5-snapshot
docker pull ghcr.io/catenax-ng/product-knowledge/dataspace/edc-dataplane-azure-vault:0.1.1-ka-snapshot
docker pull ghcr.io/catenax-ng/product-knowledge/dataspace/edc-controlplane-postgresql:0.1.1-ka-snapshot
docker pull ghcr.io/catenax-ng/product-knowledge/dataspace/edc-controlplane-memory:0.1.1-ka-snapshot
docker pull ghcr.io/catenax-ng/product-knowledge/dataspace/edc-controlplane-postgresql-hashicorp-vault:0.1.1-ka-snapshot
docker pull ghcr.io/catenax-ng/product-knowledge/dataspace/edc-dataplane-hashicorp-vault:0.1.1-ka-snapshot
```

### Using a Helm Chart/Kubernetes Deployment

You could mount the [infrastructure folder of the repository](https://github.com/catenax-ng/product-knowledge/tree/v0.5.5-pilot/infrastructure)  also in Argo CD or 
an equivalent mechanism. 

Please be aware that this is currently not configurable, e.g. to non-Catena-X environments. A rudimentary configuration of the business partners/roles (Consumer, OEM and Supplier) is available.

## Interacting with the Pilot APIs and the Skill Gym

You should now be able to access the APIs via this public Postman Workspace https://www.postman.com/catena-x/workspace/catena-x-knowledge-agents (choose the "Localhost" environment - no additional credentials needed - and the "Knowledge Agents Pilot" Collection).

As an alternative, you may import the [Postman Collection](https://github.com/catenax-ng/product-knowledge/blob/v0.5.5-pilot/cx_ka_pilot.postman_collection.json) into the REST IDE of your choice.

If you are a member of the Catena-X consortium, you may also directly switch to the "Integration" environment and populate the lacking secrets with information from [our Catena-x confluence page](https://confluence.catena-x.net/x/1wHrAg). You will then access the already deployed system.

You should then be able to access the skill gym via http://localhost:3000 for which you need an account in the Catena-X Central IDP.

If you are a member of the Catena-X consortium, you may also directly login to the [Integration Environment](https://knowledge.int.demo.catena-x.net/skill_gym) information from [our Catena-x confluence page](https://confluence.catena-x.net/x/1wHrAg). 

## What the demo shows

### Login and Welcome

After a successful login (for which you will need a login to the Catena-X Central IDP) you will enter the dashboard which shows your assets and the Catena-X ontology

![Pilot Login](/img/pilot_skill_gym.png)

Here you will see whether your connector has any graph or skill offers.

You will also see a graph of the concepts (classes, inheritance, attributes and relations) that are encoded in the graph assets and are inferenced about in the
skill assets.

### Jump to the Semantic Hub in the Portal

You may look at running the [forked Catena-X portal](https://github.com/catenax/ka-portal-frontend) and then jump to the [Semantic Hub Ontology View](http://localhost:3000/semantichub/https%3A%2F%2Fraw.githubusercontent.com%2Fcatenax-ng%2Fproduct-knowledge%2Fmain%2Finfrastructure%2Fconsumer%2Fresources%2Fcx-ontology.json).


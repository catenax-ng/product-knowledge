# Catena-X Agents Kit Source Repository

<img height="200" src="https://raw.githubusercontent.com/catenax-ng/product-knowledge/feature/ART3-382-documentation/static/img/agents_kit.png" align="left" style="margin-right:30px"/>

This is a [MonoRepo](https://en.wikipedia.org/wiki/Monorepo) hosting or linking all the module 
and infrastructure codes related to the 
Catena-X [Agents Kit](https://catenax-ng.github.io/product-knowledge/).

* See this [copyright notice](COPYRIGHT.md)
* See the [authors file](AUTHORS.md)
* See the [license file](LICENSE.md)
* See the [code of conduct](CODE_OF_CONDUCT.md)
* See the [contribution guidelines](CONTRIBUTING.md)
* See the [dependencies and their licenses](DEPENDENCIES.md)

## Documentation

With regard to any global, architectural and usage documentation, we refer to our [web page](https://catenax-ng.github.io/product-knowledge/).
All sources are locally documented using markdown and language-specific code comments.

## Repository Linking and Initialisation

The individual modules may be maintained in separate repositories (currently: [a patched AASWC client](ux/skill_gym/public/aaswc)). 

They are linked as [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) 
so you should be sure to run the following command after cloning this repo:

```console
git submodule update --init
```

You may open this repository in a [Github Codespace](https://github.com/features/codespaces). Be sure to use a "4-core" or bigger machine type since 
some of the docker images need a certain amount of memory and horsepower.

## Modules

These are the sub-modules of the Agents Kit 

- [Dataspace](dataspace/README.md) hosts reference implementations of the Gaia-X/IDS Dataspace extensions (Agents) for both Providers and Consumers which  the semantics of Catena-X.
- [UX](ux/README.md) hosts User Experience components and a sample portal/development environment for developing and executing semantically-driven logic and apps.
- [Infrastructure](infrastructure/README.md) hosts "Infrastructure as Code" manifests and resources for easy deployment of above artifacts including a sample dataspace.

Carved out external repositories
- [Ontology](https://github.com/catenax-ng/product-ontology) hosts the CX domain ontologies (including the fully merged CX ontology and tooling) describing the semantics of the Catena-X Dataspace.

Besides the markdown documentation including this file, we have some helper folders

- [Github](.github) contains all workflows and CI/CD processes.
  - [Github CI/CD Workflow](.github/workflows/codeql.yaml) builds and unit-tests all artifacts, checks source and binary code quality using CodeQL and publishes the results (only main branch).
  - [Github KICS Workflow](.github/workflows/kics.yml) checks Docker Buildfiles and Helm Charts for the most common vulnerabilities.
- [Maven](.mvn) contains bootstrap code for the main build system.

And some related scripts and settings

- Git Settings
  - [Attributes](.gitattributes) has large-file settings for binary artifacts.
  - [Ignore](.gitignore) excludes certain build artifacts from versioning.
- Maven Scripts
  - [Maven Wrapper](mvnw)([For Windows](mvnw.cmd)) for bootstrapping the build system.
  - [Maven Pom](pom.xml) describing the KA root module and common build steps.
  - [Maven Settings](settings.xml) configuring the associated artifact repository credentials.
- Postman Collections and Environments
  - [Knowledge Agents](cx_ka.postman_collection.json) contains API interactions and samples for all REST-based interfaces of the KA architecture. Includes integration test steps. Excludes conformity asessment methods. Should be combined with one of the following environments
  - [Localhost](cx_ka.localhost.postman_environment.json) contains API endpoints and secrets for interacting with the local deployment of the sample dataspace.
  - [Development](cx_ka.development.postman_environment.json) contains API endpoints and (emptied) secrets for interacting with the development deployment of the sample dataspace. Please contact the CX association to get the actual secrets.
  - [Localhost](cx_ka.integration.postman_environment.json) contains API endpoints and (emptied) secrets for interacting with the integration deployment of the sample dataspace. Please contact the CX association to get the actual secrets.
- [Conda Environment](environment.yaml) for setting up python.

## Build

### Environment Variables

To interact with the required package and container registries, the following environment variables should be set

```console
export GITHUB_ACTOR=
export GITHUB_TOKEN=
```

### Prepare

A suitable [conda](https://conda.io/) environment named `knowledgeagents` can be created
and activated with:

```
conda env create -f environment.yaml
conda activate knowledgeagents
```

### Compile

To build all compilation artifacts (without tests), you can invoke

```console
./mvnw -s settings.xml install -DskipTests
```

### Test

To build all compilation artifacts (including tests), you can invoke

```console
./mvnw -s settings.xml install
```

### Package and Deploy

To bundle all deployment artifacts for a particular platform (currently supported: linux/amd64 and linux/arm64), you can invoke

```console
./mvnw -s settings.xml package -Pwith-docker-image -Dplatform=linux/amd64
```

To publish the artifacts, choose

```console
./mvnw -s settings.xml deploy -Pwith-docker-image -Dplatform=linux/amd64
```

## Containerizing, Registering and Deployment

Knowledge Agents builds all containers using docker technology. The docker buildfiles are part of the respective source code repositories.

### Containers

To build all artifacts (including compilation artifacts, tests and container images with the default target platform linux/amd64), you can invoke

```console
./mvnw -s settings.xml install -Pwith-docker-image
```

To build all artifacts especially for target platform linux/arm64, use this command

```console
./mvnw -s settings.xml install -Dplatform=linux/arm64 -Pwith-docker-image
```
### Registry

To register all artifacts (including compilation artifacts, tests and container images) into their respective registries, you can invoke

```console
./mvnw -s settings.xml deploy -Pwith-docker-image
```

### Deployment

Agents KIT containers will be deployed very individually.
We provide a sample environment (dataspace consisting of three business partners) using docker-compose (for local deployment) and helm (for cloud/cluster deployment) technology. 
The docker compose files and helm charts can be found in the  [infrastructure](infrastructure) folder.

## Running Against the Services and APIs / Integration Tests

You may use/export/fork this online [Postman Workspace/Collecion](https://www.postman.com/catena-x/workspace/catena-x-knowledge-agents/collection/2757771-6a1813a3-766d-42e2-962d-3b340fbba397?action=share&creator=2757771) a copy of which is embedded [here](cx_ka.postman_collection.json). 
It contains collection of sample interactions with the various sub-products in several environments (e.g. [local](cx_ka.localhost.postman_environment.json), [development](cx_ka.development.postman_environment.json) and [integration](cx_ka.integration.postman_environment.json)) and tailored to the sample dataspace. 
Also integrated there is a folder with the integrations tests which are scripted and consective Postman actions which test features and state changes within the target environment. This is used in the [Github Integration Test Workflow](.github/workflows/integrationtest.yaml).






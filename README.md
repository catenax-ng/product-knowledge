# Catena-X Knowledge Agents (Hey Catena!) Product Sources

This is a [MonoRepo](https://en.wikipedia.org/wiki/Monorepo) linking all the modules and infrastructure codes related to the Hey Catena! product.

* See this [copyright notice](COPYRIGHT.md)
* See the [authors file](AUTHORS.md)
* See the [license file](LICENSE.md)
* See the [code of conduct](CODE_OF_CONDUCT.md)
* See the [contribution guidelines](CONTRIBUTING.md)
* See the [dependencies and their licenses](DEPENDENCIES.md)

The individual sources may be maintained in separate repositories, but are linked as [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) 
so be sure to run the following command after cloning this repo:

```console
git submodule update --init
```

You may open this repository in a [Github Codespace](https://github.com/features/codespaces).

These are the sub-modules of the Hey Catena! product (and their respective sub-folders)

- [Ontology](ontology/README.md) hosts the CX ontology
- [Dataspace](dataspace/README.md) hosts the Dataspace extensions/implementations
- [UX](ux/README.md) hosts the User Experience components
- [Infrastructure](infrastructure/README.md) hosts the "Infrastructure as Code" descriptions

## Build

### Environment Variables

To interact with the required package and container registries, the following environment variables should be set

```console
export GITHUB_ACTOR=
export GITHUB_TOKEN=
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

## Containerizing, Registering and Deployment

Knowledge Agents builds all containers using docker technology. The docker buildfiles are part of the respective source code repositories.

### Containers

To build all artifacts (including compilation artifacts, tests and container images), you can invoke

```console
./mvnw -s settings.xml install -Pwith-docker-image
```

### Registry

To register all artifacts (including compilation artifacts, tests and container images) into their respective registries, you can invoke

```console
./mvnw -s settings.xml deploy -Pwith-docker-image
```

### Deployment

Knowledge Agents containers will be deployed very individually.

We provide a sample environment (dataspace consisting of three business partners) using docker-compose (for local deployment) and helm (for cloud/cluster deployment) technology. 

The docker compose files and helm charts can be found in the  [infrastructure](infrastructure) folder.

## Running Against the Services and APIs / Integration Tests

You may use/export/fork this online [Postman Workspace/Collecion](https://www.postman.com/catena-x/workspace/catena-x-knowledge-agents/collection/2757771-6a1813a3-766d-42e2-962d-3b340fbba397?action=share&creator=2757771) a copy of which is embedded [here](cx_ka_pilot.postman_collection.json). 

It contains collection of sample interactions with the various sub-products in several environments (e.g. local, integration) and tailored to the sample dataspace. 

Also integrated there is a folder with the integrations tests.




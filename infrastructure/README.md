# Catena-X Agent KIT Infrastructure As Code

This is a folder linking all the codes related to the Agent KIT (sample) Infrastructure. The sample
infrastructure sets up a sandbox dataspace with three business partners, a sample OEM, a tier-a SUPPLIER and a CONSUMER.

## Running Locally Via Docker Compose

In order to run the Sample Infrastructure locally, simply run the following command (in this folder)

```console
docker compose up
```

In case you changed some configuration or docker source, please run the following command (in this folder)

```console
docker compose build
```

## Deploying via Helm (or Argo CD)

In order to deploy the Sample Infrastructure, you should adapt the [default settings](values.yaml) and 
then run the following command (in this folder)

```console
helm install .
```

Alternatively, you could mount this folder in a deployment tool such as Argo CD and overwrite the [default settings](values.yaml)
via the frontend or the respective CLI.

## Infrastructure Descriptors

- [Chart.yaml](Chart.yaml) Top-Level Helm Descriptor for the complete chart/dataspace.
- [values.yaml](values.yaml) Default Helm Settings
- [_charts](_charts) Sub-Charts with reusable partial descriptors.
- [docker-compose.yml](docker-compose.yml) Docker Compose Descriptor for the complete dataspace.
- [resources](resources/) Resources that will be integrated/mounted by all dataspace participants.
- [oem](oem/) Resources that will be integrated/mounted by the OEM tenant.
- [tiera](tiera/) Resources that will be integrated/mounted by the SUPPLIER tenant.
- [consumer](consumer/) Resources that will be integrated/mounted by the CONSUMER tenant.
- [Readme.md](Readme.md) This file.
- 

- [Dataspace](dataspace/README.md) hosts reference implementations of the Gaia-X/IDS Dataspace extensions (Agents) for both Providers and Consumers which  the semantics of Catena-X.
- [UX](ux/README.md) hosts User Experience components and a sample portal/development environment for developing and executing semantically-driven logic and apps.
- [Infrastructure](infrastructure/README.md) hosts "Infrastructure as Code" descriptions for easy deployment of above artifacts including a sample dataspace consisting of three tenants (Consumer, OEM and supplier).

## Notice

* see copyright notice in the top folder
* see license file in the top folder
* see authors file in the top folder





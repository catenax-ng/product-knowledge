# agent-control-plane

![Version: 0.8.5-SNAPSHOT](https://img.shields.io/badge/Version-0.8.5--SNAPSHOT-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.8.5-SNAPSHOT](https://img.shields.io/badge/AppVersion-0.8.5--SNAPSHOT-informational?style=flat-square)

Agent-Enabled EDC Control-Plane - Eclipse DataSpaceConnector administration layer with Agent Protocols extensions

**Homepage:** <https://github.com/catenax-ng/product-knowledge/infrastructure/charts/agent-control-plane>

## TL;DR
```shell
$ helm repo add catenax-ng-product-knowledge https://catenax-ng.github.io/product-knowledge/infrastructure
$ helm install my-release catenax-ng-product-knowledge/agent-control-plane --version 0.8.5-SNAPSHOT
```

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Catena-X Knowledge Agents Team |  |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | [Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) constrains which nodes the Pod can be scheduled on based on node labels. |
| automountServiceAccountToken | bool | `false` | Whether to [automount kubernetes API credentials](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#use-the-default-service-account-to-access-the-api-server) into the pod |
| autoscaling.enabled | bool | `false` | Enables [horizontal pod autoscaling](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) |
| autoscaling.maxReplicas | int | `100` | Maximum replicas if resource consumption exceeds resource threshholds |
| autoscaling.minReplicas | int | `1` | Minimal replicas if resource consumption falls below resource threshholds |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | targetAverageUtilization of cpu provided to a pod |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` | targetAverageUtilization of memory provided to a pod |
| configuration.properties | string | `""` | EDC configuration.properties configuring aspects of the [eclipse-dataspaceconnector](https://github.com/eclipse-dataspaceconnector/DataSpaceConnector) |
| customLabels | object | `{}` | Additional custom Labels to add |
| dataplanes.agentplane.callback.auth | object | `{"code":null,"key":"X-Api-Key"}` | auth of the callback |
| dataplanes.agentplane.callback.auth.code | string | `nil` | auth code of the callback |
| dataplanes.agentplane.callback.auth.key | string | `"X-Api-Key"` | auth key of the callback |
| dataplanes.agentplane.callback.default | bool | `false` | whether it should appear as the default callback (only one can be active) |
| dataplanes.agentplane.callback.url | string | `"http://edc-dataplane.intranet:8082/callback/endpoint-data-reference"` | callback interface of the agent plane |
| dataplanes.agentplane.destinationtypes | list | `["HttpProxy","HttpProtocol"]` | list of transfer protocols [HttpProxy, HttpProtocol, S3] |
| dataplanes.agentplane.publicurl | string | `"https://edc-dataplane.local/api/public"` | transfer/public interface of the agent plane |
| dataplanes.agentplane.sourcetypes | list | `["urn:cx:Protocol:w3c:Http#SPARQL","HttpData"]` | list of backend protocols [urn:cx:Protocol:w3c:Http#SPARQL, HttpData, S3] |
| dataplanes.agentplane.url | string | `"http://edc-dataplane.intranet:8082/"` | control interface of the agent plane |
| edc.endpoints.control.auth | object | `{}` | Sets the control auth |
| edc.endpoints.control.path | string | `"/api/controlplane/control"` | The path mapping the "control" api is going to be exposed at |
| edc.endpoints.control.port | string | `"9999"` | The network port, which the "control" api is going to be exposed by the container, pod and service |
| edc.endpoints.data.path | string | `"/data"` | The path mapping the "data" management api is going to be exposed at |
| edc.endpoints.data.port | string | `"8181"` | The network port, which the "data" management api is going to be exposed by the container, pod and service |
| edc.endpoints.default.auth | object | `{}` | Sets the default auth  |
| edc.endpoints.default.path | string | `"/api"` | The path mapping the "default" api is going to be exposed at |
| edc.endpoints.default.port | string | `"8080"` | The network port, which the "default" api is going to be exposed by the container, pod and service |
| edc.endpoints.ids.path | string | `"/api/v1/ids"` | The path mapping the "ids" multipart api is going to be exposed at |
| edc.endpoints.ids.port | string | `"8282"` | The network port, which the "ids" multipart api is going to be exposed by the container, pod and service |
| edc.endpoints.metrics.path | string | `"/metrics"` | The path mapping the prometheus metrics are going to be exposed at |
| edc.endpoints.metrics.port | string | `"9090"` | The network port, which the prometheus metrics are going to be exposed by the container, pod and service |
| edc.endpoints.validation.path | string | `"/validation"` | The path mapping the "validation" api is going to be exposed at |
| edc.endpoints.validation.port | string | `"8182"` | The network port, which the "validation" api is going to be exposed by the container, pod and service |
| env | object | `{}` | Container environment variables e.g. for configuring [JAVA_TOOL_OPTIONS](https://docs.oracle.com/javase/8/docs/technotes/guides/troubleshoot/envvars002.html) Ex.:   JAVA_TOOL_OPTIONS: >     -Dhttp.proxyHost=proxy -Dhttp.proxyPort=80 -Dhttp.nonProxyHosts="localhost|127.*|[::1]" -Dhttps.proxyHost=proxy -Dhttps.proxyPort=443 |
| envSecretName | string | `nil` | [Kubernetes Secret Resource](https://kubernetes.io/docs/concepts/configuration/secret/) name to load environment variables from |
| fullnameOverride | string | `""` | Overrides the releases full name |
| image.pullPolicy | string | `"IfNotPresent"` | [Kubernetes image pull policy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy) to use |
| image.repository | string | `"ghcr.io/catenax-ng/product-knowledge/controlplane-memory"` | Which derivate of the agent-enabled edc control-plane to use. One of: [ghcr.io/catenax-ng/product-knowledge/controlplane-memory, ghcr.io/catenax-ng/product-knowledge/controlplane-memory-hashicorp, ghcr.io/catenax-ng/product-knowledge/controlplane-postgresql-hashicorp] |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecret.dockerconfigjson | string | `""` | Image pull secret to create to [obtain the container image from private registries](https://kubernetes.io/docs/concepts/containers/images/#using-a-private-registry) Note: This value needs to adhere to the [(base64 encoded) .dockerconfigjson format](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/#registry-secret-existing-credentials). Furthermore, if 'imagePullSecret.dockerconfigjson' is defined, it takes precedence over 'imagePullSecrets'. |
| imagePullSecrets | list | `[]` | Existing image pull secret to use to [obtain the container image from private registries](https://kubernetes.io/docs/concepts/containers/images/#using-a-private-registry) |
| ingresses[0].annotations | object | `{}` | Additional ingress annotations to add |
| ingresses[0].certManager.clusterIssuer | string | `""` | If preset enables certificate generation via cert-manager cluster-wide issuer |
| ingresses[0].certManager.issuer | string | `""` | If preset enables certificate generation via cert-manager namespace scoped issuer |
| ingresses[0].className | string | `""` | Defines the [ingress class](https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-class)  to use |
| ingresses[0].enabled | bool | `true` |  |
| ingresses[0].endpoints | list | `["ids"]` | EDC endpoints exposed by this ingress resource |
| ingresses[0].hostname | string | `"edc-controlplane.local"` | The hostname to be used to precisely map incoming traffic onto the underlying network service |
| ingresses[0].prefix | string | `""` | An additional prefix to put before the endpoint path, if any |
| ingresses[0].tls | object | `{"enabled":false,"secretName":""}` | TLS [tls class](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls) applied to the ingress resource |
| ingresses[0].tls.enabled | bool | `false` | Enables TLS on the ingress resource |
| ingresses[0].tls.secretName | string | `""` | If present overwrites the default secret name |
| ingresses[1].annotations | object | `{}` | Additional ingress annotations to add |
| ingresses[1].certManager.clusterIssuer | string | `""` | If preset enables certificate generation via cert-manager cluster-wide issuer |
| ingresses[1].certManager.issuer | string | `""` | If preset enables certificate generation via cert-manager namespace scoped issuer |
| ingresses[1].className | string | `""` | Defines the [ingress class](https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-class)  to use |
| ingresses[1].enabled | bool | `false` |  |
| ingresses[1].endpoints | list | `["data","control"]` | EDC endpoints exposed by this ingress resource |
| ingresses[1].hostname | string | `"edc-controlplane.intranet"` | The hostname to be used to precisely map incoming traffic onto the underlying network service |
| ingresses[1].prefix | string | `""` | An additional prefix to put before the endpoint path, if any |
| ingresses[1].tls | object | `{"enabled":false,"secretName":""}` | TLS [tls class](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls) applied to the ingress resource |
| ingresses[1].tls.enabled | bool | `false` | Enables TLS on the ingress resource |
| ingresses[1].tls.secretName | string | `""` | If present overwrites the default secret name |
| livenessProbe.enabled | bool | `true` | Whether to enable kubernetes [liveness-probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| logging.properties | string | `".level=INFO\norg.eclipse.dataspaceconnector.level=ALL\nhandlers=java.util.logging.ConsoleHandler\njava.util.logging.ConsoleHandler.formatter=java.util.logging.SimpleFormatter\njava.util.logging.ConsoleHandler.level=ALL\njava.util.logging.SimpleFormatter.format=[%1$tY-%1$tm-%1$td %1$tH:%1$tM:%1$tS] [%4$-7s] %5$s%6$s%n"` | EDC logging.properties configuring the [java.util.logging subsystem](https://docs.oracle.com/javase/7/docs/technotes/guides/logging/overview.html#a1.8) |
| nameOverride | string | `""` | Overrides the charts name |
| nodeSelector | object | `{}` | [Node-Selector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) to constrain the Pod to nodes with specific labels. |
| oauth | object | `{}` | An oauth table/map to configure the vault |
| opentelemetry.properties | string | `"otel.javaagent.enabled=true\notel.javaagent.debug=false"` | opentelemetry.properties configuring the [opentelemetry agent](https://opentelemetry.io/docs/instrumentation/java/automatic/agent-config/) |
| podAnnotations | object | `{}` | [Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/) added to deployed [pods](https://kubernetes.io/docs/concepts/workloads/pods/) |
| podSecurityContext.fsGroup | int | `10001` | The owner for volumes and any files created within volumes will belong to this guid |
| podSecurityContext.runAsGroup | int | `10001` | Processes within a pod will belong to this guid |
| podSecurityContext.runAsUser | int | `10001` | Runs all processes within a pod with a special uid |
| podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` | Restrict a Container's Syscalls with seccomp |
| readinessProbe.enabled | bool | `true` | Whether to enable kubernetes readiness-probes |
| replicaCount | int | `1` | Specifies how many replicas of a deployed pod shall be created during the deployment Note: If horizontal pod autoscaling is enabled this setting has no effect |
| resources | object | `{}` | [Resource management](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) applied to the deployed pod |
| securityContext.allowPrivilegeEscalation | bool | `false` | Controls [Privilege Escalation](https://kubernetes.io/docs/concepts/security/pod-security-policy/#privilege-escalation) enabling setuid binaries changing the effective user ID |
| securityContext.capabilities.add | list | `[]` | Specifies which capabilities to add to issue specialized syscalls |
| securityContext.capabilities.drop | list | `["ALL"]` | Specifies which capabilities to drop to reduce syscall attack surface |
| securityContext.readOnlyRootFilesystem | bool | `true` | Whether the root filesystem is mounted in read-only mode |
| securityContext.runAsNonRoot | bool | `true` | Requires the container to run without root privileges |
| securityContext.runAsUser | int | `10001` | The container's process will run with the specified uid |
| service.type | string | `"ClusterIP"` | [Service type](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types) to expose the running application on a set of Pods as a network service. |
| serviceAccount.annotations | object | `{}` | [Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/) to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a [service account](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/) should be created per release |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the release's fullname template |
| startupProbe.enabled | bool | `true` | Whether to enable kubernetes startup-probes |
| startupProbe.failureThreshold | int | `12` | Minimum consecutive failures for the probe to be considered failed after having succeeded |
| startupProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before liveness probes are initiated. |
| tolerations | list | `[]` | [Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) are applied to Pods to schedule onto nodes with matching taints. |
| transfer.proxy.token | object | `{}` |  |
| vault | object | `{}` | A vault table/map to configure the vault |
| vault.certificate | string | `"VAULT_CERTIFICATE"` |  |
| vault.clientid | string | `"VAULT_CLIENT"` |  |
| vault.clientsecret | string | `"VAULT_SECRET"` |  |
| vault.hashicorp.checkStandby | bool | `true` |  |
| vault.hashicorp.healthCheck | bool | `false` |  |
| vault.hashicorp.path | string | `"VAULT_PATH"` |  |
| vault.hashicorp.timeout | string | `"VAULT_TIMEOUT"` |  |
| vault.hashicorp.token | string | `"VAULT_TOKEN"` |  |
| vault.hashicorp.url | string | `"VAULT_URL"` |  |
| vault.name | string | `"VAULT_NAME"` |  |
| vault.tenantid | string | `"VAULT_TENANT"` |  |
| vault.url | string | `"VAULT_URL"` |  |
| volumeMounts | list | `[]` | Additional volumeMounts to the controlplane main container |
| volumes | list | `[]` | Additional volumes to the controlplane pod |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)

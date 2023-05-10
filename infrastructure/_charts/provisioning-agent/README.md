# provisioning-agent

![Version: 0.8.6-SNAPSHOT](https://img.shields.io/badge/Version-0.8.5--SNAPSHOT-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.8.6-SNAPSHOT](https://img.shields.io/badge/AppVersion-0.8.5--SNAPSHOT-informational?style=flat-square)

Catena-X Provisioning Agent - Knowledge-Agents Compatible Data Binding Layer

**Homepage:** <https://github.com/catenax-ng/product-knowledge/infrastructure/charts/provisioning-agent>

## TL;DR
```shell
$ helm repo add catenax-ng-product-knowledge https://catenax-ng.github.io/product-knowledge/infrastructure
$ helm install my-release catenax-ng-product-knowledge/provisioning-agent --version 0.8.6-SNAPSHOT
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
| bindings.dtc | object | `{"mapping":"[PrefixDeclaration]\ncx:\t\t\thttps://github.com/catenax-ng/product-knowledge/ontology/cx.ttl#\ncx-diag:\thttps://github.com/catenax-ng/product-knowledge/ontology/diagnosis.ttl#\nowl:\t\thttp://www.w3.org/2002/07/owl#\nrdf:\t\thttp://www.w3.org/1999/02/22-rdf-syntax-ns#\nxml:\t\thttp://www.w3.org/XML/1998/namespace\nxsd:\t\thttp://www.w3.org/2001/XMLSchema#\nobda:\t\thttps://w3id.org/obda/vocabulary#\nrdfs:\t\thttp://www.w3.org/2000/01/rdf-schema#\n\n[MappingDeclaration] @collection [[\nmappingId\tdtc-meta\ntarget\t\tcx:BusinessPartner/{bpnl} rdf:type cx:BusinessPartner ; cx:BPNL {bpnl}^^xsd:string . \nsource\t\tSELECT distinct \"bpnl\" FROM \"dtc\".\"meta\"\n\nmappingId\tdtc-content\ntarget\t\tcx-diag:DTC/{id} rdf:type cx-diag:DTC ; cx-diag:Code {code}^^xsd:string ; cx-diag:Description {description}^^xsd:string ; cx-diag:PossibleCauses {possible_causes}^^xsd:string ; cx-diag:Version {lock_version}^^xsd:long . \nsource\t\tSELECT * FROM \"dtc\".\"content\"\n\nmappingId\tdtc-meta-content\ntarget\t\tcx-diag:DTC/{id} cx:provisionedBy cx:BusinessPartner/{bpnl}. \nsource\t\tSELECT \"bpnl\",\"id\" FROM \"dtc\".\"content\"\n\nmappingId\tdtc-part\ntarget\t\tcx-diag:DiagnosedPart/{entityGuid} rdf:type cx-diag:DTCPart ; cx-diag:EnDenomination {enDenomination}^^xsd:string ; cx-diag:Classification {classification}^^xsd:string ; cx-diag:Category {category}^^xsd:string.\nsource\t\tSELECT * FROM \"dtc\".\"part\"\n\nmappingId\tdtc-part-content\ntarget\t\tcx-diag:DTC/{dtc_id} cx-diag:affects cx-diag:DiagnosedPart/{part_entityGuid}. \nsource\t\tSELECT \"part_entityGuid\",\"dtc_id\" FROM \"dtc\".\"content_part\"\n\nmappingId\tdtc-meta-part\ntarget\t\tcx-diag:DiagnosedPart/{entityGuid} cx:provisionedBy cx:BusinessPartner/{bpnl}. \nsource\t\tSELECT \"bpnl\",\"entityGuid\" FROM \"dtc\".\"part\"\n]]","ontology":"cx-ontology.xml","path":"(/|$)(.*)","port":8080,"settings":{"jdbc.driver":"org.h2.Driver","jdbc.url":"jdbc:h2:file:/opt/ontop/database/db;INIT=RUNSCRIPT FROM '/opt/ontop/data/dtc.sql'"}}` | Diagnostic trouble code endpoint/binding |
| customLabels | object | `{}` | Additional custom Labels to add |
| env | object | `{}` | Container environment variables e.g. for configuring [JAVA_TOOL_OPTIONS](https://docs.oracle.com/javase/8/docs/technotes/guides/troubleshoot/envvars002.html) Ex.:   JAVA_TOOL_OPTIONS: >     -Dhttp.proxyHost=proxy -Dhttp.proxyPort=80 -Dhttp.nonProxyHosts="localhost|127.*|[::1]" -Dhttps.proxyHost=proxy -Dhttps.proxyPort=443 |
| envSecretName | string | `nil` | [Kubernetes Secret Resource](https://kubernetes.io/docs/concepts/configuration/secret/) name to load environment variables from |
| fullnameOverride | string | `""` | Overrides the releases full name |
| image.pullPolicy | string | `"IfNotPresent"` | [Kubernetes image pull policy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy) to use |
| image.repository | string | `"ghcr.io/catenax-ng/product-knowledge/provisioning-agent"` | Which derivate of the provisioning agent to use |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion |
| imagePullSecret.dockerconfigjson | string | `""` | Image pull secret to create to [obtain the container image from private registries](https://kubernetes.io/docs/concepts/containers/images/#using-a-private-registry) Note: This value needs to adhere to the [(base64 encoded) .dockerconfigjson format](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/#registry-secret-existing-credentials). Furthermore, if 'imagePullSecret.dockerconfigjson' is defined, it takes precedence over 'imagePullSecrets'. |
| imagePullSecrets | list | `[]` | Existing image pull secret to use to [obtain the container image from private registries](https://kubernetes.io/docs/concepts/containers/images/#using-a-private-registry) |
| ingresses[0].annotations | object | `{"nginx.ingress.kubernetes.io/rewrite-target":"/$2","nginx.ingress.kubernetes.io/use-regex":"true"}` | Additional ingress annotations to add |
| ingresses[0].certManager.clusterIssuer | string | `""` | If preset enables certificate generation via cert-manager cluster-wide issuer |
| ingresses[0].certManager.issuer | string | `""` | If preset enables certificate generation via cert-manager namespace scoped issuer |
| ingresses[0].className | string | `""` | Defines the [ingress class](https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-class)  to use |
| ingresses[0].enabled | bool | `true` |  |
| ingresses[0].endpoints | list | `["dtc"]` | Agent endpoints exposed by this ingress resource |
| ingresses[0].hostname | string | `"provisioning-agent.local"` | The hostname to be used to precisely map incoming traffic onto the underlying network service |
| ingresses[0].tls | object | `{"enabled":false,"secretName":""}` | TLS [tls class](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls) applied to the ingress resource |
| ingresses[0].tls.enabled | bool | `false` | Enables TLS on the ingress resource |
| ingresses[0].tls.secretName | string | `""` | If present overwrites the default secret name |
| livenessProbe.enabled | bool | `true` | Whether to enable kubernetes [liveness-probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| livenessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the probe to be considered failed after having succeeded |
| livenessProbe.periodSeconds | int | `60` | Number of seconds each period lasts.   |
| livenessProbe.successThreshold | int | `1` | number of successful tries which reenables liveness |
| livenessProbe.timeoutSeconds | int | `5` | number of seconds until a timeout is assumed |
| nameOverride | string | `""` | Overrides the charts name |
| nodeSelector | object | `{}` | [Node-Selector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) to constrain the Pod to nodes with specific labels. |
| ontologies | object | `{"cx-ontology.ttl":"resources/cx-ontology.ttl","cx-ontology.xml":"resources/cx-ontology.xml"}` | Ontologies to be included |
| podAnnotations | object | `{}` | [Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/) added to deployed [pods](https://kubernetes.io/docs/concepts/workloads/pods/) |
| podSecurityContext.fsGroup | int | `30000` | The owner for volumes and any files created within volumes will belong to this guid |
| podSecurityContext.runAsGroup | int | `30000` | Processes within a pod will belong to this guid |
| podSecurityContext.runAsUser | int | `10000` | Runs all processes within a pod with a special uid |
| podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` | Restrict a Container's Syscalls with seccomp |
| readinessProbe.enabled | bool | `true` | Whether to enable kubernetes readiness-probes |
| readinessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the probe to be considered failed after having succeeded |
| readinessProbe.periodSeconds | int | `300` | Number of seconds each period lasts.   |
| readinessProbe.successThreshold | int | `1` | number of successful tries which reenables liveness |
| readinessProbe.timeoutSeconds | int | `5` | number of seconds until a timeout is assumed |
| replicaCount | int | `1` | Specifies how many replicas of a deployed pod shall be created during the deployment Note: If horizontal pod autoscaling is enabled this setting has no effect |
| resources | object | `{}` | [Resource management](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) applied to the deployed pod |
| securityContext.allowPrivilegeEscalation | bool | `false` | Controls [Privilege Escalation](https://kubernetes.io/docs/concepts/security/pod-security-policy/#privilege-escalation) enabling setuid binaries changing the effective user ID |
| securityContext.capabilities.add | list | `["NET_BIND_SERVICE"]` | Specifies which capabilities to add to issue specialized syscalls |
| securityContext.capabilities.drop | list | `["ALL"]` | Specifies which capabilities to drop to reduce syscall attack surface |
| securityContext.readOnlyRootFilesystem | bool | `false` | Whether the root filesystem is mounted in read-only mode |
| securityContext.runAsNonRoot | bool | `true` | Requires the container to run without root privileges |
| securityContext.runAsUser | int | `10000` | The container's process will run with the specified uid |
| service.type | string | `"ClusterIP"` | [Service type](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types) to expose the running application on a set of Pods as a network service. |
| serviceAccount.annotations | object | `{}` | [Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/) to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a [service account](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/) should be created per release |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the release's fullname template |
| startupProbe.enabled | bool | `true` | Whether to enable kubernetes startup-probes |
| startupProbe.failureThreshold | int | `18` | Minimum consecutive failures for the probe to be considered failed after having succeeded |
| startupProbe.initialDelaySeconds | int | `60` | Number of seconds after the container has started before liveness probes are initiated. |
| startupProbe.periodSeconds | int | `30` | Number of seconds each period lasts.   |
| startupProbe.successThreshold | int | `1` | number of successful tries which reenables liveness |
| startupProbe.timeoutSeconds | int | `5` | number of seconds until a timeout is assumed |
| tolerations | list | `[]` | [Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) are applied to Pods to schedule onto nodes with matching taints. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)

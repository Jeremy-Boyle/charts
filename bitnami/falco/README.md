# Falco

[Falco](https://falco.org) is a *Cloud Native Runtime Security* tool designed to detect anomalous activity in your applications. You can use Falco to monitor runtime security of your Kubernetes applications and internal components.

## TL;DR

```console
$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm install my-release bitnami/falco
```

## Introduction

This chart adds Falco to all nodes in your cluster using a DaemonSet.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure
- ReadWriteMany volumes for deployment scaling

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release bitnami/falco
```

The command deploys falco on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`  |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |
| `global.storageClass`     | Global StorageClass for Persistent Volume(s)    | `""`  |


### Common parameters

| Name                | Description                                       | Value           |
| ------------------- | ------------------------------------------------- | --------------- |
| `kubeVersion`       | Override Kubernetes version                       | `""`            |
| `nameOverride`      | String to partially override common.names.name    | `""`            |
| `fullnameOverride`  | String to fully override common.names.fullname    | `""`            |
| `namespaceOverride` | String to fully override common.names.namespace   | `""`            |
| `commonLabels`      | Labels to add to all deployed objects             | `{}`            |
| `commonAnnotations` | Annotations to add to all deployed objects        | `{}`            |
| `clusterDomain`     | Kubernetes cluster domain name                    | `cluster.local` |
| `extraDeploy`       | Array of extra objects to deploy with the release | `[]`            |


### Falco Daemonset Parameters

| Name                                        | Description                                                                                     | Value                 |
| ------------------------------------------- | ----------------------------------------------------------------------------------------------- | --------------------- |
| `falco.enabled`                             | Deploy Falco daemonset to the cluster                                                           | `true`                |
| `falco.image.registry`                      | Falco image registry                                                                            | `docker.io`           |
| `falco.image.repository`                    | Falco image repository                                                                          | `falcosecurity/falco` |
| `falco.image.tag`                           | Falco image tag (immutable tags are recommended)                                                | `0.31.1`              |
| `falco.image.pullPolicy`                    | Falco image pull policy                                                                         | `IfNotPresent`        |
| `falco.image.pullSecrets`                   | Falco image pull secrets                                                                        | `[]`                  |
| `falco.replicaCount`                        | Number of Falco replicas to deploy                                                              | `1`                   |
| `falco.containerPorts.http`                 | Falco HTTP container port                                                                       | `8765`                |
| `falco.livenessProbe.enabled`               | Enable livenessProbe on Falco containers                                                        | `true`                |
| `falco.livenessProbe.initialDelaySeconds`   | Initial delay seconds for livenessProbe                                                         | `60`                  |
| `falco.livenessProbe.periodSeconds`         | Period seconds for livenessProbe                                                                | `15`                  |
| `falco.livenessProbe.timeoutSeconds`        | Timeout seconds for livenessProbe                                                               | `5`                   |
| `falco.readinessProbe.enabled`              | Enable readinessProbe on Falco containers                                                       | `true`                |
| `falco.readinessProbe.initialDelaySeconds`  | Initial delay seconds for readinessProbe                                                        | `30`                  |
| `falco.readinessProbe.periodSeconds`        | Period seconds for readinessProbe                                                               | `15`                  |
| `falco.readinessProbe.timeoutSeconds`       | Timeout seconds for readinessProbe                                                              | `5`                   |
| `falco.customLivenessProbe`                 | Custom livenessProbe that overrides the default one                                             | `{}`                  |
| `falco.customReadinessProbe`                | Custom readinessProbe that overrides the default one                                            | `{}`                  |
| `falco.customStartupProbe`                  | Custom startupProbe that overrides the default one                                              | `{}`                  |
| `falco.resources.limits`                    | The resources limits for the Falco containers                                                   | `{}`                  |
| `falco.resources.requests`                  | The requested resources for the Falco containers                                                | `{}`                  |
| `falco.containerSecurityContext.enabled`    | Enabled Falco containers' Security Context                                                      | `true`                |
| `falco.containerSecurityContext.privileged` | Run as privileged                                                                               | `true`                |
| `falco.existingConfigmap`                   | The name of an existing ConfigMap with your custom configuration for falco                      | `nil`                 |
| `falco.extraArgs`                           | Additional arguments passed to falco                                                            | `[]`                  |
| `falco.hostAliases`                         | Falco pods host aliases                                                                         | `[]`                  |
| `falco.podLabels`                           | Extra labels for Falco pods                                                                     | `{}`                  |
| `falco.podAnnotations`                      | Annotations for Falco pods                                                                      | `{}`                  |
| `falco.podAffinityPreset`                   | Pod affinity preset. Ignored if `falco.affinity` is set. Allowed values: `soft` or `hard`       | `""`                  |
| `falco.podAntiAffinityPreset`               | Pod anti-affinity preset. Ignored if `falco.affinity` is set. Allowed values: `soft` or `hard`  | `""`                  |
| `falco.pdb.create`                          | Enable/disable a Pod Disruption Budget creation                                                 | `false`               |
| `falco.pdb.minAvailable`                    | Minimum number/percentage of pods that should remain scheduled                                  | `1`                   |
| `falco.pdb.maxUnavailable`                  | Maximum number/percentage of pods that may be made unavailable                                  | `""`                  |
| `falco.autoscaling.enabled`                 | Enable autoscaling for falco                                                                    | `false`               |
| `falco.autoscaling.minReplicas`             | Minimum number of Falco replicas                                                                | `""`                  |
| `falco.autoscaling.maxReplicas`             | Maximum number of Falco replicas                                                                | `""`                  |
| `falco.autoscaling.targetCPU`               | Target CPU utilization percentage                                                               | `""`                  |
| `falco.autoscaling.targetMemory`            | Target Memory utilization percentage                                                            | `""`                  |
| `falco.nodeAffinityPreset.type`             | Node affinity preset type. Ignored if `falco.affinity` is set. Allowed values: `soft` or `hard` | `""`                  |
| `falco.nodeAffinityPreset.key`              | Node label key to match. Ignored if `falco.affinity` is set                                     | `""`                  |
| `falco.nodeAffinityPreset.values`           | Node label values to match. Ignored if `falco.affinity` is set                                  | `[]`                  |
| `falco.affinity`                            | Affinity for Falco pods assignment                                                              | `{}`                  |
| `falco.nodeSelector`                        | Node labels for Falco pods assignment                                                           | `{}`                  |
| `falco.tolerations`                         | Tolerations for Falco pods assignment                                                           | `[]`                  |
| `falco.updateStrategy.type`                 | Falco daemonset strategy type                                                                   | `RollingUpdate`       |
| `falco.priorityClassName`                   | Falco pods' priorityClassName                                                                   | `""`                  |
| `falco.terminationGracePeriodSeconds`       | Seconds Airflow web pod needs to terminate gracefully                                           | `""`                  |
| `falco.lifecycleHooks`                      | for the Falco container(s) to automate configuration before or after startup                    | `{}`                  |
| `falco.extraEnvVars`                        | Array with extra environment variables to add to Falco nodes                                    | `[]`                  |
| `falco.extraEnvVarsCM`                      | Name of existing ConfigMap containing extra env vars for Falco nodes                            | `""`                  |
| `falco.extraEnvVarsSecret`                  | Name of existing Secret containing extra env vars for Falco nodes                               | `""`                  |
| `falco.extraVolumes`                        | Optionally specify extra list of additional volumes for the Falco pod(s)                        | `[]`                  |
| `falco.extraVolumeMounts`                   | Optionally specify extra list of additional volumeMounts for the Falco container(s)             | `[]`                  |
| `falco.sidecars`                            | Add additional sidecar containers to the Falco pod(s)                                           | `{}`                  |
| `falco.initContainers`                      | Add additional init containers to the Falco pod(s)                                              | `{}`                  |


### Traffic Exposure Parameters

| Name                                     | Description                                                                      | Value       |
| ---------------------------------------- | -------------------------------------------------------------------------------- | ----------- |
| `falco.service.type`                     | Falco service type                                                               | `ClusterIP` |
| `falco.service.ports.http`               | Falco service HTTP port                                                          | `8765`      |
| `falco.service.nodePorts.http`           | Node port for HTTP                                                               | `""`        |
| `falco.service.clusterIP`                | Falco service Cluster IP                                                         | `""`        |
| `falco.service.loadBalancerIP`           | Falco service Load Balancer IP                                                   | `""`        |
| `falco.service.loadBalancerSourceRanges` | Falco service Load Balancer sources                                              | `[]`        |
| `falco.service.externalTrafficPolicy`    | Falco service external traffic policy                                            | `Cluster`   |
| `falco.service.annotations`              | Additional custom annotations for Falco service                                  | `{}`        |
| `falco.service.extraPorts`               | Extra ports to expose in Falco service (normally used with the `sidecars` value) | `[]`        |
| `falco.service.sessionAffinity`          | Control where client requests go, to the same pod or round-robin                 | `None`      |
| `falco.service.sessionAffinityConfig`    | Additional settings for the sessionAffinity                                      | `{}`        |


### Other Parameters

| Name                                                | Description                                                      | Value   |
| --------------------------------------------------- | ---------------------------------------------------------------- | ------- |
| `falco.rbac.create`                                 | Specifies whether RBAC resources should be created               | `true`  |
| `falco.rbac.rules`                                  | Custom RBAC rules to set                                         | `[]`    |
| `falco.serviceAccount.create`                       | Specifies whether a ServiceAccount should be created             | `true`  |
| `falco.serviceAccount.name`                         | The name of the ServiceAccount to use.                           | `""`    |
| `falco.serviceAccount.annotations`                  | Additional Service Account annotations (evaluated as a template) | `{}`    |
| `falco.serviceAccount.automountServiceAccountToken` | Automount service account token for the server service account   | `false` |


### Falco Parameters

| Name                                         | Description                                                                                                    | Value                                                 |
| -------------------------------------------- | -------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| `falco.kubernetes.enabled`                   | Enable Kubernetes meta data collection via a connection to the Kubernetes API server                           | `true`                                                |
| `falco.kubernetes.apiAuth`                   | Authentication method to connect to the Kubernetes API.                                                        | `/var/run/secrets/kubernetes.io/serviceaccount/token` |
| `falco.kubernetes.apiUrl`                    | Authentication url to connect to the Kubernetes API.                                                           | `https://$(KUBERNETES_SERVICE_HOST)`                  |
| `falco.kubernetes.enableNodeFilter`          | If true, only the current node (on which Falco is running) will be considered when requesting metadata of pods | `true`                                                |
| `falco.webserver.enabled`                    | Enables webserver for Falco that listens for Audit Events                                                      | `true`                                                |
| `falco.webserver.k8sAuditEndpoint`           | Endpoint where Falco embedded webserver accepts K8s audit events                                               | `/k8s-audit`                                          |
| `falco.webserver.k8sHealthzEndpoint`         | Endpoint where Falco exposes the health status                                                                 | `/healthz`                                            |
| `falco.webserver.tls.enabled`                | Enabled TLS/SSL for falco.webserver                                                                            | `true`                                                |
| `falco.webserver.tls.createTlsSecret`        | Allow Helm to create self signed certificate                                                                   | `true`                                                |
| `falco.webserver.tls.hostname`               | Hostname for CA certificate                                                                                    | `localhost`                                           |
| `falco.webserver.tls.existingTlsSecret`      | Name of existing secret containing tls.key, tls.crt, ca.crt                                                    | `""`                                                  |
| `falco.webserver.tls.certificatesMountPath`  | Where falco.webserver certificates are mounted.                                                                | `/opt/bitnami/falco/conf/certs`                       |
| `falco.grpc.enabled`                         | Enabled grpc for Falco                                                                                         | `false`                                               |
| `falco.grpc.threadiness`                     | The number of threads (and context) Falco will use                                                             | `0`                                                   |
| `falco.grpc.unixSocketPath`                  | gRPC unix socket path with no authentication                                                                   | `unix:///var/run/falco/falco.sock`                    |
| `falco.grpc.tls.enabled`                     | Enabled TLS/SSL for falco.grpc, uses the same certs as falco.webserver.tls                                     | `false`                                               |
| `falco.grpc.tls.listenPort`                  | falco.grpc port to listen on                                                                                   | `5060`                                                |
| `falco.grpc.output.enabled`                  | Enable the gRPC output and events will be kept in memory until you read them with a gRPC client                | `false`                                               |
| `falco.ebpf.enabled`                         | Enable eBPF support for Falco instead of `falco-probe` kernel module                                           | `false`                                               |
| `falco.ebpf.path`                            | Specifies the to path ebpf probe                                                                               | `""`                                                  |
| `falco.ebpf.settings.hostNetwork`            | Enable eBPF JIT at runtime for performance                                                                     | `true`                                                |
| `falco.ebpf.settings.leastPrivileged`        | Enable leastPrivilege for Falco requires kernel >= 5.8 and falco.ebpf.enabled                                  | `false`                                               |
| `falco.docker.enabled`                       | Enable docker use for falco                                                                                    | `true`                                                |
| `falco.docker.socket`                        | Path to docker.sock                                                                                            | `/var/run/docker.sock`                                |
| `falco.containerd.enabled`                   | Enable containerd use for falco                                                                                | `true`                                                |
| `falco.containerd.socket`                    | Path to containerd.sock                                                                                        | `/run/containerd/containerd.sock`                     |
| `falco.crio.enabled`                         | Enable crio use for falco                                                                                      | `true`                                                |
| `falco.crio.socket`                          | Path to crio.sock                                                                                              | `/run/crio/crio.sock`                                 |
| `falco.auditLog.enabled`                     | Enable K8s Audit Log feature for Falco                                                                         | `true`                                                |
| `falco.auditLog.dynamicBackend.enabled`      | Creates an AuditSink which will receive audit logs                                                             | `true`                                                |
| `falco.auditLog.dynamicBackend.url`          | AuditSink fixed url                                                                                            | `""`                                                  |
| `falco.customRules`                          | Third party rules enabled for Falco                                                                            | `{}`                                                  |
| `falco.rulesFile`                            | Location of the rules file(s)                                                                                  | `[]`                                                  |
| `falco.plugins`                              | Plugins to enable                                                                                              | `[]`                                                  |
| `falco.loadPlugins`                          | Plugins to enable                                                                                              | `[]`                                                  |
| `falco.logLevel`                             | Minimum log level to include in logs                                                                           | `info`                                                |
| `falco.priority`                             | Minimum priority level to load and run                                                                         | `debug`                                               |
| `falco.timeFormatISO8601`                    | Times displayed in log messages and output messages will be in ISO 8601                                        | `false`                                               |
| `falco.output_timeout`                       | Specifies the duration in milliseconds to wait before considering the deadline exceed.                         | `2000`                                                |
| `falco.bufferedOutputs`                      | Enable buffered outputs to any of the output channels                                                          | `false`                                               |
| `falco.outputs.rate`                         | The number of tokens (i.e. right to send a notification) gained per second. Defaults to 1                      | `1`                                                   |
| `falco.outputs.maxBurst`                     | The maximum number of tokens outstanding. Defaults to 1000.                                                    | `1000`                                                |
| `falco.jsonOutput`                           | Enable output events in json                                                                                   | `false`                                               |
| `falco.jsonIncludeOutputProperty`            | When using json output, whether or not to include the "output" property                                        | `true`                                                |
| `falco.jsonIncludeTagsProperty`              | When using json output, whether or not to include the "tags" property                                          | `true`                                                |
| `falco.logStderr`                            | Falco lifecycle / error information logs to stderr                                                             | `true`                                                |
| `falco.logSyslog`                            | Falco lifecycle / error information logs to syslog                                                             | `true`                                                |
| `falco.syscallEventDrops.threshold`          | Rate at which actions can be taken. Default 0.03333 = one action per 30 seconds.                               | `0.1`                                                 |
| `falco.syscallEventDrops.actions`            | Rate at which actions can be taken. Default 0.03333 = one action per 30 seconds.                               | `[]`                                                  |
| `falco.syscallEventDrops.rate`               | Rate at which actions can be taken. Default 0.03333 = one action per 30 seconds.                               | `0.03333`                                             |
| `falco.syscallEventDrops.maxBurst`           | Maximum number of actions that can be taken before the steady-state rate is applied.                           | `1`                                                   |
| `falco.syscallEventTimeouts.maxConsecutives` | Maximum number of consecutive timeouts without an event.                                                       | `1000`                                                |
| `falco.syslogOutput.enabled`                 | Alerts will be sent via syslog                                                                                 | `true`                                                |
| `falco.stdoutOutput.enabled`                 | Alerts will be sent via stdout                                                                                 | `true`                                                |
| `falco.fileOutput.enabled`                   | Alerts will be sent to a file                                                                                  | `false`                                               |
| `falco.fileOutput.keepAlive`                 | Falco will open the file once and keep it open for all alerts                                                  | `false`                                               |
| `falco.fileOutput.filename`                  | File path with file name                                                                                       | `./events.txt`                                        |
| `falco.programOutput.enabled`                | Falco alerts will be sent to a program.                                                                        | `false`                                               |
| `falco.programOutput.keepAlive`              | Falco will spawn the program and write the alert. The program pipe will be kept open for subsequent alerts     | `false`                                               |
| `falco.programOutput.program`                | Commands for Falco to run on a alert.                                                                          | `""`                                                  |
| `falco.httpOutput.enabled`                   | Alerts will be sent via http[s].                                                                               | `false`                                               |
| `falco.httpOutput.url`                       | Url that Alerts will be sent via http[s].                                                                      | `""`                                                  |
| `falco.httpOutput.userAgent`                 | User-agent that will be sent via HTTP[S] POST                                                                  | `falcosecurity/falco`                                 |
| `falco.metadataDownload.maxMb`               | Max allowed response size (in Mb) when fetching metadata from Kubernetes                                       | `100`                                                 |
| `falco.metadataDownload.chunkWaitUs`         | Sleep time (in μs) for each download chunck when fetching metadata from Kubernetes                             | `1000`                                                |
| `falco.metadataDownload.watchFreqSec`        | Watch frequency (in seconds) when fetching metadata from Kubernetes                                            | `1`                                                   |


### Falcosidekick Deployment Parameters

| Name                    | Description           | Value   |
| ----------------------- | --------------------- | ------- |
| `falcosidekick.enabled` | Enables Falcosidekick | `false` |


### Falco Exporter Deployment Parameters

| Name                    | Description                       | Value   |
| ----------------------- | --------------------------------- | ------- |
| `falcoExporter.enabled` | Enables Falco Prometheus Exporter | `false` |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
helm install my-release \
    bitnami/falco
```

The above command sets the falco administrator account username and password to `admin` and `password` respectively. Additionally, it sets the MariaDB `root` user password to `secretpassword`.

> NOTE: Once this chart is deployed, it is not possible to change the application's access credentials, such as usernames or passwords, using Helm. To change these application credentials after deployment, delete any persistent volumes (PVs) used by the chart and re-deploy it, or use the application's built-in administrative tools if available.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
helm install my-release -f values.yaml bitnami/falco
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Configuration and installation details

### [Rolling VS Immutable tags](https://docs.bitnami.com/containers/how-to/understand-rolling-tags-containers/)

It is strongly recommended to use immutable tags in a production environment. This ensures your deployment does not change automatically if the same tag is updated with a different image.

Bitnami will release a new chart updating its containers if a new version of the main container, significant changes, or critical vulnerabilities exist.

### Ingress

This chart provides support for Ingress resources. If you have an ingress controller installed on your cluster, such as [nginx-ingress-controller](https://github.com/bitnami/charts/tree/master/bitnami/nginx-ingress-controller) or [contour](https://github.com/bitnami/charts/tree/master/bitnami/contour) you can utilize the ingress controller to serve your application.

To enable Ingress integration, set `ingress.enabled` to `true`. The `ingress.hostname` property can be used to set the host name. The `ingress.tls` parameter can be used to add the TLS configuration for this host. It is also possible to have more than one host, with a separate TLS configuration for each host. [Learn more about configuring and using Ingress](https://docs.bitnami.com/kubernetes/apps/falco/configuration/configure-use-ingress/).

### TLS secrets

The chart also facilitates the creation of TLS secrets for use with the Ingress controller, with different options for certificate management. [Learn more about TLS secrets](https://docs.bitnami.com/kubernetes/apps/falco/administration/enable-tls/).

## Persistence

The [Bitnami falco](https://github.com/bitnami/bitnami-docker-falco) image stores the falco data and configurations at the `/bitnami` path of the container. Persistent Volume Claims are used to keep the data across deployments. [Learn more about persistence in the chart documentation](https://docs.bitnami.com/kubernetes/apps/falco/configuration/chart-persistence/).

### Additional environment variables

In case you want to add extra environment variables (useful for advanced operations like custom init scripts), you can use the `extraEnvVars` property.

```yaml
falco:
  extraEnvVars:
    - name: LOG_LEVEL
      value: error
```

Alternatively, you can use a ConfigMap or a Secret with the environment variables. To do so, use the `extraEnvVarsCM` or the `extraEnvVarsSecret` values.

### Sidecars

If additional containers are needed in the same pod as falco (such as additional metrics or logging exporters), they can be defined using the `sidecars` parameter. If these sidecars export extra ports, extra port definitions can be added using the `service.extraPorts` parameter. [Learn more about configuring and using sidecar containers](https://docs.bitnami.com/kubernetes/apps/falco/administration/configure-use-sidecars/).

### Pod affinity

This chart allows you to set your custom affinity using the `affinity` parameter. Find more information about Pod affinity in the [kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity).

As an alternative, use one of the preset configurations for pod affinity, pod anti-affinity, and node affinity available at the [bitnami/common](https://github.com/bitnami/charts/tree/master/bitnami/common#affinities) chart. To do so, set the `podAffinityPreset`, `podAntiAffinityPreset`, or `nodeAffinityPreset` parameters.

## Troubleshooting

Find more information about how to deal with common errors related to Bitnami's Helm charts in [this troubleshooting guide](https://docs.bitnami.com/general/how-to/troubleshoot-helm-chart-issues).

## License

Copyright &copy; 2022 Bitnami

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

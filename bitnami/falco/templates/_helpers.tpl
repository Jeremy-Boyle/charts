{{/*
Return the proper falco image name
*/}}
{{- define "falco.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.falco.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "falco.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.falco.image) "global" .Values.global) -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "falco.serviceAccountName" -}}
{{- if .Values.falco.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.falco.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.falco.serviceAccount.name }}
{{- end -}}
{{- end -}}


{{/*
Compile all warnings into a single message.
*/}}
{{- define "falco.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "falco.validateValues.foo" .) -}}
{{- $messages := append $messages (include "falco.validateValues.bar" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message -}}
{{- end -}}
{{- end -}}

{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
We need to truncate to 50 characters due to the long names generated for pods
*/}}
{{- define "falco.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 50 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 26 chars due to the long names generated (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "falco.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 26 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 26 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 26 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/* Name suffixed with Falco */}}
{{- define "falco.falco.fullname" -}}
{{- printf "%s-falco" (include "falco.name" .) -}}
{{- end -}}

{{/* Secretname suffixed with Falco */}}
{{- define "falco.falco.webserver.tls.fullname" -}}
{{- printf "%s-falco-ca" (include "falco.name" .) -}}
{{- end -}}

{{/*
Create the name of the Falco service account to use
*/}}
{{- define "falco.falco.serviceAccountName" -}}
{{- if .Values.falco.serviceAccount.create -}}
    {{- default (include "falco.falco.fullname" .) .Values.falco.serviceAccount.name -}}
{{- else -}}
    {{- default "default" .Values.falco.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{/*
    Extract the unixSockets directory path
*/}}
{{- define "falco.unixSocketDir" -}}
{{- if .Values.falco.grpc.unixSocketPath -}}
{{- .Values.falco.grpc.unixSocketPath | trimPrefix "unix://" | dir -}}
{{- end -}}
{{- end -}}
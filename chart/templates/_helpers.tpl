{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "pillplop.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "pillplop.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified postgres name.
*/}}
{{- define "pillplop.postgres.name" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name "postgres" | trunc 63 | trimSuffix "-"}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name "postgres" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified phoenix name.
*/}}
{{- define "pillplop.phoenix.name" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name "phoenix" | trunc 63 | trimSuffix "-"}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name "phoenix" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
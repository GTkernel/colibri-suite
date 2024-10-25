#!/bin/bash

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

## the parameters are configured base on the deployment of the prometheus server in https://github.com/GTkernel/kubernetes-cluster-deployment/tree/master/prometheus
helm install prom-adapter prometheus-community/prometheus-adapter --namespace monitoring --set prometheus.url=http://prometheus-svc.monitoring.svc

### remove service
#helm uninstall prom-adapter --namespace monitoring

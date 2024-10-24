#!/bin/bash

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

helm install prom-adapter prometheus-community/prometheus-adapter 

### remove service
#helm uninstall prom-adapter

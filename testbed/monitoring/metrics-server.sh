#!/bin/bash

helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/

helm repo update

helm install metrics-server metrics-server/metrics-server --version 3.8.1

### remove service
#helm uninstall metrics-server
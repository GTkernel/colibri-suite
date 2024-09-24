# The System Softwares and Applications Working with Colibri 

In this research project, we have done system evaluations with real, open-sourced applications and platforms.
The materials are summarized as below:

## Prerequisite

Colibri and other benchmark applications can simply work in a Linux machine running Docker daemon.
In the paper, we evaluate them on a Kubernetes cluster following by  
[this](https://github.com/GTkernel/kubernetes-cluster-deployment) built up instructions.
Also, we install the popular monitor of Kubernetes, Prometheus, for evaluation, 
we followed the content under the same tutorial set.

## Other components in the monitoring system shown in Colibri paper

We compare Colibri with other monitoring systems in K8s along with their data pipelines (Fig. 11 in paper).
Here, I introduce the installation process we used in the paper:

- **Prometheus Adapter**:
- **Metrics Server**:
- **cAdvisor**:

## Applications

In this paper, we used four MEC-native applications for system evaluations:

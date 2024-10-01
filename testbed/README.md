# The System Softwares and Applications Working with Colibri 

In this research project, we have done system evaluations with real, open-sourced applications and platforms.
The materials are summarized as below:

## Prerequisite

Colibri and other benchmark applications can run on a Linux machine with Docker installed.
In our paper, we evaluate them on a Kubernetes cluster using
setup instructions detailed in [another repository](https://github.com/GTkernel/kubernetes-cluster-deployment).
Also, we install the popular monitor of Kubernetes, Prometheus, for evaluation, 
following a tutorial from the same set of instructions. 
Please refer these steps if you encounter any issues with your own setup.

## Other components in the monitoring system shown in Colibri paper

We compare Colibri with other monitoring systems in K8s along with their data pipelines (Fig. 11 in paper).
Here, I introduce our installation process:

- **Prometheus Adapter**:

- **Metrics Server**: 
Installed via a Helm chart using the default configuration. To install, check and run `./monitoring/metrics-server.sh`.
If using Minikube, add the flag `--kubelet-insecure-tls` to the container's entry command. 
More details can be found in the related [issue ticket](https://github.com/kubernetes-sigs/metrics-server/issues/196).

Verifying whether your metrics server is running correctly by command
```
$ kubectl top
```

- **cAdvisor**:
Run the standalone cAdvisor by kube-config file `./monitoring/cadvisor.yml`. 
To evaluate the cost of cAdvisor, as closer to the one embedded in kubelet as possible, we follow the
official [reference](https://github.com/google/cadvisor/blob/c15f44e578c77800b1b82a7bbb67614364f4aedc/deploy/kubernetes/overlays/examples/cadvisor-args.yaml). More runtime flags can be found [here](https://github.com/google/cadvisor/blob/master/docs/runtime_options.md).

To change the metrics querying interval, you can update the `housekeeping_interval` in the YAML file before you run it.
```
    - --housekeeping_interval=15ms
```

## Applications

In this paper, we used four MEC-native applications for system evaluations:

- **Object detection by Tensorflow Serving**

- **FleXR**

- **ROS: Robotic OS**
Installation details are in [this repo](https://github.com/GTkernel/ros). 
In this paper, we run `core_pub.yml` as MEC server-side workload, while `sub.yml` running as client at the same time to 
generate the serving traffic and computation. Files are under `./pubsub/k8s/` in the ROS repo.

- **MPEG-OMAF Video 360 by Web Browser**

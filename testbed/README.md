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

We compare Colibri with other monitoring systems in K8s along with their data pipelines (Fig. 9 in paper).
Here, I introduce our installation process:

- **Prometheus Adapter**:
Prometheus adapter is a necessary component and interface for K8s intergration when using Prometheus as a monitor.
Refer to the file `./monitoring/prom-adapter.sh` for the installation by Helm.

Verifying whether your Prometheus is correctly configured and running, checking by
```
$ kubectl get --raw /apis/custom.metrics.k8s.io/v1beta1
```
If successful, you will see a bunch of metrics in JSON format returned.
While this paper focuses on resource consumption in the overall monitoring pipeline, we don't cover other
integration setup or test about Prometheus adapter here.

- **Metrics Server**: 
Installed via a Helm chart using the default configuration. To install, check and run `./monitoring/metrics-server.sh`.
If facing x509 certificate invalid issue, add the flag `--kubelet-insecure-tls` to the container's entry command by editing the deployment. 
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

In this paper, we used four MEC-native applications as the benchmarking tools for system evaluations. 
Their tags, shown in parentheses, are used throughout the paper:

- **Object detection by Tensorflow Serving (ML)**:
Detailed installation instructions are available in the `./k8s` directory of [this repo](https://github.com/GTkernel/object-detector-tf-serve/). 
Please ensure you have the server-side and client-side Docker images, application configuration file, 
and K8s config file -- all of which are necessary to run this workload in a K8s environment.
The input data used in the paper is this 1.5-minute [advertisement video](https://www.youtube.com/watch?v=7_mR0WXNhsA) on Youtube.

- **FleXR (XR)**:
The official repo of FleXR is linked [here](https://github.com/gt-flexr/FleXR). 
In this repo, we includes deployment configurations for K8s, which are detailed under `./flexr`.

- **ROS/Robotic OS (IA)**:
Installation details are in [this repo](https://github.com/GTkernel/ros). 
In this paper, we run `core_pub.yml` as MEC server-side workload, while `sub.yml` running as client at the same time to 
generate the serving traffic and computation. Files are under `./pubsub/k8s/` in the ROS repo.

- **MPEG-OMAF Video 360 by Web Browser (Video360)**:
We follow this deployment process in [this repo](https://github.com/GTkernel/omaf-video-360).
To ensure consistency in our test case during experiments, we use [GoReplay](https://goreplay.org) 
to record client actions (API requests) from the browser. These recorded actions can then be replayed and fed into the Video360 server.
You can create your own test case if needed. Our `.gor` file is available in the repository at `./nginx-server/omaf.gor`. 
With the NGINX server running in K8s, 
we run GoReplay via Docker as the client, using the correctly configured server IP by tag `--output-http`.


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

In this paper, we used four MEC-native applications for system evaluations:

- **Object detection by Tensorflow Serving**
The detailed installation method is under the directory `./k8s` in [this repo](https://github.com/GTkernel/object-detector-tf-serve/). Be awared of the server-side and client-side docker images, application configuration file, and K8s config file, those are all necessary when you run this workload in K8s environment.
The input data used in the paper is this [advertisement video](https://www.youtube.com/watch?v=7_mR0WXNhsA) on Youtube, about 1.5 minutes length.

- **FleXR**
The official repo of FleXR is at [here](https://github.com/gt-flexr/FleXR). In this repo, we cover deploying configurations on K8s, detailed as decription under `./flexr`.

- **ROS: Robotic OS**
Installation details are in [this repo](https://github.com/GTkernel/ros). 
In this paper, we run `core_pub.yml` as MEC server-side workload, while `sub.yml` running as client at the same time to 
generate the serving traffic and computation. Files are under `./pubsub/k8s/` in the ROS repo.

- **MPEG-OMAF Video 360 by Web Browser**
We follow this deployment process in [this repo](https://github.com/GTkernel/omaf-video-360).
To ensure consistency in our test case during experiments, we use [GoReplay](https://goreplay.org) 
to record client actions (API requests) from the browser. These recorded actions can then be replayed and fed into the Video360 server.
You can create your own test case if needed. Our `.gor` file is available in the repository at `./nginx-server/omaf.gor`. 
With the NGINX server running in K8s, 
we run GoReplay via Docker as the client, using the correctly configured server IP by tag `--output-http`.


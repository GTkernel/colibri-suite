# FleXR on Kubernetes

While using FleXR as a benchmarking workload in this paper, we run the **round-trip** test case. 
This case covers two components: a server and a client. Each data frame in this pipeline runs as: 
(1) the client encodes a raw image and to a server 
(2) server first decodes the image, and then encodes it again, and sending it back to the client
(3) once client receive the encode data, it decodes it, and finishs this data's life cycle.
There are another pair of configuration files for **streaming** test case.

To run the FleXR workload on K8s, follow these three steps:

1. Build the FleXR Docker image
2. Prepare FleXR configuration files and input data
3. Prepare the related K8s configuration files for each service

Each step is discussed in detail below.

### Building FleXR Docker image

The default Dockerfile setup is using x86-64/amd64 base image. 
For running FleXR in ARM architecture, checking the public docker [registry](https://hub.docker.com/r/jheo4/flexr/tags) 
and indicating the corresponding one.

### The on-host files for FleXR container workloads

While FleXR running, each component would execute based on a configuration file, called a *recipe*.
Under `./recipe`, it includes detailed execution parameters and the networking information between compoments (pipeline stages),
e.g. the frequency of playing the video and domain name/IP/port of the connected nodes.

On the other hand, we use [sample images](https://gtvault-my.sharepoint.com/:u:/g/personal/jheo33_gatech_edu/EZCp7EtcWH5JmeswzzPScVEBxXUtmyZSPTxeKQkrXSm2zA?e=X3wOQT) for reproducing the same input load in this paper. 
The files are also required to be accessable on local host.

### Running on K8s with configuration file

We have the matched K8s config files in directory `./k8s`. Please ensure you change the content that mapping your environment.
Such as node name, image name, directory/file path of input files.

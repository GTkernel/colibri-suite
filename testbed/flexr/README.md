# FleXR on Kubernetes

While using FleXR as a benchmarking workload in this paper, we run the **round-trip** test case. 
This test case involves two components: a server and a client. 
Each data frame in this pipeline is processed as: 
(1) the client encodes a raw image and sends it to the server 
(2) the server decodes the image, re-encodes it, and sends it back to the client
(3) once the client receives the encoded data, it decodes it, completing the data frame's life cycle.
An additional set of configuration files is available in this repo for the **streaming** test case.

To run the FleXR workload on K8s, follow these three steps:

1. Build the FleXR Docker image
2. Prepare FleXR configuration files and input data
3. Prepare the related K8s configuration files for each service

Each step is discussed in detail below.

### Building FleXR Docker image

The default Dockerfile uses an x86-64/amd64 base image. 
To run FleXR on an ARM architecture, check the public Docker [registry](https://hub.docker.com/r/jheo4/flexr/tags) 
for a compatible image and specify the tag accordingly.

### On-host files for FleXR container workloads

While FleXR is running, each component operates based on a configuration file, referred as a *recipe*.
The `./recipe` directory includes files detailing execution parameters and network information between pipeline stages,
e.g. video/image playback frequency and the domain name/IP/port of connected nodes.

On the other hand, we use [sample images](https://gtvault-my.sharepoint.com/:u:/g/personal/jheo33_gatech_edu/EZCp7EtcWH5JmeswzzPScVEBxXUtmyZSPTxeKQkrXSm2zA?e=X3wOQT) (Georgia Tech internal access only) 
for reproducing the same input load in this paper.
The files are also required to be accessable on local host.

### Running on K8s with configuration files

The necessary K8s configuration files are located in the `./k8s`. 
Please ensure to adjust these files to matchyour environment, including fields like
node names, image names, and input file paths.

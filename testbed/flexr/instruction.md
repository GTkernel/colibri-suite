# FleXR on Kubernetes

While using FleXR as the benchmarking workload, we run the **round trip** testcase.
There are three steps for running FleXR workload on K8s:

1. Build up docker images
2. Prepare FleXR configuration files and input data
3. Prepare the related K8s configuration files for each services

We dicusss each step one-by-one as follows.

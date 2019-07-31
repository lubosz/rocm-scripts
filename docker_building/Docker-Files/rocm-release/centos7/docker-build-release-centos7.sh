#!/bin/bash

driver=$1
echo $driver
# Build the base image
rocm_base_image=computecqe/rocm-base-$driver:centos7
echo $rocm_base_image
docker build -f ./base/Dockerfile ./base --build-arg rocm_rel=${driver} --no-cache -t ${rocm_base_image}
if [ $? -ne 0 ]; then { echo "ERROR: failed base image build!" ; exit 1; } fi


# Build the tensorflow 1.10 image
#tensorflow_110_image=computecqe/tf1.10-"$driver":centos7
#docker build -f ./tf1.10/Dockerfile ./tf1.10 --build-arg base_image=${rocm_base_image} --no-cache -t ${tensorflow_110_image}

# Build the tensorflow 1.11 image
tensorflow_111_image=computecqe/tf1.11-"$driver":centos7
docker build -f ./tf1.11/Dockerfile ./tf1.11 --build-arg base_image=${rocm_base_image} --no-cache -t ${tensorflow_111_image}

# Build the caffe2 image
#caffe2_image=caffe2-"$1"
#docker build -f ./caffe2/Dockerfile ./caffe2 --build-arg base_image=${rocm_base_image} --no-cache -t ${caffe2_image}


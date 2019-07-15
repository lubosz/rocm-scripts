#!/bin/bash

driver=$1
echo $driver
# Build the base image
rocm_base_image=computecqe/rocm-base-"$driver":ub16.04
echo $rocm_base_image
docker build -f ./base/Dockerfile ./base --build-arg rocm_rel=${driver} --no-cache -t ${rocm_base_image}
if [ $? -ne 0 ]; then { echo "ERROR: failed base image build!" ; exit 1; } fi


# Build the tensorflow 1.14 image
tensorflow_114_image=computecqe/tf1.14-"$driver":ub16.04
docker build -f ./tf1.14/Dockerfile ./tf1.14 --build-arg base_image=${rocm_base_image} --no-cache -t ${tensorflow_114_image}

# Build the tensorflow 1.14 XLA image
tensorflow_114xla_image=computecqe/tf1.14xla-"$driver":ub16.04
docker build -f ./tf1.14-xla/Dockerfile ./tf1.14-xla --build-arg base_image=${rocm_base_image} --no-cache -t ${tensorflow_114xla_image}




#| This Dockerfile provides a starting point for a ROCm installation of Tensorflow.
ARG base_image
FROM ${base_image}

#FROM ubuntu:16.04

MAINTAINER Pramendra Kumar <pramendra.kumar@amd.com>

WORKDIR $HOME/driver

#Install Pre-Req for pyhton2 based
#RUN apt-get install -y python-numpy python-dev python-pip python-wheel python-yaml python-future python-mock python-setuptools

#Install Pre-Req for pyhton3 based
RUN apt-get install -y python3-numpy python3-dev python3-pip python3-wheel python3-yaml python3-future python3-mock python3-setuptools && apt-get install -y curl && pip3 install numpy absl-py keras && pip3 install --upgrade pip && apt-get clean all

#RUN  pip install numpy absl-py keras &&

RUN dpkg -r hip-thrust cub-hip &&  rm -rf /opt/rocm/include/thrust/ && dpkg -r rocprim


# Install Bazel
RUN wget https://github.com/bazelbuild/bazel/releases/download/0.19.2/bazel-0.19.2-installer-linux-x86_64.sh && apt-get install -y openjdk-8-jre pkg-config zip g++ zlib1g-dev unzip python && apt-get clean all && chmod 775 *.sh && dos2unix *.sh && $HOME/driver/bazel-0.19.2-installer-linux-x86_64.sh && rm -rf $HOME/driver/bazel-0.19.2-installer-linux-x86_64.sh

ARG HCC_HOME=/opt/rocm/hcc
ARG HIP_PATH=/opt/rocm/hip
ARG PATH=$HCC_HOME/bin:$HIP_PATH/bin:$PATH

# Clone TF
RUN cd /root  && git clone -b r1.13-rocm https://github.com/ROCmSoftwarePlatform/tensorflow-upstream tensorflow
WORKDIR /root/tensorflow
# Build TF for python3

RUN sed -i 's/tensorflow-1.13.3-cp35-cp35m-linux_x86_64.whl/tensorflow-*.whl/g' build_rocm_python3 && /root/tensorflow/build_rocm_python3 2>&1 | tee tf1.13_build.log &&  cp -rf /root/tensorflow/tf1.13_build.log /root/ && apt-get clean all && rm -rf ~/.cache/* && rm -rf /tmp/*

# Clone hiptf models and benchmarks
WORKDIR /root/
RUN  git clone -b r1.13.0 https://github.com/tensorflow/models.git &&  git clone -b cnn_tf_v1.12_compatible https://github.com/tensorflow/benchmarks

WORKDIR /root

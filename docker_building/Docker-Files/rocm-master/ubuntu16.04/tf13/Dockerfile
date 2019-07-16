#docker image build command
#docker build --rm -t pramenku/tf1.8:rocm# --file <completepath>/Dockerfile <completepath>
##uploaded docker image to docker hub
#docker tag 498e66734905  pramenku/tf-rocm#
#docker push pramenku/tf-rocm#


#| This Dockerfile provides a starting point for a ROCm installation of Tensorflow.
ARG base_image
FROM ${base_image}

#FROM ubuntu:16.04

MAINTAINER Pramendra Kumar <pramendra.kumar@amd.com>


WORKDIR $HOME/driver
# Install Bazel
RUN apt-get install -y curl

ARG HCC_HOME=/opt/rocm/hcc
ARG HIP_PATH=/opt/rocm/hip
ARG PATH=$HCC_HOME/bin:$HIP_PATH/bin:$PATH

RUN echo "gfx900" >> /opt/rocm/bin/target.lst

RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
RUN apt-get -y update --allow-insecure-repositories && apt-get install -y openjdk-8-jdk openjdk-8-jre unzip && apt-get clean && rm -rf /var/lib/apt/lists/* 
RUN wget https://github.com/bazelbuild/bazel/releases/download/0.4.5/bazel-0.4.5-installer-linux-x86_64.sh
RUN bash bazel*.sh

# Clone TF
#RUN source /usr/local/lib/bazel/bin/bazel-complete.bash
RUN cd $HOME  && git clone https://github.com/ROCmSoftwarePlatform/tensorflow.git
WORKDIR $HOME/tensorflow

# Build TF for python2
ARG PYTHON_BIN_PATH=/usr/bin/python2
RUN yes "" | ./configure
RUN bash $HOME/tensorflow/build
#ARG PYTHON_BIN_PATH=/usr/bin/python3
#RUN yes "" | ./configure
#RUN bash $HOME/tensorflow/build_python3

# Clone hiptf models and benchmarks
RUN cd $HOME/tensorflow  && git clone https://github.com/soumith/convnet-benchmarks.git
RUN cd $HOME/tensorflow && git clone https://github.com/tensorflow/models.git

# TF/benchmarks with some workarounds for TF1.3 & for ImageNet
RUN cd $HOME/tensorflow && git clone https://github.com/tensorflow/benchmarks.git
WORKDIR $HOME/tensorflow/benchmarks
RUN git checkout -b sep7 6a33b4a4b5bda950bb7e45faf13120115cbfdb2f

RUN sed -i 's|from tensorflow.contrib import nccl|#from tensorflow.contrib import nccl|g' ./scripts/tf_cnn_benchmarks/variable_mgr.py

WORKDIR $HOME/tensorflow



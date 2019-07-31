
#docker image build command
#docker build --rm -t pramenku/tf1.8:rocm# --file <completepath>/Dockerfile <completepath>
##uploaded docker image to docker hub
#docker tag 498e66734905  pramenku/tf-rocm#
#docker push pramenku/tf-rocm#


#| This Dockerfile provides a starting point for a ROCm installation of Tensorflow.
ARG base_image
FROM ${base_image}

#FROM ubuntu:18.04

MAINTAINER Pramendra Kumar <pramendra.kumar@amd.com>


WORKDIR $HOME/driver

#Install PreReq for python3
RUN apt-get install -y python3-numpy python3-dev python3-pip python3-wheel python3-yaml python3-future python3-mock python3-setuptools curl
RUN pip3 install numpy absl-py

#Install PreReq for python2
#RUN apt-get install -y python2-numpy python2-dev python2-pip python2-wheel python2-yaml python2-future python2-mock python2-setuptools
#RUN pip install numpy absl-py


# Install Bazel
RUN apt-get install -y openjdk-8-jre pkg-config zip g++ zlib1g-dev unzip python
RUN wget https://github.com/bazelbuild/bazel/releases/download/0.15.2/bazel-0.15.2-installer-linux-x86_64.sh
RUN chmod +x *.sh
RUN dos2unix *.sh
RUN /root/driver/bazel-0.15.2-installer-linux-x86_64.sh

ARG HCC_HOME=/opt/rocm/hcc
ARG HIP_PATH=/opt/rocm/hip
ARG PATH=$HCC_HOME/bin:$HIP_PATH/bin:$PATH

# Clone TF
#RUN source /usr/local/lib/bazel/bin/bazel-complete.bash
RUN cd $HOME  && git clone -b r1.8-rocm https://github.com/ROCmSoftwarePlatform/tensorflow-upstream tensorflow
WORKDIR $HOME/tensorflow
#RUN git reset --hard 2c31a8f03cd4c139f2adb5783af69d591acd7b83
# Build TF for python3
RUN yes "" | PYTHON_BIN_PATH=/usr/bin/python3 ./configure
RUN sed -i 's/tensorflow-1.8.0-cp35-cp35m-linux_x86_64.whl/tensorflow-*.whl/g' build_python3
RUN $HOME/tensorflow/build_python3 2>&1 | tee tf1.8_build.log

# Build TF for python2
#RUN yes "" | PYTHON_BIN_PATH=/usr/bin/python3 ./configure
#RUN sed -i 's/tensorflow-1.8.0-cp35-cp35m-linux_x86_64.whl/tensorflow-*.whl/g' build
#RUN bash $HOME/tensorflow/build

# Clone hiptf models and benchmarks
#RUN cd $HOME/tensorflow  && git clone https://github.com/soumith/convnet-benchmarks.git

RUN cd $HOME && git clone https://github.com/tensorflow/models.git

# TF/benchmarks with some workarounds for TF1.3 & for ImageNet
RUN cd $HOME && git clone https://github.com/tensorflow/benchmarks.git
WORKDIR $HOME/benchmarks
RUN git checkout -b may22 ddb23306fdc60fefe620e6ce633bcd645561cb0d
RUN sed -i 's|from tensorflow.contrib import nccl|#from tensorflow.contrib import nccl|g' ./scripts/tf_cnn_benchmarks/variable_mgr.py

WORKDIR $HOME/tensorflow

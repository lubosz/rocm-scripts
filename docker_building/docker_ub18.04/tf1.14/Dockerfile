
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

#Install Pre-Req for pyhton2 based
#RUN apt-get install -y python-numpy python-dev python-pip python-wheel python-yaml python-future python-mock python-setuptools

#Install Pre-Req for pyhton3 based
RUN apt-get -y  update && apt-get install -y python3-numpy python3-dev python3-pip python3-wheel python3-yaml python3-future python3-mock python3-setuptools && pip3 install setuptools --upgrade && pip3 install protobuf --upgrade && pip3 install keras_applications==1.0.4 --no-deps && pip3 install keras_preprocessing==1.0.2 --no-deps && apt-get update &&  apt-get install -y curl && apt-get install -y wget unzip libssl-dev libboost-dev libboost-system-dev libboost-filesystem-dev && apt-get -y clean all



# Install Bazel
RUN wget https://github.com/bazelbuild/bazel/releases/download/0.24.1/bazel-0.24.1-installer-linux-x86_64.sh
RUN apt-get install -y openjdk-8-jre pkg-config zip g++ zlib1g-dev unzip python
RUN chmod +x *.sh
RUN dos2unix *.sh
RUN $HOME/driver/bazel-0.24.1-installer-linux-x86_64.sh

ARG HCC_HOME=/opt/rocm/hcc
ARG HIP_PATH=/opt/rocm/hip
ARG PATH=$HCC_HOME/bin:$HIP_PATH/bin:$PATH

RUN echo "gfx908" >> /opt/rocm/bin/target.lst

# Clone TF
RUN rm -rf /opt/rocm/include/thrust && dpkg -r rocprim rocalution
RUN cd /root  && git clone -b r1.14-rocm https://github.com/ROCmSoftwarePlatform/tensorflow-upstream tensorflow
WORKDIR /root/tensorflow

# Build TF for python2
#RUN PYTHON_BIN_PATH=/usr/bin/python3 cat ./configure_rocm | ./configure
#RUN yes "" | PYTHON_BIN_PATH=/usr/bin/python3 ./configure
#RUN sed -i 's/tensorflow-1.10.0rc1-cp27-cp27mu-linux_x86_64.whl/tensorflow-*.whl/g' build_rocm
#RUN bash $HOME/tensorflow/build_rocm


# Build TF for python3
#RUN sed -i 's/tensorflow-1.10.0-cp35-cp35m-linux_x86_64.whl/tensorflow-*.whl/g' build_rocm_xla_python3
RUN /root/tensorflow/build_rocm_python3 2>&1 | tee tf1.14-build.log

#RUN cd $HOME/ && git clone https://github.com/tensorflow/models.git

# TF/benchmarks with some workarounds for TF1.3 & for ImageNet
RUN cd /root &&  git clone -b r1.13.0 https://github.com/tensorflow/models.git &&  git clone -b cnn_tf_v1.12_compatible https://github.com/tensorflow/benchmarks

WORKDIR /root


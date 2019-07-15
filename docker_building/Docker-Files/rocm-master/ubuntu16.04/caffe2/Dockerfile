#| This Dockerfile provides a starting point for a ROCm installation of Tensorflow.
ARG base_image
FROM ${base_image}

#FROM ubuntu:18.04

MAINTAINER Pramendra Kumar <pramendra.kumar@amd.com>


WORKDIR $HOME/driver
# Install Pre-req
RUN apt-get clean all
RUN apt-get update
RUN apt-get install -y --no-install-recommends autoconf build-essential ca-certificates cmake curl git libgoogle-glog-dev libhiredis-dev libiomp-dev libleveldb-dev liblmdb-dev libopencv-dev  libpthread-stubs0-dev  libsnappy-dev  sudo vim
RUN apt-get install -y --no-install-recommends libprotobuf-dev protobuf-compiler

RUN apt-get install -y --no-install-recommends python-dev python-setuptools python-pip

RUN PYTHON=python2
# Clean up
RUN apt-get autoclean && apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip install --upgrade pip

RUN pip install networkx==2.0
RUN pip install --no-cache-dir click future hypothesis jupyter numpy protobuf pytest pyyaml scikit-image tabulate virtualenv mock typing typing-extensions pyyaml



ARG HCC_HOME=/opt/rocm/hcc
ARG HIP_PATH=/opt/rocm/hip
ARG PATH=$HCC_HOME/bin:$HIP_PATH/bin:$PATH


#install clang 7
RUN apt-get update
RUN apt-get install -y --no-install-recommends software-properties-common wget
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-7 main"
RUN apt-get update
RUN apt-get install -y --no-install-recommends clang-7
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/clang-7 50
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/clang++-7 50



#thrust header file 
RUN mkdir -p /opt/rocm/debians
RUN curl http://repo.radeon.com/rocm/misc/facebook/apt/.apt_1.9.white_rabbit/debian/pool/main/h/hip-thrust/hip-thrust_1.8.2_all.deb -o /opt/rocm/debians/hip-thrust.deb
RUN dpkg -i /opt/rocm/debians/hip-thrust.deb


ENV PATH=/opt/rocm/bin:$PATH
ENV PATH=/opt/rocm/hcc/bin:$PATH
ENV PATH=/opt/rocm/hip/bin:$PATH
ENV PATH=/opt/rocm/opencl/bin/x86_64:$PATH
ENV HIP_PLATFORM=hcc


ENV LD_LIBRARY_PATH=/usr/local/caffe2/lib
ENV PYTHONPATH=/usr/local/caffe2/lib/python2.7/dist-packages


# clone and build pytorch
WORKDIR /root
RUN git clone https://github.com/ROCmSoftwarePlatform/pytorch.git
WORKDIR /root/pytorch
RUN git submodule init
RUN git submodule update --init --recursive 
RUN /root/pytorch/docker/caffe2/jenkins
RUN ./build.sh py2-clang7-rocmdeb-ubuntu16.04

#Run inside docker container and run below commands:
RUN .jenkins/caffe2/build.sh 2>&1 | tee caffe2_build.log
#HCC_AMDGPU_TARGET=gfx906 .jenkins/caffe2/build.sh 2>&1 | tee caffe2_build.log
#Run tests: .jenkins/caffe2/test.sh

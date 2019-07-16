#| This Dockerfile provides a starting point for a ROCm installation of Tensorflow.
ARG base_image
FROM ${base_image}

#FROM ubuntu:18.04

MAINTAINER Pramendra Kumar <pramendra.kumar@amd.com>


WORKDIR $HOME/driver
# Install Pre-req
RUN apt-get clean all
RUN apt-get update

# Modify to pre-install dev tools and ROCm packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl && \
  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  sudo \
  libelf1 \
  build-essential \
  ca-certificates \
  apt-utils \
  pkg-config \
  gdb \
  less \
  libfftw3-dev \
  libelf-dev \
  libncurses5-dev \
  libomp-dev \
  libpthread-stubs0-dev \
  make \
  python3-dev \
  python-yaml \
  python3-pip \
  vim \
  libssl-dev \
  libboost-dev \
  libboost-system-dev \
  libboost-filesystem-dev \
  libopenblas-dev \
  rpm \
  wget \
  net-tools \
  iputils-ping && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*


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



# Thrust: Needed for now, will be replaced soon
RUN git clone --recursive https://github.com/ROCmSoftwarePlatform/Thrust.git /data/Thrust
RUN rm -rf /data/Thrust/thrust/system/cuda/detail/cub-hip
RUN git clone --recursive https://github.com/ROCmSoftwarePlatform/cub-hip.git /data/Thrust/thrust/system/cuda/detail/cub-hip

#thrust header file 
RUN mkdir -p /opt/rocm/debians
RUN curl http://repo.radeon.com/rocm/misc/facebook/apt/.apt_1.9.white_rabbit/debian/pool/main/h/hip-thrust/hip-thrust_1.8.2_all.deb -o /opt/rocm/debians/hip-thrust.deb
RUN dpkg -i /opt/rocm/debians/hip-thrust.deb

# install rocrand
#RUN mkdir -p /opt/rocm/debians
#RUN curl https://s3.amazonaws.com/ossci-linux/rocrand-1.8.0-Linux.deb -o /opt/rocm/debians/rocrand.deb 
#RUN dpkg -i /opt/rocm/debians/rocrand.deb

ENV KMTHINLTO="1" LANG="C.UTF-8" LC_ALL="C.UTF-8"
ENV PATH=/opt/rocm/bin:$PATH
ENV PATH=/opt/rocm/hcc/bin:$PATH
ENV PATH=/opt/rocm/hip/bin:$PATH
ENV PATH=/opt/rocm/opencl/bin/x86_64:$PATH
ENV THRUST_ROOT=/data/Thrust
ENV MIOPEN_DISABLE_CACHE=1
ENV HIP_PLATFORM=hcc

# Include BUILD_ENVIRONMENT environment variable in image
#ENV BUILD_ENVIRONMENT=py2-clang3.8-rocm1.8.2-ubuntu16.04
#ENV LD_LIBRARY_PATH=/usr/local/caffe2/lib
#ENV PYTHONPATH=/usr/local/caffe2/lib/python2.7/dist-packages

RUN pip3 install setuptools 
RUN pip3 install pyyaml numpy scipy typing enum34

# clone and build pytorch
WORKDIR /root
RUN  git clone https://github.com/ROCmSoftwarePlatform/pytorch.git
WORKDIR /root/pytorch
RUN git submodule update --init
RUN python3 tools/amd_build/build_pytorch_amd.py
#you will get output as "Successfully preprocessed all matching files."
RUN python3 tools/amd_build/build_caffe2_amd.py
#you will get output as "Successfully preprocessed all matching files."
RUN USE_ROCM=1 MAX_JOBS=4 python3 setup.py install --user 2>&1 | tee pytorch-build.log

ENV PYTORCH_TEST_WITH_ROCM=1

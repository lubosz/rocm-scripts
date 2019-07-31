#| This Dockerfile provides a starting point for a ROCm installation of Tensorflow.
ARG base_image
FROM ${base_image}

#FROM ubuntu:18.04

MAINTAINER Pramendra Kumar <pramendra.kumar@amd.com>

# Use devtoolset env
ENV PATH=/opt/rh/devtoolset-7/root/usr/bin:/opt/rocm/hcc/bin:/opt/rocm/hip/bin:/opt/rocm/bin:/opt/rocm/hcc/bin:${PATH:+:${PATH}}
ENV MANPATH=/opt/rh/devtoolset-7/root/usr/share/man:${MANPATH}
ENV INFOPATH=/opt/rh/devtoolset-7/root/usr/share/info${INFOPATH:+:${INFOPATH}}
ENV PCP_DIR=/opt/rh/devtoolset-7/root
ENV PERL5LIB=/opt/rh/devtoolset-7/root//usr/lib64/perl5/vendor_perl:/opt/rh/devtoolset-7/root/usr/lib/perl5:/opt/rh/devtoolset-7/root//usr/share/perl5/
ENV LD_LIBRARY_PATH=/usr/local/lib:/opt/rocm/lib:/opt/rh/devtoolset-7/root$rpmlibdir$rpmlibdir32${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
ENV PYTHONPATH=/opt/rh/devtoolset-7/root/usr/lib64/python$pythonvers/site-packages:/opt/rh/devtoolset-7/root/usr/lib/python$pythonvers/
ENV LDFLAGS="-Wl,-rpath=/opt/rh/devtoolset-7/root/usr/lib64 -Wl,-rpath=/opt/rh/devtoolset-7/root/usr/lib"


WORKDIR $HOME/driver
# Install Pre-req
RUN yum -y clean all
#RUN yum -y update
RUN yum install -y --no-install-recommends autoconf build-essential ca-certificates cmake curl git libgoogle-glog-dev libhiredis-dev libiomp-dev libleveldb-dev liblmdb-dev libopencv-dev  libpthread-stubs0-dev  libsnappy-dev  sudo vim
RUN yum install -y --no-install-recommends libprotobuf-dev protobuf-compiler

RUN yum install -y --no-install-recommends python-dev python-setuptools python-pip

RUN PYTHON=python2
# Clean up
RUN yum autoclean && apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip install --upgrade pip

RUN pip install networkx==2.0
RUN pip install --no-cache-dir click future hypothesis jupyter numpy protobuf pytest pyyaml scipy==0.19.1 scikit-image tabulate virtualenv mock typing typing-extensions pyyaml



ARG HCC_HOME=/opt/rocm/hcc
ARG HIP_PATH=/opt/rocm/hip
ARG PATH=$HCC_HOME/bin:$HIP_PATH/bin:$PATH

RUN wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key|sudo apt-key add -
RUN echo "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.8 main" >> /etc/apt/sources.list
#RUN yum update


RUN yum install -y --no-install-recommends clang-3.8
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use update-alternatives to make this version the default
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/clang-3.8 50
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/clang++-3.8 50


# Thrust: Needed for now, will be replaced soon
RUN git clone --recursive https://github.com/ROCmSoftwarePlatform/Thrust.git /data/Thrust
RUN rm -rf /data/Thrust/thrust/system/cuda/detail/cub-hip
RUN git clone --recursive https://github.com/ROCmSoftwarePlatform/cub-hip.git /data/Thrust/thrust/system/cuda/detail/cub-hip

# install hcsparse
RUN mkdir -p /opt/rocm/debians
RUN curl https://s3.amazonaws.com/ossci-linux/hcsparse-master-907a505-Linux.deb -o /opt/rocm/debians/hcsparse.deb
RUN dpkg -i /opt/rocm/debians/hcsparse.deb


# install rocrand
#RUN mkdir -p /opt/rocm/debians
#RUN curl https://s3.amazonaws.com/ossci-linux/rocrand-1.8.0-Linux.deb -o /opt/rocm/debians/rocrand.deb 
#RUN dpkg -i /opt/rocm/debians/rocrand.deb


ENV PATH=/opt/rocm/bin:$PATH
ENV PATH=/opt/rocm/hcc/bin:$PATH
ENV PATH=/opt/rocm/hip/bin:$PATH
ENV PATH=/opt/rocm/opencl/bin/x86_64:$PATH
ENV THRUST_ROOT=/data/Thrust
ENV MIOPEN_DISABLE_CACHE=1
ENV HIP_PLATFORM=hcc

# Include BUILD_ENVIRONMENT environment variable in image
ENV BUILD_ENVIRONMENT=py2-clang3.8-rocm1.8.2-ubuntu16.04
ENV LD_LIBRARY_PATH=/usr/local/caffe2/lib
ENV PYTHONPATH=/usr/local/caffe2/lib/python2.7/dist-packages

# clone and build pytorch
WORKDIR /root
RUN git clone --recurse-submodules -b caffe2_specific https://github.com/ROCmSoftwarePlatform/pytorch.git
WORKDIR /root/pytorch
#RUN sed -i 's/gfx900/gfx906/g' .jenkins/caffe2/amd/build_amd.sh
RUN .jenkins/caffe2/amd/build_amd.sh 2>&1 | tee caffe2_build.log

#docker image build command
#docker build --rm -t pramenku/tf1.8:rocm# --file <completepath>/Dockerfile <completepath>
##uploaded docker image to docker hub
#docker tag 498e66734905  pramenku/tf-rocm#
#docker push pramenku/tf-rocm#


#| This Dockerfile provides a starting point for a ROCm installation of Tensorflow.
ARG base_image
FROM ${base_image}

#FROM centos:7

MAINTAINER Pramendra Kumar <pramendra.kumar@amd.com>


WORKDIR $HOME

RUN echo "gfx900" >> /opt/rocm/bin/target.lst

# Use devtoolset env
ENV PATH=/opt/rh/devtoolset-7/root/usr/bin:/opt/rocm/hcc/bin:/opt/rocm/hip/bin:/opt/rocm/bin:/opt/rocm/hcc/bin:${PATH:+:${PATH}}
ENV MANPATH=/opt/rh/devtoolset-7/root/usr/share/man:${MANPATH}
ENV INFOPATH=/opt/rh/devtoolset-7/root/usr/share/info${INFOPATH:+:${INFOPATH}}
ENV PCP_DIR=/opt/rh/devtoolset-7/root
ENV PERL5LIB=/opt/rh/devtoolset-7/root//usr/lib64/perl5/vendor_perl:/opt/rh/devtoolset-7/root/usr/lib/perl5:/opt/rh/devtoolset-7/root//usr/share/perl5/
ENV LD_LIBRARY_PATH=/usr/local/lib:/opt/rh/devtoolset-7/root$rpmlibdir$rpmlibdir32${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
ENV PYTHONPATH=/opt/rh/devtoolset-7/root/usr/lib64/python$pythonvers/site-packages:/opt/rh/devtoolset-7/root/usr/lib/python$pythonvers/
ENV LDFLAGS="-Wl,-rpath=/opt/rh/devtoolset-7/root/usr/lib64 -Wl,-rpath=/opt/rh/devtoolset-7/root/usr/lib"


RUN yum -y install gcc gcc-c++ python-pip python-devel atlas atlas-devel gcc-gfortran openssl-devel libffi-devel
RUN pip install --upgrade numpy scipy wheel cryptography mock future setuptools

ENV DOCKER_VARIANT=centos7
WORKDIR $HOME

# Install Bazel
RUN yum install -y curl
RUN yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel
RUN cd $HOME && wget https://github.com/bazelbuild/bazel/releases/download/0.4.5/bazel-0.4.5-installer-linux-x86_64.sh
RUN cd $HOME && bash bazel*.sh

ARG HCC_HOME=/opt/rocm/hcc
ARG HIP_PATH=/opt/rocm/hip
ARG PATH=$HCC_HOME/bin:$HIP_PATH/bin:$PATH

# Clone TF1.3
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



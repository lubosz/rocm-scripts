#| This Dockerfile provides a starting point for a ROCm installation of Pytorch.
ARG base_image
FROM ${base_image}


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
  

RUN rm -rf ~/.cache/* && apt-get clean all
RUN echo "gfx900" > /opt/rocm/bin/target.lst
RUN echo "gfx906" >> /opt/rocm/bin/target.lst
RUN echo "gfx803" >> /opt/rocm/bin/target.lst

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


ENV KMTHINLTO="1" LANG="C.UTF-8" LC_ALL="C.UTF-8"
ENV PATH=/opt/rocm/bin:$PATH
ENV PATH=/opt/rocm/hcc/bin:$PATH
ENV PATH=/opt/rocm/hip/bin:$PATH
ENV PATH=/opt/rocm/opencl/bin/x86_64:$PATH
ENV HIP_PLATFORM=hcc
ENV PYTORCH_TEST_WITH_ROCM=1

#Uncoment below for VG20 for now; Not required any more.
#ENV HCC_AMDGPU_TARGET=gfx906

RUN pip3 install setuptools
RUN pip3 install pyyaml numpy scipy typing enum34

# clone and build pytorch
WORKDIR /root
RUN  git clone https://github.com/pytorch/pytorch.git
WORKDIR /root/pytorch
#RUN git reset --hard 7b11ff2197ec91d7b74a76db5e3392418c9a6f35
RUN git submodule update --init
RUN python tools/amd_build/build_amd.py
RUN USE_ROCM=1 MAX_JOBS=4 python setup.py install --user 2>&1 | tee pytorch-build.log

WORKDIR /root
RUN  git clone --recurse-submodules https://github.com/pytorch/pytorch caffe2
WORKDIR /root/caffe2
#RUN git reset --hard 7b11ff2197ec91d7b74a76db5e3392418c9a6f35
RUN git submodule update --init --recursive
RUN .jenkins/caffe2/build.sh 2>&1 | tee caffe2_build.lo


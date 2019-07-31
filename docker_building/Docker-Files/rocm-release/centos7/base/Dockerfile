#docker image build command
#docker build --rm -t rocm-base-8343 --file <completepath>/Dockerfile <completepath> --no-cache
##uploaded docker image to docker hub
#docker tag 498e66734905  pramenku/tf-rocm#
#docker push pramenku/tf-rocm#


#| This Dockerfile provides a starting point for a ROCm installation of Tensorflow.
#ARG base_image
#FROM ${base_image}

FROM centos:7

MAINTAINER Pramendra Kumar <pramendra.kumar@amd.com>

ARG ROCM_PATH=/opt/rocm
ARG rocm_rel
#ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root/

ADD apt /root/apt
WORKDIR /root/apt
#RUN cp -rf /root/apt/sources.list /etc/apt/
RUN cp -rf /root/apt/resolv.conf /etc/

RUN yum clean all
RUN rm -rf /var/cache/yum/*
# Update centos
#RUN yum -y update
#RUN yum clean all

# Base
RUN yum -y install git java-1.8.0-openjdk python
RUN yum clean all

WORKDIR $HOME
# Enable epel-release repositories
RUN yum --enablerepo=extras install -y epel-release

# Install required packages
RUN yum -y install bc bridge-utils cmake cmake3 devscripts dkms doxygen dpkg dpkg-dev dpkg-perl elfutils-libelf-devel expect file gettext gcc-c++ libgcc glibc.i686 libcxx-devel ncurses ncurses-base ncurses-libs numactl-devel numactl-libs libssh libunwind-devel libunwind llvm  llvm-libs make openssl openssl-libs openssh openssh-clients pciutils pciutils-devel pciutils-libs python python-pip python-devel pkgconfig pth qemu-kvm re2c rpm rpm-build subversion wget

RUN yum clean all

# Enable the epel repository for fakeroot
RUN yum --enablerepo=extras install -y fakeroot
RUN yum clean all

# On CentOS, install package centos-release-scl available in CentOS repository:
RUN yum install -y centos-release-scl

# Install the devtoolset-7 collection:
RUN yum install -y devtoolset-7
RUN yum install -y devtoolset-7-libatomic-devel devtoolset-7-elfutils-libelf-devel

# Install the ROCm components
ADD driver /root/driver
WORKDIR /root/driver

#====================== for external repo ========================
#RUN yum clean all
#RUN wget -qO - http://repo.radeon.com/rocm/apt/debian/rocm.gpg.key | apt-key add -
#RUN sh -c 'echo deb [arch=amd64] http://repo.radeon.com/rocm/apt/debian/ xenial main > /etc/apt/sources.list.d/rocm.list'
#RUN yum-config-manager --add-repo http://repo.radeon.com/rocm/apt/centos/
#RUN yum -y update
#RUN yum install --nogpgcheck -y hsakmt-roct*.rpm hsakmt-roct-dev*.rpm
#RUN yum install --nogpgcheck -y hsa-ext-rocr-dev*.rpm hsa-rocr-dev*.rpm
#RUN yum install --nogpgcheck -y rocm-opencl*.rpm rocm-opencl-devel*.rpm rocm-smi*.rpm rocm-utils*.rpm rocminfo*.rpm  hcc*.rpm atmi*.rpm hip_base*.rpm hip_doc*.rpm hip_hcc*.rpm hip_samples*.rpm hsa-amd-aqlprofile*.rpm rocm-clang-ocl*.rpm
#RUN yum install --nogpgcheck -y rocm-profiler cxlactivitylogger miopen-hip miopengemm rocblas rocrand rocfft hipblas
# =============for internal repo======================
RUN yum clean all
RUN rm -rf /var/cache/yum/*
RUN yum-config-manager --add-repo http://172.27.226.104/artifactory/list/rocm-dkms-release-$rocm_rel-centos/
#RUN yum -y update
RUN yum install --nogpgcheck -y hsakmt-roct* hsakmt-roct-dev*
RUN yum install --nogpgcheck -y hsa-ext-rocr-dev* hsa-rocr-dev*
RUN yum install --nogpgcheck -y rocm-opencl* rocm-opencl-devel* rocm-smi*. rocm-utils* rocminfo*  hcc* atmi* hip_base* hip_doc* hip_hcc* hip_samples* hsa-amd-aqlprofile rocm-clang-ocl* rocm-cmake*
RUN yum install --nogpgcheck -y rocm-profiler cxlactivitylogger miopen-hip miopengemm rocblas rocrand rocfft hipblas rocsparse hipsparse

RUN cp -rf /root/driver/half.hpp /opt/rocm/include

ENV HCC_HOME=$ROCM_PATH/hcc
ENV HIP_PATH=$ROCM_PATH/hip
ENV OPENCL_ROOT=$ROCM_PATH/opencl
ENV PATH="$HCC_HOME/bin:$HIP_PATH/bin:${PATH}"
ENV PATH="$ROCM_PATH/bin:${PATH}"
ENV PATH="$OPENCL_ROOT/bin:${PATH}"

ARG HCC_HOME=/opt/rocm/hcc
ARG HIP_PATH=/opt/rocm/hip
ARG PATH=$HCC_HOME/bin:$HIP_PATH/bin:$PATH

RUN rm -rf ~/.cache/*
RUN echo "gfx900" >> /opt/rocm/bin/target.lst
RUN echo "gfx906" >> /opt/rocm/bin/target.lst
RUN echo "gfx803" >> /opt/rocm/bin/target.lst

WORKDIR /root/driver

# Install latest cmake and boost 1.59
RUN wget https://cmake.org/files/v3.6/cmake-3.6.2.tar.gz
RUN tar -zxvf cmake-3.6.2.tar.gz
WORKDIR cmake-3.6.2
RUN ./bootstrap --prefix=/usr/local
RUN make
RUN make install
RUN echo "PATH=/usr/local/bin:$PATH:$HOME/bin" >> ~/.bash_profile
RUN cmake --version
WORKDIR /root/driver
RUN rpm -ivh lib64icu42-4.2.1-1mdv2010.0.x86_64.rpm
RUN wget https://bintray.com/vicendominguez/CentOS6/rpm -O /etc/yum.repos.d/bintray-vicendominguez-CentOS6.repo
RUN yum -y install boost-devel

WORKDIR $HOME

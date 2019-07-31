FROM ubuntu:16.04

MAINTAINER Pramendra Kumar <pramendra.kumar@amd.com>

ARG ROCM_PATH=/opt/rocm
ARG rocm_rel
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root/

ADD apt /root/apt
WORKDIR /root/apt
#RUN cp -rf /root/apt/sources.list /etc/apt/
RUN cp -rf /root/apt/resolv.conf /etc/

RUN apt-get clean all

# Install required python2 packages
RUN apt-get -y update --fix-missing --allow-insecure-repositories && DEBIAN_FRONTEND=noninteractive apt-get install -y git dkms cmake flex bison aria2 check xsltproc cifs-utils vim ssh dos2unix python-pip-whl libpci3  libelf1 g++-multilib gcc-multilib libunwind-dev libnuma-dev bzip2

RUN apt-get clean all
RUN rm -rf /var/lib/apt/lists/*

	

# Install the ROCm components
ADD driver /root/driver
WORKDIR /root/driver


#====================== for external repo ========================
#RUN wget -qO - http://repo.radeon.com/rocm/apt/debian/rocm.gpg.key | apt-key add -
#RUN sh -c 'echo deb [arch=amd64] http://repo.radeon.com/rocm/apt/debian/ xenial main > /etc/apt/sources.list.d/rocm.list'
#RUN apt-get -y update
#RUN apt-get install -y hsakmt-roct* hsakmt-roct-dev*
#RUN apt-get install -y hsa-ext-rocr-dev* hsa-rocr-dev*
#RUN apt-get install -y rocm-opencl* rocm-opencl-devel* rocm-smi* rocm-utils* rocminfo*  hcc* atmi* hip* hsa-amd-aqlprofile* rocm-clang-ocl*
#RUN apt-get install -y rocm-profiler cxlactivitylogger miopen-hip miopengemm rocblas rocrand rocfft hipblas
# =============for internal repo======================
RUN sh -c 'echo deb [arch=amd64] http://172.27.226.104/artifactory/list/rocm-dkms-release-$rocm_rel-ubuntu/ xenial main > /etc/apt/sources.list.d/rocm.list'
RUN apt-get -y update --allow-unauthenticated
RUN apt-get install -y --allow-unauthenticated hsakmt-roct* hsakmt-roct-dev*
RUN apt-get install -y --allow-unauthenticated hsa-ext-rocr-dev* hsa-rocr-dev*
RUN apt-get install -y --allow-unauthenticated rocm-opencl* rocm-smi* rocm-utils* rocminfo*  hcc*  hip_base* hip_doc hip_hcc* hip_samples hsa-amd-aqlprofile rocm-clang-ocl rocm-cmake
RUN apt-get install -y --allow-unauthenticated rocm-profiler cxlactivitylogger miopen-hip miopengemm rocblas rocrand rocfft hipblas rocm-cmake hip-thrust hipsparse rocsparse

#RUN dpkg -i hsakmt-roct*.deb hsakmt-roct-dev*.deb
#RUN dpkg -i hsa-ext-rocr-dev*.deb hsa-rocr-dev*.deb
#RUN dpkg -i rocm-opencl*.deb rocm-opencl-dev*.deb rocm-smi*.deb rocm-utils*.deb rocminfo*.deb  hcc*.deb hip_base*.deb hip_doc*.deb hip_hcc*.deb hip_samples*.deb hsa-amd-aqlprofile*.deb rocm-clang-ocl*.deb  rocprofiler-dev*.deb atmi*.deb llvm-amdgpu*.deb rocm-cmake*.deb rocm-dev*.deb rocm-device-libs*.deb

RUN echo "gfx900" > /opt/rocm/bin/target.lst
RUN echo "gfx906" >> /opt/rocm/bin/target.lst
RUN echo "gfx803" >> /opt/rocm/bin/target.lst

ENV HCC_HOME=$ROCM_PATH/hcc
ENV HIP_PATH=$ROCM_PATH/hip
ENV OPENCL_ROOT=$ROCM_PATH/opencl
ENV PATH="$HCC_HOME/bin:$HIP_PATH/bin:${PATH}"
ENV PATH="$ROCM_PATH/bin:${PATH}"
ENV PATH="$OPENCL_ROOT/bin/x86_64:${PATH}"

RUN apt-get -y update --allow-unauthenticated

ARG HCC_HOME=/opt/rocm/hcc
ARG HIP_PATH=/opt/rocm/hip
ARG PATH=$HCC_HOME/bin:$HIP_PATH/bin:$PATH
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/rocm/lib:/opt/rocm/rccl/lib

WORKDIR $HOME




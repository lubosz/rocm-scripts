
#docker image build command

#| This Dockerfile provides a starting point for a ROCm installation of Tensorflow.
#ARG base_image
#FROM ${base_image}

#Pull ubuntu:16.04
#FROM ubuntu:16.04

#Pull ubuntu:18.04
FROM ubuntu:18.04

MAINTAINER Pramendra Kumar <pramendra.kumar@amd.com>

################################## change #1 no-npi-dkms-build #####################
ARG rocm_master=1160
##################################



ARG ROCM_PATH=/opt/rocm
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root/
ENV HIP_PLATFORM hcc

ADD apt /root/apt
WORKDIR /root/apt
#RUN cp -rf /root/apt/sources.list /etc/apt/
RUN cp -rf /root/apt/resolv.conf /etc/

RUN apt-get clean all

# Install required python2 packages
RUN apt-get -y update --fix-missing --allow-insecure-repositories && DEBIAN_FRONTEND=noninteractive apt-get install -y git dkms cmake flex bison aria2 check xsltproc cifs-utils vim ssh dos2unix  python-pip-whl libpci3 libelf1 g++-multilib gcc-multilib libunwind-dev libnuma-dev bzip2 sudo && apt-get -y update && apt-get -y install libboost-program-options-dev libfftw3-dev cmake-qt-gui zip && apt-get -y install libelf-dev && apt-get -y install libssl-dev libboost-all-dev && apt-get clean all &&  rm -rf /var/lib/apt/lists/*



# Install the ROCm components
ADD driver /root/driver
WORKDIR /root/driver
#RUN wget -N "http://10.236.104.70/job/compute-roc-master/lastSuccessfulBuild/buildNumber"
#RUN Last_success_build="$(cat buildNumber)" && echo $Last_success_build
#RUN wget http://10.236.104.70/job/compute-roc-master/"$(cat buildNumber)"/artifact/artifacts/compute-roc-master-"$(cat buildNumber)".tar.bz2
RUN rm -rf roc-master && mkdir roc-master
WORKDIR /root/driver/roc-master
RUN wget -np -nd -r -l 1 -A deb http://10.216.151.220/artifactory/rocm-osdb-deb/compute-rocm-dkms-no-npi-$rocm_master/

#RUN wget -np -nd -r -l 1 -A deb  http://10.216.151.220/artifactory/rocm-osdb-deb/compute-roc-master-$rocm_master/


RUN wget http://13.82.220.49/rocm/apt/debian/pool/main/r/rocm-profiler/rocm-profiler_5.6.7262_amd64.deb && wget http://13.82.220.49/rocm/apt/debian/pool/main/c/cxlactivitylogger/cxlactivitylogger_5.6.7259_amd64.deb && dpkg -i hsakmt-roct*.deb hsakmt-roct-dev*.deb && dpkg -i hsa-ext-rocr-dev*.deb hsa-rocr-dev*.deb && dpkg -i rocr_debug_agent*.deb comgr*.deb && dpkg -i rocm-opencl*.deb rocm-opencl-dev*.deb rocm-smi*.deb rocm_smi*.deb rocm-utils*.deb rocminfo*.deb rocm-clang-ocl*.deb hip_hcc*.deb hip_base*.deb hip_samples*.deb hip_doc*.deb hcc*.deb  hsa-amd-aqlprofile*.deb rocprofiler-dev*.deb rocm-cmake*.deb rocm-device-libs*.deb rocm-profiler*.deb cxlactivitylogger*.deb rocm_bandwidth_test*.deb rccl-*.deb rocfft*.deb rocblas*.deb hipblas*.deb rocsparse*.deb hipsparse*.deb MIOpen-HIP-*.deb miopengemm*.deb rocprim*.deb rocrand*.deb && rm -rf *.deb



WORKDIR $HOME/driver/

###########################Uncomment If you want to build HIP from Github################
#RUN git clone https://github.com/ROCm-Developer-Tools/HIP
#WORKDIR /root/driver/HIP
#RUN git reset --hard 9a5dc9fe24ca78976f9366303d336a005c90aabc
#RUN patch -p1 src/hip_peer.cpp /root/driver/0001-Revert-Fixed-issue-of-GPU-device-losing-access-to-ho.patch
#RUN echo y | ./install.sh
#########################################################
RUN echo "gfx900" > /opt/rocm/bin/target.lst
RUN echo "gfx906" >> /opt/rocm/bin/target.lst
RUN echo "gfx803" >> /opt/rocm/bin/target.lst

RUN git clone -b master https://github.com/ROCmSoftwarePlatform/rocprim.git && cd rocprim && git reset --hard 22d413d53f181733d2b09020fc9dcc52c7d948c8 && mkdir build && cd build && CXX=/opt/rocm/hcc/bin/hcc cmake -DBUILD_BENCHMARK=OFF -DDISABLE_WERROR=ON ../. 2>&1 | tee $logs/rocPRIM_build.log && make -j16 2>&1 | tee $logs/rocPRIM_build.log

WORKDIR $HOME/driver/

RUN git clone -b master https://github.com/ROCmSoftwarePlatform/rocBLAS && cd rocBLAS && git reset --hard a10549705be26e0a3673be6c87e0723161063a41 && dos2unix install.sh && ./install.sh -cd 2>&1 | tee rocblas-build.log && apt-get clean all

WORKDIR /root/driver
RUN git clone -b master https://github.com/ROCmSoftwarePlatform/hipBLAS && cd hipBLAS && git reset --hard 140ff2ca49c617f7c9f2f551e1c6507b60ddfeb5 && dos2unix install.sh && ./install.sh -cd 2>&1 | tee hipblas-build.log && apt-get clean all

WORKDIR /root/driver
RUN git clone -b master https://github.com/ROCmSoftwarePlatform/rocRAND && cd rocRAND && git reset --hard 9d7cebfc144e10e2c3b62cd4039600749f42e8a5 && rm -rf build && mkdir build && cd build && CXX=/opt/rocm/hcc/bin/hcc  cmake -DBUILD_TEST=ON -DBUILD_BENCHMARK=ON -DBUILD_CRUSH_TEST=ON -DDEPENDENCIES_FORCE_DOWNLOAD=ON ../. && make -j32 2>&1 | tee rocrand-build.log

WORKDIR /root/driver
RUN git clone -b master https://github.com/ROCmSoftwarePlatform/rocFFT && cd rocFFT && git reset --hard 185001f903c8ad5e40a3f71dfa77c9bb03e6c3c9 && dos2unix install.sh && ./install.sh -cd 2>&1 | tee rocfft-build.log && apt-get clean all

WORKDIR /root/driver
RUN git clone -b master https://github.com/ROCmSoftwarePlatform/rocSPARSE && cd /root/driver/rocSPARSE && git reset --hard 216216a5c5c8046de8f3e413ac1df8422cc188c3 && dos2unix install.sh && ./install.sh -cd 2>&1 | tee rocsparse-build.log && apt-get clean all

WORKDIR /root/driver
RUN git clone -b master https://github.com/ROCmSoftwarePlatform/hipSPARSE && cd /root/driver/hipSPARSE && git reset --hard 31002c88a6edb867e4a1c100856dc76c7641b16d && dos2unix install.sh && ./install.sh -cd 2>&1 | tee hipsparse-build.log && apt-get clean all

WORKDIR /root/driver
RUN git clone -b master https://github.com/ROCmSoftwarePlatform/rocALUTION && cd /root/driver/rocALUTION && git reset --hard b40dcb74e848301410bcba59a704a99def01778e && dos2unix install.sh && ./install.sh -cd 2>&1 | tee hipsparse-build.log && apt-get clean all

WORKDIR /root/driver
RUN wget https://phoenixnap.dl.sourceforge.net/project/half/half/1.12.0/half-1.12.0.zip && unzip *.zip && cp -rf /root/driver/include/half.hpp /opt/rocm/include
RUN ln -s /usr/include/x86_64-linux-gnu/openssl/opensslconf.h /usr/include/openssl

WORKDIR /root/driver
RUN git clone https://github.com/ROCmSoftwarePlatform/miopengemm && cd miopengemm && git reset --hard 6275a879995b58a6e0b8cca7b1ad8421a5e02ade && rm -rf build && mkdir build && cd build && cmake -DOPENCL_INCLUDE_DIRS=/opt/rocm/opencl/include/ -DOPENCL_LIBRARIES=/opt/rocm/opencl/lib/x86_64/libamdocl64.so .. &&  make -j16

WORKDIR /root/driver
RUN sudo apt-get install libsqlite3-dev && git clone -b develop https://streamhsa:AH64_uh1@github.com/AMDComputeLibraries/MLOpen.git && cd MLOpen && git reset --hard ddf70104f1f6c03f4b99df627da4ea43aaf90b54 && sed -i 's/gfx803/gfx906/g' CMakeLists.txt &&  rm -rf build_hip && mkdir build_hip && cd build_hip && CXX=/opt/rocm/hcc/bin/hcc cmake -DMIOPEN_TEST_ALL=ON -DMIOPEN_BACKEND=HIP -DMIOPEN_MAKE_BOOST_PUBLIC=ON -DMIOPEN_TEST_FLAGS="--disable-verification-cache" -DBoost_USE_STATIC_LIBS=Off -DCMAKE_PREFIX_PATH="/opt/rocm/hcc;/opt/rocm/hip" -DCMAKE_CXX_FLAGS="-isystem /usr/include/x86_64-linux-gnu/" ../. && make -j32 2>&1 | tee hipmlopen-build.log && apt-get clean all

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/rocm/lib:/opt/rocm/rccl/lib
ENV PATH=/opt/rocm/bin:$PATH
ENV HCC_HOME=/opt/rocm/hcc
ENV HIP_PATH=/opt/rocm/hip
ENV PATH=$HCC_HOME/bin:$HIP_PATH/bin:$PATH

WORKDIR /root/driver
RUN cd MLOpen && rm -rf build_ocl && mkdir build_ocl && cd build_ocl && cmake -DMIOPEN_TEST_ALL=ON -DMIOPEN_BACKEND=OpenCL -DMIOPEN_MAKE_BOOST_PUBLIC=ON -DBoost_USE_STATIC_LIBS=Off -DMIOPEN_TEST_FLAGS="--disable-verification-cache" -DOPENCL_INCLUDE_DIRS=/opt/rocm/opencl/include/ -DOPENCL_LIBRARIES=/opt/rocm/opencl/lib/x86_64/libamdocl64.so .. | tee -a mlopenocl_build.log && make -j16 | tee -a mlopenocl_build.log && make package | tee -a mlopenocl_build.log

WORKDIR /root/driver

#RUN apt-get -y install pkg-config protobuf-compiler libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev libatlas-base-dev libboost-all-dev libgflags-dev libgoogle-glog-dev liblmdb-dev python-numpy python-scipy python3-dev python-yaml python-pip libopencv-dev libfftw3-dev libelf-dev libopenblas-base libopenblas-dev

#RUN git clone -b hip https://github.com/rocmsoftwareplatform/hipcaffe
#WORKDIR /root/driver/hipcaffe
#ENV INCLUDE_DIR=/opt/rocm/include
#RUN cp Makefile.config.example Makefile.config

##########################Uncomment for Ubuntu18.04#################################
#RUN  sed -i 's/atlas/open/g' Makefile.config && sed -i 's/# OPENCV_VERSION := 3/OPENCV_VERSION := 3/g' Makefile.config
###########################################################

#RUN make -j16 2>&1 | tee hipcaffe_build.log && ./data/ilsvrc12/get_ilsvrc_aux.sh 2>&1 | tee -a  hipcaffe_build.log && ./scripts/download_model_binary.py models/bvlc_reference_caffenet 2>&1 | tee -a hipcaffe_build.log && ./data/cifar10/get_cifar10.sh 2>&1 | tee -a hipcaffe_build.log && ./examples/cifar10/create_cifar10.sh 2>&1 | tee -a hipcaffe_build.log && ./data/mnist/get_mnist.sh 2>&1 | tee -a hipcaffe_build.log && ./examples/mnist/create_mnist.sh 2>&1 | tee -a hipcaffe_build.log

#WORKDIR /root/driver
#RUN rm -rf rccl
#RUN git clone https://github.com/ROCmSoftwarePlatform/rccl && cd /root/driver/rccl && mkdir build && cd build && CXX=/opt/rocm/bin/hcc cmake .. | tee rccl-build.log && make package 2>&1 | tee -a rccl-build.log && dpkg -i *.deb

#WORKDIR /root/driver
#RUN git clone https://streamhsa:AH64_uh1@github.com/ROCmSoftwarePlatform/deepbench
#WORKDIR /root/driver/deepbench/code/amd
#RUN sed -i 's/-O3/-O3 -I\/opt\/rocm\/include/g' Makefile && make all 2>&1 | tee deepbench_build.log

WORKDIR $HOME


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
ARG rocm_master=2004
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

RUN sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/us.archive.ubuntu.com/g' /etc/apt/sources.list

RUN apt-get -y update --fix-missing --allow-insecure-repositories ; DEBIAN_FRONTEND=noninteractive apt-get install -y git dkms cmake flex bison aria2 check xsltproc cifs-utils vim ssh dos2unix  python-pip-whl libpci3 libelf1 g++-multilib gcc-multilib libunwind-dev libnuma-dev bzip2 sudo ; apt-get -y update ; apt-get install -y libfile-basedir-perl libfile-copy-recursive-perl libfile-listing-perl libfile-which-perl ; apt-get -y install libboost-program-options-dev libfftw3-dev cmake-qt-gui zip ; apt-get -y install libelf-dev ; apt-get -y install libssl-dev libboost-all-dev ; apt-get clean all ;  rm -rf /var/lib/apt/lists/*



# Install the ROCm components
ADD driver /root/driver
WORKDIR /root/driver
#RUN wget -N "http://10.236.104.70/job/compute-roc-master/lastSuccessfulBuild/buildNumber"
#RUN Last_success_build="$(cat buildNumber)" ; echo $Last_success_build
#RUN wget http://10.236.104.70/job/compute-roc-master/"$(cat buildNumber)"/artifact/artifacts/compute-roc-master-"$(cat buildNumber)".tar.bz2
RUN rm -rf roc-master ; mkdir roc-master
WORKDIR /root/driver/roc-master
RUN wget -np -nd -r -l 1 -A deb http://compute-artifactory.amd.com/artifactory/rocm-osdb-deb/compute-rocm-dkms-no-npi-$rocm_master/ ; rm -rf *clients*

#RUN wget -np -nd -r -l 1 -A deb  http://10.216.151.220/artifactory/rocm-osdb-deb/compute-roc-master-$rocm_master/


#RUN wget http://13.82.220.49/rocm/apt/debian/pool/main/r/rocm-profiler/rocm-profiler_5.6.7262_amd64.deb ; wget http://13.82.220.49/rocm/apt/debian/pool/main/c/cxlactivitylogger/cxlactivitylogger_5.6.7259_amd64.deb ; dpkg -i hsakmt-roct*.deb hsakmt-roct-dev*.deb ; dpkg -i hsa-ext-rocr-dev*.deb hsa-rocr-dev*.deb ; dpkg -i rocm-debug-agent*.deb comgr*.deb ; dpkg -i rocm-opencl*.deb rocm-opencl-dev*.deb rocm-smi*.deb rocm-utils*.deb rocminfo*.deb rocm-clang-ocl*.deb hip_hcc*.deb hip_base*.deb hip_samples*.deb hip_doc*.deb hcc*.deb  hsa-amd-aqlprofile*.deb rocprofiler-dev*.deb rocm-cmake*.deb rocm-device-libs*.deb rocm-profiler*.deb cxlactivitylogger*.deb rocm-bandwidth-test*.deb rccl-*.deb rocfft*.deb rocblas*.deb hipblas*.deb rocsparse*.deb hipsparse*.deb MIOpen-HIP-*.deb miopengemm*.deb rocprim*.deb rocalution*.deb rocrand*.deb rocthrust*.deb hipcub*.deb rocsolver*.deb ; rm -rf *.deb


RUN wget http://13.82.220.49/rocm/apt/debian/pool/main/r/rocm-profiler/rocm-profiler_5.6.7262_amd64.deb ; wget http://13.82.220.49/rocm/apt/debian/pool/main/c/cxlactivitylogger/cxlactivitylogger_5.6.7259_amd64.deb ; dpkg -i hsakmt-roct*.deb hsakmt-roct-dev*.deb ; dpkg -i hsa-ext-rocr-dev*.deb hsa-rocr-dev*.deb ; dpkg -i rocm-debug-agent*.deb comgr*.deb ; dpkg -i rocm-opencl*.deb rocm-opencl-dev*.deb rocm-smi*.deb rocm-utils*.deb rocminfo*.deb rocm-clang-ocl*.deb hip-hcc*.deb hip-base*.deb hip-samples*.deb hip-doc*.deb hcc*.deb  hsa-amd-aqlprofile*.deb rocprofiler-dev*.deb rocm-cmake*.deb rocm-device-libs*.deb rocm-profiler*.deb roctracer-dev*.deb cxlactivitylogger*.deb rocm-bandwidth-test*.deb rccl-*.deb rocfft-*.deb rocblas-*.deb hipblas-*.deb rocsparse-*.deb hipsparse-*.deb MIOpen-HIP-*.deb miopengemm-*.deb rocprim-*.deb rocalution-*.deb rocrand*.deb rocthrust*.deb hipcub*.deb rocsolver*.deb rocm-dev*.deb ; rm -rf *.deb

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
RUN echo "gfx908" >> /opt/rocm/bin/target.lst
RUN echo "gfx803" >> /opt/rocm/bin/target.lst

RUN git clone -b master https://github.com/ROCmSoftwarePlatform/rocPRIM.git ; cd rocPRIM ; git reset --hard 5fa0c79fbb199f83c5202d9e218311a78335a1f4 ; mkdir build ; cd build ; CXX=/opt/rocm/hcc/bin/hcc cmake -DBUILD_BENCHMARK=OFF -DDISABLE_WERROR=ON ../. 2>&1 | tee $logs/rocPRIM_build.log ; make -j$(nproc) 2>&1 | tee $logs/rocPRIM_build.log

WORKDIR $HOME/driver/

RUN rm -rf rocBLAS ; git clone -b master https://github.com/ROCmSoftwarePlatform/rocBLAS ; cd rocBLAS ; git reset --hard 740602e3f3c21886dbf3159d892426842c52b60f ; dos2unix install.sh ; ./install.sh -cd 2>&1 | tee rocblas-build.log ; apt-get clean all

WORKDIR /root/driver
RUN git clone -b master https://github.com/ROCmSoftwarePlatform/hipBLAS ; cd hipBLAS ; git reset --hard 172deed6d88861ca4e07054cb38b7371f1f02457 ; dos2unix install.sh ; ./install.sh -cd 2>&1 | tee hipblas-build.log ; apt-get clean all

WORKDIR /root/driver
RUN git clone -b master https://github.com/ROCmSoftwarePlatform/rocRAND ; cd rocRAND ; git reset --hard 448c673d94e542d49e771208f3721d849ba22fa7 ; rm -rf build ; mkdir build ; cd build ; CXX=/opt/rocm/hcc/bin/hcc  cmake -DBUILD_TEST=ON -DBUILD_BENCHMARK=ON -DBUILD_CRUSH_TEST=ON -DDEPENDENCIES_FORCE_DOWNLOAD=ON ../. ; make -j$(nproc) 2>&1 | tee rocrand-build.log

WORKDIR /root/driver
RUN git clone -b master https://github.com/ROCmSoftwarePlatform/rocFFT ; cd rocFFT ; git reset --hard 0c6af4840f28e576dc3590c34160160b096f3bd6 ; dos2unix install.sh ; ./install.sh -cd 2>&1 | tee rocfft-build.log ; apt-get clean all

WORKDIR /root/driver
RUN git clone -b master https://github.com/ROCmSoftwarePlatform/rocSPARSE ; cd /root/driver/rocSPARSE ; git reset --hard 636fb217b82ffa5a8de7a6d0f13ea5a27c9637d8 ; dos2unix install.sh ; ./install.sh -cd 2>&1 | tee rocsparse-build.log ; apt-get clean all

WORKDIR /root/driver
RUN git clone -b master https://github.com/ROCmSoftwarePlatform/hipSPARSE ; cd /root/driver/hipSPARSE ; git reset --hard 3085fe5f60ca35237b001f97f31acd2f2c0fcef9 ; dos2unix install.sh ; ./install.sh -cd 2>&1 | tee hipsparse-build.log ; apt-get clean all

WORKDIR /root/driver
RUN git clone -b master https://github.com/ROCmSoftwarePlatform/rocALUTION ; cd /root/driver/rocALUTION ; git reset --hard 7220da118dd7dc452ad5d82dfc57a8891416fe4b ; dos2unix install.sh ; ./install.sh -cd 2>&1 | tee rocalution-build.log ; apt-get clean all

RUN git clone -b master https://github.com/ROCmSoftwarePlatform/rocTHRUST.git ; cd rocTHRUST ; git reset --hard c4b532816c18e9822d89b2c6da582b90bb5c2d3d ; 

#dos2unix install ; ./install -ict 2>&1 | tee rocthrust-build.log ; apt-get clean all

RUN git clone -b master https://github.com/ROCmSoftwarePlatform/hipCUB.git ; cd hipCUB ; git reset --hard 40e1d662cdec4334f493aa9bc4a23d91540d069d ; 

#dos2unix install ; ./install -ict 2>&1 | tee hipcub-build.log ; apt-get clean all

RUN git clone -b master https://github.com/ROCmSoftwarePlatform/rocSOLVER.git ; cd rocSOLVER ; git reset --hard aa6ad2e9086725b5086f95e71443680b3cd869c1 ; 

#dos2unix install ; ./install -ict 2>&1 | tee rocsolver-build.log ; apt-get clean all

WORKDIR /root/driver
RUN rm -rf half.hpp ; wget https://phoenixnap.dl.sourceforge.net/project/half/half/1.12.0/half-1.12.0.zip ; unzip *.zip ; cp -rf /root/driver/include/half.hpp /opt/rocm/include
RUN ln -s /usr/include/x86_64-linux-gnu/openssl/opensslconf.h /usr/include/openssl

WORKDIR /root/driver
RUN git clone https://github.com/ROCmSoftwarePlatform/miopengemm ; cd miopengemm ; git reset --hard b51a12523676451bf38bfcf0506a0745e80ac64f ; rm -rf build ; mkdir build ; cd build ; cmake -DOPENCL_INCLUDE_DIRS=/opt/rocm/opencl/include/ -DOPENCL_LIBRARIES=/opt/rocm/opencl/lib/x86_64/libamdocl64.so .. ;  make -j$(nproc)

WORKDIR /root/driver
RUN sudo apt-get install libsqlite3-dev ; git clone -b develop https://streamhsa:AH64_uh1@github.com/AMDComputeLibraries/MLOpen.git ; cd MLOpen ; git reset --hard e489cf57be2e06eda875c53daee7b15136b6eaec

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/rocm/lib:/opt/rocm/rccl/lib
ENV PATH=/opt/rocm/bin:$PATH
ENV HCC_HOME=/opt/rocm/hcc
ENV HIP_PATH=/opt/rocm/hip
ENV PATH=$HCC_HOME/bin:$HIP_PATH/bin:$PATH

#WORKDIR /root/driver
#RUN cd MLOpen ; rm -rf build_ocl ; mkdir build_ocl ; cd build_ocl ; cmake -DMIOPEN_TEST_ALL=ON -DMIOPEN_BACKEND=OpenCL -DMIOPEN_MAKE_BOOST_PUBLIC=ON -DBoost_USE_STATIC_LIBS=Off -DMIOPEN_TEST_FLAGS="--disable-verification-cache" -DOPENCL_INCLUDE_DIRS=/opt/rocm/opencl/include/ -DOPENCL_LIBRARIES=/opt/rocm/opencl/lib/x86_64/libamdocl64.so .. | tee -a mlopenocl_build.log ; make -j$(nproc) | tee -a mlopenocl_build.log ; make package | tee -a mlopenocl_build.log

WORKDIR /root/driver

#RUN apt-get -y install pkg-config protobuf-compiler libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev libatlas-base-dev libboost-all-dev libgflags-dev libgoogle-glog-dev liblmdb-dev python-numpy python-scipy python3-dev python-yaml python-pip libopencv-dev libfftw3-dev libelf-dev libopenblas-base libopenblas-dev

#RUN git clone -b hip https://github.com/rocmsoftwareplatform/hipcaffe
#WORKDIR /root/driver/hipcaffe
#ENV INCLUDE_DIR=/opt/rocm/include
#RUN cp Makefile.config.example Makefile.config

##########################Uncomment for Ubuntu18.04#################################
#RUN  sed -i 's/atlas/open/g' Makefile.config ; sed -i 's/# OPENCV_VERSION := 3/OPENCV_VERSION := 3/g' Makefile.config
###########################################################

#RUN make -j$(nproc) 2>&1 | tee hipcaffe_build.log ; ./data/ilsvrc12/get_ilsvrc_aux.sh 2>&1 | tee -a  hipcaffe_build.log ; ./scripts/download_model_binary.py models/bvlc_reference_caffenet 2>&1 | tee -a hipcaffe_build.log ; ./data/cifar10/get_cifar10.sh 2>&1 | tee -a hipcaffe_build.log ; ./examples/cifar10/create_cifar10.sh 2>&1 | tee -a hipcaffe_build.log ; ./data/mnist/get_mnist.sh 2>&1 | tee -a hipcaffe_build.log ; ./examples/mnist/create_mnist.sh 2>&1 | tee -a hipcaffe_build.log

#WORKDIR /root/driver
#RUN rm -rf rccl
#RUN git clone https://github.com/ROCmSoftwarePlatform/rccl ; cd /root/driver/rccl ; mkdir build ; cd build ; CXX=/opt/rocm/bin/hcc cmake .. | tee rccl-build.log ; make package 2>&1 | tee -a rccl-build.log ; dpkg -i *.deb

#WORKDIR /root/driver
#RUN git clone https://streamhsa:AH64_uh1@github.com/ROCmSoftwarePlatform/deepbench
#WORKDIR /root/driver/deepbench/code/amd
#RUN sed -i 's/-O3/-O3 -I\/opt\/rocm\/include/g' Makefile ; make all 2>&1 | tee deepbench_build.log

WORKDIR $HOME
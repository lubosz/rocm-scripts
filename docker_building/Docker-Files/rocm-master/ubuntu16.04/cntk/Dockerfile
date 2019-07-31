#| This Dockerfile provides a starting point for a ROCm installation of Tensorflow.
ARG base_image
FROM ${base_image}

#FROM ubuntu:18.04

MAINTAINER Pramendra Kumar <pramendra.kumar@amd.com>


WORKDIR $HOME/driver
# Install Pre-req
RUN apt-get clean all
RUN apt-get update
RUN apt-get -y install git autoconf automake libtool curl make g++ unzip zlib1g-dev libbz2-dev python-dev 


RUN mkdir cntk
WORKDIR /root/driver/cntk
RUN rm -rf *
RUN rm -rf /usr/local/mklml 

RUN mkdir /usr/local/mklml 
RUN wget https://github.com/01org/mkl-dnn/releases/download/v0.12/mklml_lnx_2018.0.1.20171227.tgz 
RUN tar -xzf mklml_lnx_2018.0.1.20171227.tgz -C /usr/local/mklml 
RUN wget --no-verbose -O - https://github.com/01org/mkl-dnn/archive/v0.12.tar.gz | tar -xzf - 
WORKDIR /root/driver/cntk/mkl-dnn-0.12  
RUN ln -s /usr/local external 
RUN mkdir build 
WORKDIR /root/driver/cntk/mkl-dnn-0.12/build 
RUN cmake ..  | tee cntk_build.log 
RUN make -j16 
RUN make install | tee -a cntk_build.log

WORKDIR /root/driver/cntk
RUN wget https://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.3.tar.gz 
RUN tar -xzvf ./openmpi-1.10.3.tar.gz 
WORKDIR /root/driver/cntk/openmpi-1.10.3 
RUN ./configure --prefix=/usr/local/mpi
RUN make -j all 
RUN make install | tee -a cntk_build.log
RUN echo "export PATH=/usr/local/mpi/bin:$PATH" >> ~/.bashrc 
ENV LD_LIBRARY_PATH=/usr/local/mpi/lib:$LD_LIBRARY_PATH

WORKDIR /root/driver/cntk
RUN wget https://github.com/google/protobuf/archive/v3.1.0.tar.gz 
RUN tar -xzf v3.1.0.tar.gz 
WORKDIR /root/driver/cntk/protobuf-3.1.0  
RUN ./autogen.sh
RUN ./configure CFLAGS=-fPIC CXXFLAGS=-fPIC --disable-shared --prefix=/usr/local/protobuf-3.1.0 
RUN make -j $(nproc) 
RUN make install | tee -a cntk_build.log

WORKDIR /root/driver/cntk
RUN wget http://nih.at/libzip/libzip-1.1.2.tar.gz
RUN tar -xzvf ./libzip-1.1.2.tar.gz 
WORKDIR /root/driver/cntk/libzip-1.1.2  
RUN ./configure
RUN make -j all 
RUN make install | tee -a cntk_build.log
ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH


WORKDIR /root/driver/cntk
RUN wget -q -O - https://sourceforge.net/projects/boost/files/boost/1.60.0/boost_1_60_0.tar.gz/download | tar -xzf -
WORKDIR /root/driver/cntk/boost_1_60_0
RUN ./bootstrap.sh --prefix=/usr/local/boost-1.60.0
RUN ./b2 -d0 -j"$(nproc)" install  | tee -a cntk_build.log


ARG HCC_HOME=/opt/rocm/hcc
ARG HIP_PATH=/opt/rocm/hip
ARG PATH=$HCC_HOME/bin:$HIP_PATH/bin:$PATH


ENV PATH=/opt/rocm/bin:$PATH
ENV PATH=/opt/rocm/hcc/bin:$PATH
ENV PATH=/opt/rocm/hip/bin:$PATH
ENV PATH=/opt/rocm/opencl/bin/x86_64:$PATH

WORKDIR /root/driver/cntk
RUN git clone -b hipDNN_debug https://github.com/ROCmSoftwarePlatform/CNTK-1.git | tee -a cntk_build.log
WORKDIR /root/driver/cntk/CNTK-1
RUN ./configure --asgd=no | tee -a cntk_build.log
RUN make -j $(nproc) all | tee -a cntk_build.log


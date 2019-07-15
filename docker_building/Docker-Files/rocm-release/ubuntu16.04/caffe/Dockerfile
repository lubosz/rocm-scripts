#docker image build command
#docker build --rm -t pramenku/tf1.8:rocm# --file <completepath>/Dockerfile <completepath>
##uploaded docker image to docker hub
#docker tag 498e66734905  pramenku/tf-rocm#
#docker push pramenku/tf-rocm#


#| This Dockerfile provides a starting point for a ROCm installation
ARG base_image
FROM ${base_image}

#FROM ubuntu:16.04

MAINTAINER Pramendra Kumar <pramendra.kumar@amd.com>


WORKDIR $HOME/driver
# Install Pre-req
RUN apt-get clean all
RUN apt-get install -y curl pkg-config protobuf-compiler libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev libatlas-base-dev libboost-all-dev libgflags-dev libgoogle-glog-dev liblmdb-dev python-numpy python-scipy python3-dev python-yaml python-pip libopencv-dev libfftw3-dev libelf-dev

#RUN rm -rf ~/.cache/*
#RUN echo "gfx900" > /opt/rocm/bin/target.lst
#RUN echo "gfx906" >> /opt/rocm/bin/target.lst

ENV PATH=/opt/rocm/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/rocm/lib:$LD_LIBRARY_PATH
ENV INCLUDE_DIR=/opt/rocm/include


# Clone and build Caffe
RUN cd $HOME  && git clone -b hip https://github.com/rocmsoftwareplatform/hipcaffe
WORKDIR $HOME/hipcaffe
RUN cp Makefile.config.example Makefile.config
#RUN sed -i 's/gfx803/gfx906/g' CMakeLists.txt
RUN make -j16 | tee hipcaffe_build.log
RUN make -j16 test | tee -a hipcaffe_build.log
##########Below are one time download data sets for every cycle#####
RUN ./data/ilsvrc12/get_ilsvrc_aux.sh 2>&1 | tee -a  hipcaffe_build.log
RUN ./scripts/download_model_binary.py models/bvlc_reference_caffenet 2>&1 | tee -a hipcaffe_build.log

RUN ./data/cifar10/get_cifar10.sh 2>&1 | tee -a hipcaffe_build.log
RUN ./examples/cifar10/create_cifar10.sh 2>&1 | tee -a hipcaffe_build.log

RUN ./data/mnist/get_mnist.sh 2>&1 | tee -a hipcaffe_build.log
RUN ./examples/mnist/create_mnist.sh 2>&1 | tee -a hipcaffe_build.log

WORKDIR $HOME/hipcaffe



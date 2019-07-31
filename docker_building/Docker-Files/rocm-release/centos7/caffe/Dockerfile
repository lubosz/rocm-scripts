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
RUN yum clean all
RUN yum install -y gflags-devel lmdb* glog-devel opencv-devel protobuf-compiler protobuf-devel hdf5-devel compat-db leveldb-devel snappy-devel atlas* blas*

# Clone and build Caffe
RUN cd $HOME  && git clone -b hip-centos https://github.com/rocmsoftwareplatform/hipcaffe
WORKDIR $HOME/hipcaffe

ENV INCLUDE_DIR=/opt/rocm/include

RUN cp Makefile.config.example Makefile.config
#RUN  sed -i 's/gfx900/gfx906/g' Makefile.config
RUN make -j$(nproc) | tee hipcaffe_build.log
RUN make -j$(nproc) test | tee -a hipcaffe_build.log

##########Below are one time download data sets for every cycle#####
RUN ./data/ilsvrc12/get_ilsvrc_aux.sh 2>&1 | tee -a  hipcaffe_build.log
RUN ./scripts/download_model_binary.py models/bvlc_reference_caffenet 2>&1 | tee -a hipcaffe_build.log

RUN ./data/cifar10/get_cifar10.sh 2>&1 | tee -a hipcaffe_build.log
RUN ./examples/cifar10/create_cifar10.sh 2>&1 | tee -a hipcaffe_build.log

RUN ./data/mnist/get_mnist.sh 2>&1 | tee -a hipcaffe_build.log
RUN ./examples/mnist/create_mnist.sh 2>&1 | tee -a hipcaffe_build.log

WORKDIR $HOME/hipcaffe

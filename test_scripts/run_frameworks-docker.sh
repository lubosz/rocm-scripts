#!/bin/bash
current=`pwd`
dir=/root/driver
logs=/dockerx


cd $dir/deepbench/code/amd/bin/

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/rocm/lib:/opt/rocm/rccl/lib
echo "===================gemm bench=========" | tee $logs/deepbench_run.log
./gemm_bench 2>&1 | tee -a $logs/deepbench_run.log
echo "===================conv bench=========" | tee -a $logs/deepbench_run.log
./conv_bench 2>&1 | tee -a $logs/deepbench_run.log
echo "===================rnn bench=========" | tee -a $logs/deepbench_run.log
./rnn_bench | tee -a $logs/deepbench_run.log
echo "===================rccl_single_all_reduce=========" | tee -a $logs/deepbench_run.log
./rccl_single_all_reduce 1 | tee -a $logs/deepbench_run.log

cd $dir/hipcaffe
export PATH=/opt/rocm/bin:$PATH
export LD_LIBRARY_PATH=/opt/rocm/lib:$LD_LIBRARY_PATH

./build/examples/cpp_classification/classification.bin \
        models/bvlc_reference_caffenet/deploy.prototxt \
    models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel \
    data/ilsvrc12/imagenet_mean.binaryproto \
    data/ilsvrc12/synset_words.txt \
    examples/images/cat.jpg 2>&1 | tee $logs/hipcaffe_caffenet.log


./examples/mnist/train_lenet.sh --gpu 0 2>&1 | tee $logs/hipcaffe_mnist.log
./build/tools/caffe train --solver=examples/cifar10/cifar10_quick_solver.prototxt --gpu 0 2>&1 | tee $logs/hipcaffe_cifar10.log

#============MIOpen_HIP===================

sudo dpkg -r miopen-hip
sudo dpkg -r miopen-opencl

cd $dir/MLOpen/

mkdir -p build_hip && cd build_hip

rm -rf *

#To build MIOpen with HIP backend
CXX=/opt/rocm/hcc/bin/hcc cmake -DMIOPEN_TEST_ALL=ON -DMIOPEN_BACKEND=HIP -DMIOPEN_MAKE_BOOST_PUBLIC=ON -DMIOPEN_TEST_FLAGS="--disable-verification-cache" -DBoost_USE_STATIC_LIBS=Off -DCMAKE_PREFIX_PATH="/opt/rocm/hcc;/opt/rocm/hip" -DCMAKE_CXX_FLAGS="-isystem /usr/include/x86_64-linux-gnu/" .. | tee -a mlopenhip_build.log

make -j16 | tee -a mlopenhip_build.log
make package | tee -a mlopenhip_build.log
echo AH64_uh1 | sudo dpkg -i *.deb

cd $dir/MLOpen/build_hip

export MIOPEN_CONV_PRECISE_ROCBLAS_TIMING=0
make check -j16 2>&1| tee $logs/mlopen-ut-hip.log
unset MIOPEN_CONV_PRECISE_ROCBLAS_TIMING


#============MIOpen_OCL===================

sudo dpkg -r miopen-hip

cd $dir/MLOpen/

mkdir -p build_ocl && cd build_ocl

rm -rf *

#To build MIOpen with OpenCL backend 
cmake -DMIOPEN_TEST_ALL=ON -DMIOPEN_BACKEND=OpenCL -DMIOPEN_MAKE_BOOST_PUBLIC=ON -DBoost_USE_STATIC_LIBS=Off -DMIOPEN_TEST_FLAGS="--disable-verification-cache" -DOPENCL_INCLUDE_DIRS=/opt/rocm/opencl/include/ -DOPENCL_LIBRARIES=/opt/rocm/opencl/lib/x86_64/libamdocl64.so .. | tee -a mlopenocl_build.log

make -j16 | tee -a mlopenocl_build.log
make package | tee -a mlopenocl_build.log
echo AH64_uh1 | sudo dpkg -i *.deb


cd $dir/MLOpen/build_ocl
export MIOPEN_CONV_PRECISE_ROCBLAS_TIMING=0
make check -j16 2>&1| tee $logs/mlopen-ut-ocl.log
unset MIOPEN_CONV_PRECISE_ROCBLAS_TIMING
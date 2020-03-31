#!/bin/bash
current=`pwd`
dir=/root/driver
logs=/dockerx

#============MIOpen_HIP===================

sudo dpkg -r miopen-hip
sudo dpkg -r miopen-opencl

cd $dir/MLOpen/

mkdir -p build_hip && cd build_hip

rm -rf *

#To build MIOpen with HIP backend
CXX=/opt/rocm/hcc/bin/hcc cmake -DMIOPEN_TEST_ALL=ON -DMIOPEN_BACKEND=HIP -DMIOPEN_MAKE_BOOST_PUBLIC=ON -DMIOPEN_TEST_FLAGS="--disable-verification-cache" -DBoost_USE_STATIC_LIBS=Off -DCMAKE_PREFIX_PATH="/opt/rocm/hcc;/opt/rocm/hip" -DCMAKE_CXX_FLAGS="-isystem /usr/include/x86_64-linux-gnu/" .. | tee -a $logs/mlopenhip_build.log

make -j$(nproc) | tee -a $logs/mlopenhip_build.log
make package | tee -a $logs/mlopenhip_build.log
echo AH64_uh1 | sudo dpkg -i *.deb

export MIOPEN_CONV_PRECISE_ROCBLAS_TIMING=0
make check -j$(nproc) 2>&1| tee $logs/mlopen-ut-hip.log
unset MIOPEN_CONV_PRECISE_ROCBLAS_TIMING


#============MIOpenDriver_CONV===================

cd $dir/MLOpen/build_hip/bin
export MIOPEN_CONV_PRECISE_ROCBLAS_TIMING=0
./MIOpenDriver conv -W 341 -H 79 -c 32 -n 4 -k 32 -y 5 -x 10 -p 0 -q 0 -u 2 -v 2 -t 1 -V 0 -i 1 | tee -a $logs/MIOpenDriver_run.log
./MIOpenDriver conv -n 1 -c 512 -H 256 -W 256 -k 6 -y 1 -x 1 -p 0 -q 0 -u 1 -v 1 -l 1 -j 1 -m conv -g 1 -t 1 2>&1 | tee -a $logs/MIOpenDriver_run.log
./MIOpenDriver conv -n 1 -c 64 -H 130 -W 130 -k 3 -y 3 -x 3 -p 0 -q 0 -u 1 -v 1 -l 1 -j 1 -m conv -g 1 -t 1 2>&1 | tee -a $logs/MIOpenDriver_run.log
unset MIOPEN_CONV_PRECISE_ROCBLAS_TIMING


#============MIOpen_OCL===================

sudo dpkg -r miopen-hip

cd $dir/MLOpen/

mkdir -p build_ocl && cd build_ocl

rm -rf *

#To build MIOpen with OpenCL backend 
cmake -DMIOPEN_TEST_ALL=ON -DMIOPEN_BACKEND=OpenCL -DMIOPEN_MAKE_BOOST_PUBLIC=ON -DBoost_USE_STATIC_LIBS=Off -DMIOPEN_TEST_FLAGS="--disable-verification-cache" -DOPENCL_INCLUDE_DIRS=/opt/rocm/opencl/include/ -DOPENCL_LIBRARIES=/opt/rocm/opencl/lib/x86_64/libamdocl64.so .. | tee -a $logs/mlopenocl_build.log

make -j$(nproc) | tee -a $logs/mlopenocl_build.log
make package | tee -a $logs/mlopenocl_build.log
echo AH64_uh1 | sudo dpkg -i *.deb


export MIOPEN_CONV_PRECISE_ROCBLAS_TIMING=0
make check -j$(nproc) 2>&1| tee $logs/mlopen-ut-ocl.log
unset MIOPEN_CONV_PRECISE_ROCBLAS_TIMING

sudo dpkg -r miopen-opencl

cd $dir/MLOpen/build_hip
echo AH64_uh1 | sudo dpkg -i *.deb
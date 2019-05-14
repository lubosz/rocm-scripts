#!/bin/bash
current=`pwd`
dir=/root/driver
logs=/dockerx

cd $dir/MLOpen/build_hip
export MIOPEN_CONV_PRECISE_ROCBLAS_TIMING=0
make check -j16 2>&1| tee $logs/mlopen-ut.log
unset MIOPEN_CONV_PRECISE_ROCBLAS_TIMING

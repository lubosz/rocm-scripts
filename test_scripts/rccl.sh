#!/bin/sh
dir=/dockerx/rocm-scripts/RCCL
cd $dir/build_rccl
./rccl_build.sh
cp -rf RCCL-build.log /dockerx/
cd $dir/all_gather_perf
./all_gather_perf.sh
cp -rf all_gather_perf.log /dockerx/
cd $dir/all_reduce_perf
./all_reduce_perf.sh
cp -rf all_reduce_perf.log /dockerx/
cd $dir/broadcast_perf
./broadcast_perf.sh
cp -rf broadcast_perf.log /dockerx/
cd $dir/reduce_perf
./reduce_perf.sh
cp -rf reduce_perf.log /dockerx/
cd $dir/reduce_scatter_perf
./reduce_scatter_perf.sh
cp -rf reduce_scatter_perf.log /dockerx/
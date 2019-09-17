#!/bin/bash
current=`pwd`
dir=/root/driver
logs=/dockerx

cd $dir/rocRAND/build
ctest --output-on-failure 2>&1 | tee $logs/rocrand-ut.log
./benchmark/benchmark_rocrand_kernel --engine all --dis all 2>&1 | tee $logs/bm_rocrand_kernal.log
./benchmark/benchmark_rocrand_generate --engine all --dis all 2>&1 | tee $logs/bm_rocrand_generate.log
cd $dir
./rocBLAS/build/release/clients/staging/rocblas-test --gtest_filter=-*known_bug* 2>&1 | tee $logs/rocblas.log
./hipBLAS/build/release/clients/staging/hipblas-test 2>&1 | tee $logs/hipblas.log
./rocFFT/build/release/clients/staging/rocfft-test 2>&1 | tee $logs/rocfft.log
./rocSPARSE/build/release/clients/staging/rocsparse-test 2>&1 | tee $logs/rocsparse-test.log
./hipSPARSE/build/release/clients/staging/hipsparse-test 2>&1 | tee $logs/hipsparse-test.log

cd $dir
git clone -b master https://github.com/ROCmSoftwarePlatform/rocprim.git
cd rocprim

rm -rf build

mkdir build && cd build
CXX=/opt/rocm/hcc/bin/hcc cmake -DBUILD_BENCHMARK=OFF -DDISABLE_WERROR=ON ../. 2>&1 | tee $logs/rocPRIM_build.log
make -j16 2>&1 | tee $logs/rocPRIM_build.log

cd $dir/rocprim/build
ctest --output-on-failure 2>&1 | tee $logs/rocPRIM_unittest.log

cd $dir
git clone -b master https://github.com/ROCmSoftwarePlatform/rocALUTION.git
cd rocALUTION
./install.sh -icd 2>&1 | tee $logs/rocALUTION-build.log

cd $dir/rocALUTION/build/release/clients/staging
./rocalution-test 2>&1 | tee $logs/rocalution-test.log

sudo apt-get install python-prettytable

cd /dockerx/

git pull https://streamhsa:AH64_uh1@github.com/RadeonOpenCompute/MLSEQA_TestRepo
cd MLSEQA_TestRepo/Libs/hipCUB
python hipCUB.py 2>&1 | tee -a /dockerx/hipCUB.log


cd /dockerx/MLSEQA_TestRepo/Libs/rocThrust
python rocThrust.py 2>&1 | tee -a /dockerx/rocThrust.log

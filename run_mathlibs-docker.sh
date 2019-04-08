#!/bin/bash
current=`pwd`
dir=/root/driver
logs=/dockerx

cd $dir/rocrand/build
ctest --output-on-failure 2>&1 | tee $logs/rocrand-ut.log
./benchmark/benchmark_rocrand_kernel --engine all --dis all 2>&1 | tee $logs/bm_rocrand_kernal.log
./benchmark/benchmark_rocrand_generate --engine all --dis all 2>&1 | tee $logs/bm_rocrand_generate.log
cd $dir
./rocblas/build/release/clients/staging/rocblas-test --gtest_filter=-*known_bug* 2>&1 | tee $logs/rocblas.log
./hipblas/build/release/clients/staging/hipblas-test 2>&1 | tee $logs/hipblas.log
./rocfft/build/release/clients/staging/rocfft-test 2>&1 | tee $logs/rocfft.log
./rocsparse/build/release/clients/tests/rocsparse-test 2>&1 | tee $logs/rocsparse-test.log
./hipsparse/build/release/clients/tests/hipsparse-test 2>&1 | tee $logs/hipsparse-test.log
cd $dir
git clone -b master https://github.com/ROCmSoftwarePlatform/rocprim.git
cd rocprim
mkdir build
cd build
CXX=/opt/rocm/hcc/bin/hcc cmake -DBUILD_BENCHMARK=OFF -DDISABLE_WERROR=ON ../. 2>&1 | tee $logs/rocPRIM_build.log
make -j16 2>&1 | tee $logs/rocPRIM_build.log

cd $dir/rocprim/build
ctest --output-on-failure 2>&1 | tee $logs/rocPRIM_unittest.log

cd $dir
git clone -b master https://github.com/ROCmSoftwarePlatform/rocALUTION.git
cd rocALUTION
./install.sh -icd 2>&1 | tee $logs/rocALUTION-build.log

cd $dir/rocALUTION/build/release/clients/tests
./rocalution-test 2>&1 | tee $logs/rocalution-test.log


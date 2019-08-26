cd ~/Desktop/rocm/workloads/mathlibs/rocrand

echo AH64_uh1 | sudo -S rm -rf build
mkdir build; cd build

sudo mv /usr/local/lib/libgtest.a /usr/local/lib/libgtest.aa

CXX=/opt/rocm/hcc/bin/hcc cmake -DBUILD_BENCHMARK=ON -DBUILD_TEST=ON -DBUILD_CRUSH_TEST=ON -DDEPENDENCIES_FORCE_DOWNLOAD=ON ../. | tee -a ~/dockerx/7rocrand_build.log 2>&1

make -j16 | tee -a ~/dockerx/7rocrand_build.log 2>&1

#To run unit tests
ctest --output-on-failure | tee -a ~/dockerx/7rocrand_unittest.log 2>&1
#To run benchmark for generate functions
#./benchmark/benchmark_rocrand_generate --engine all --dis all | tee -a ~/dockerx/7rocrand_benchmark_rocrand-generate.log 2>&1
#To run benchmark for device kernel functions
#./benchmark/benchmark_rocrand_kernel --engine all --dis all | tee -a ~/dockerx/7rocrand_benchmark_rocrand-kernel.log 2>&1




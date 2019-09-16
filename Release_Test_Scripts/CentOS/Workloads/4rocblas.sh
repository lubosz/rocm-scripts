cd ~/Desktop/rocm/workloads/mathlibs/rocblas

echo AH64_uh1 | sudo -S apt-get -y --force-yes install cmake cmake-qt-gui cmake-curses-gui python-yaml libblas-dev liblapack-dev libboost-all-dev

echo AH64_uh1 | sudo -S rm -rf build
echo AH64_uh1 | sudo -S ./install.sh -cd | tee -a ~/dockerx/4rocblas_build.log 2>&1

cd build/release/clients/staging
./rocblas-test | tee -a ~/dockerx/4rocblas_unittest.log 2>&1
#./rocblas-bench | tee -a ~/dockerx/4rocblas_rocblas-bench.log 2>&1

#!/bin/bash
current=`pwd`
cwd=/dockerx
dir1=/root/driver
rm -rf /root/driver1/HIP
dir=/root/driver/

cd /root/driver1
#git clone https://streamhsa:AH64_uh1@github.com/ROCm-Developer-Tools/HIP 
#mv HIP src
#chmod -R 777 src
git clone https://github.com/ROCm-Developer-Tools/HIP && cd HIP
git clone https://github.com/ROCm-Developer-Tools/HIP-Examples && cd HIP-Examples && git submodule init && git submodule update



echo "======================Samples==============================" 2>&1 | tee /dockerx/hip-samples.log
echo "=====================0_Intro==============================" 2>&1 | tee -a /dockerx/hip-samples.log
echo "======================bit_extract==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd /root/driver/HIP/samples/0_Intro/bit_extract
make clean
make
./bit_extract 2>&1 2>&1 | tee /dockerx/hip-samples.log
echo "======================hcc_dialects==============================" 2>&1 2>&1 | tee -a /dockerx/hip-samples.log
cd /root/driver/HIP/samples/0_Intro/hcc_dialects
make clean
make
./vadd_amp_arrayview 2>&1 2>&1 | tee -a /dockerx/hip-samples.log
./vadd_hc_am 2>&1 2>&1 | tee -a /dockerx/hip-samples.log
./vadd_hc_array 2>&1 2>&1 | tee -a /dockerx/hip-samples.log
./vadd_hc_arrayview 2>&1 2>&1 | tee -a /dockerx/hip-samples.log
./vadd_hip 2>&1 2>&1 | tee -a /dockerx/hip-samples.log
echo "======================module_api==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd /root/driver/HIP/samples/0_Intro/module_api
make clean
make
./runKernel.hip.out 2>&1 | tee -a /dockerx/hip-samples.log
./launchKernelHcc.hip.out 2>&1 | tee -a /dockerx/hip-samples.log
echo "======================module_api_global==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd /root/driver/HIP/samples/0_Intro/module_api_global
make clean
make
./runKernel.hip.out 2>&1 | tee -a /dockerx/hip-samples.log
echo "======================square==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd /root/driver/HIP/samples/0_Intro/square
make clean
make
./square.out 2>&1 | tee -a /dockerx/hip-samples.log
echo "=====================1_Utils==============================" 2>&1 | tee -a /dockerx/hip-samples.log
echo "=====================hipBusBandwidth==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd /root/driver/HIP/samples/1_Utils/hipBusBandwidth
make clean
make
./hipBusBandwidth 2>&1 | tee -a /dockerx/hip-samples.log

echo "=====================hipCommander==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd ../hipCommander
make clean
make
./hipCommander 2>&1 | tee -a /dockerx/hip-samples.log
echo "=====================hipDispatchLatency==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd ../hipDispatchLatency
make clean
make
./hipDispatchLatency 2>&1 | tee -a /dockerx/hip-samples.log
echo "=====================/hipInfo==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd ../hipInfo
make clean
make
./hipInfo 2>&1 | tee -a /dockerx/hip-samples.log

echo "=====================2_Cookbook==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd /root/driver/HIP/samples/2_Cookbook
echo "=====================0==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd 0_MatrixTranspose
make clean
make
./MatrixTranspose 2>&1 | tee -a /dockerx/hip-samples.log
echo "=====================1==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd ../1_hipEvent
make clean
make
./hipEvent 2>&1 | tee -a /dockerx/hip-samples.log
echo "=====================2==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd ../2_Profiler
make clean
make
./MatrixTranspose 2>&1 | tee -a /dockerx/hip-samples.log
echo "=====================3==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd ../3_shared_memory
make clean
make
./sharedMemory 2>&1 | tee -a /dockerx/hip-samples.log
echo "=====================4=============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd ../4_shfl
make clean
make
./shfl 2>&1 | tee -a /dockerx/hip-samples.log
echo "=====================5==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd ../5_2dshfl
make clean
make
./2dshfl 2>&1 | tee -a /dockerx/hip-samples.log
echo "=====================6==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd ../6_dynamic_shared
make clean
make
./dynamic_shared 2>&1 | tee -a /dockerx/hip-samples.log
echo "=====================7=============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd ../7_streams
make clean
make
./stream 2>&1 | tee -a /dockerx/hip-samples.log
echo "=====================8==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd ../8_peer2peer
make clean
make
./peer2peer 2>&1 | tee -a /dockerx/hip-samples.log
echo "=====================9==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd ../9_unroll
make clean
make
./unroll 2>&1 | tee -a /dockerx/hip-samples.log
echo "=====================10==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd ../10_inline_asm
make clean
make
./inline_asm 2>&1 | tee -a /dockerx/hip-samples.log
echo "====================11==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd ../11_texture_driver
make clean
make
./texture2dDrv.out 2>&1 | tee -a /dockerx/hip-samples.log
echo "=====================12==============================" 2>&1 | tee -a /dockerx/hip-samples.log
cd ../12_cmake_hip_add_executable
mkdir -p build && cd build
rm -rf *
cmake ..
make
./MatrixTranspose 2>&1 | tee -a /dockerx/hip-samples.log


echo "======================Examples=============================="  2>&1 | tee /dockerx/hip-examples.log
echo "======================add4==============================" 2>&1 | tee -a /dockerx/hip-examples.log
cd /root/driver/HIP/HIP-Examples/add4
./buildit.sh
./runhip.sh 2>&1 | tee /dockerx/hip-examples.log
echo "======================cuda-stream==============================" 2>&1 | tee -a /dockerx/hip-examples.log
cd /root/driver/HIP/HIP-Examples/cuda-stream
make clean
make
./stream 2>&1 | tee -a /dockerx/hip-examples.log
echo "======================gpu-burn==============================" 2>&1 | tee -a /dockerx/hip-examples.log
cd /root/driver/HIP/HIP-Examples/gpu-burn
make clean
make
cd build
./gpuburn-hip 2>&1 | tee -a /dockerx/hip-examples.log
echo "======================babelstream==============================" 2>&1 | tee -a /dockerx/hip-examples.log
cd /root/driver/HIP/HIP-Examples/
rm -rf babelstream
git clone https://github.com/UoB-HPC/babelstream
cd /root/driver/HIP/HIP-Examples/babelstream
make clean
make -f HIP.make
./hip-stream --float 2>&1 | tee -a /dockerx/hip-examples.log
./hip-stream  2>&1 | tee -a /dockerx/hip-examples.log
echo "======================mini-nbody==============================" 2>&1 | tee -a /dockerx/hip-examples.log
cd /root/driver/HIP/HIP-Examples/mini-nbody/hip
make clean
./HIP-nbody-block.sh 2>&1 | tee -a /dockerx/hip-examples.log
./HIP-nbody-orig.sh 2>&1 | tee -a /dockerx/hip-examples.log
./HIP-nbody-soa.sh 2>&1 | tee -a /dockerx/hip-examples.log
echo "======================mixbench==============================" 2>&1 | tee -a /dockerx/hip-examples.log
cd /root/driver/HIP/HIP-Examples/
rm -rf mixbench
git clone https://github.com/ekondis/mixbench.git
cd /root/driver/HIP/HIP-Examples/mixbench
make clean
export HIP_PATH=/opt/rocm/hip
sed -i 's/\/usr\/local\/cuda/\/opt\/rocm\/opencl/g' Makefile
make
./mixbench-hip-alt 2>&1 | tee -a /dockerx/hip-examples.log
./mixbench-hip-ro 2>&1 | tee -a /dockerx/hip-examples.log
unset HIP_PATH
echo "======================reduction==============================" 2>&1 | tee -a /dockerx/hip-examples.log
cd /root/driver/HIP/HIP-Examples/reduction
make clean
make
./run.sh 2>&1 | tee -a /dockerx/hip-examples.log
echo "======================rtm8==============================" 2>&1 | tee -a /dockerx/hip-examples.log
cd /root/driver/HIP/HIP-Examples/rtm8
make clean
./build_hip.sh
./rtm8_hip 2>&1 | tee -a /dockerx/hip-examples.log
echo "======================strided-access=============================" 2>&1 | tee -a /dockerx/hip-examples.log
cd /root/driver/HIP/HIP-Examples/strided-access/
make clean
make
./strided-access 2>&1 | tee -a /dockerx/hip-examples.log
echo "======================vectorAdd==============================" 2>&1 | tee -a /dockerx/hip-examples.log
cd /root/driver/HIP/HIP-Examples/vectorAdd
make clean
make 2>&1 | tee -a /dockerx/hip-examples.log
echo "======================Applications==============================" 2>&1 | tee -a /dockerx/hip-examples-Applications.log
cd /root/driver/HIP/HIP-Examples/HIP-Examples-Applications
cd BinomialOption
make clean
make
./BinomialOption -e 2>&1 | tee /dockerx/hip-examples-Applications.log
cd ../BitonicSort/
make clean
make
./BitonicSort -e 2>&1 | tee -a /dockerx/hip-examples-Applications.log
cd ../dct/
make clean
make
./dct -e 2>&1 | tee -a /dockerx/hip-examples-Applications.log
cd ../dwtHaar1D
make clean
make
./dwtHaar1D -e 2>&1 | tee -a /dockerx/hip-examples-Applications.log
cd ../FastWalshTransform
make clean
make
./FastWalshTransform -e 2>&1 | tee -a /dockerx/hip-examples-Applications.log
cd ../FloydWarshall
make clean
make
./FloydWarshall -e 2>&1 | tee -a /dockerx/hip-examples-Applications.log
cd ../HelloWorld
make clean
make
./HelloWorld -e 2>&1 | tee -a /dockerx/hip-examples-Applications.log
cd ../Histogram
make clean
make
./Histogram -e 2>&1 | tee -a /dockerx/hip-examples-Applications.log
cd ../MatrixMultiplication
make clean
make
./MatrixMultiplication -e 2>&1 | tee -a /dockerx/hip-examples-Applications.log
cd ../SimpleConvolution
make clean
make
./SimpleConvolution -e 2>&1 | tee -a /dockerx/hip-examples-Applications.log
cd ../PrefixSum
make clean
make
./PrefixSum -e 2>&1 | tee -a /dockerx/hip-examples-Applications.log
cd ../RecursiveGaussian
make clean
make
./RecursiveGaussian -e 2>&1 | tee -a /dockerx/hip-examples-Applications.log

"
git clone -b develop https://streamhsa:AH64_uh1@github.com/ROCmSoftwarePlatform/hipeigen
cd hipeigen
mkdir build
cd build
cmake ..  2>&1 | tee -a /dockerx/hip-eigen-build.log
make -j8  2>&1 | tee -a /dockerx/hip-eigen-build.log

cd /root/driver/hipeigen/build
make -j8 check -e 2>&1 | tee -a /dockerx/hip-eigen-run.log
"

cd /root/driver/HIP/
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=../install  2>&1 | tee -a /dockerx/hip_directedtests_build.log
make -j8  2>&1 | tee -a /dockerx/hip_directedtests_build.log
make install  2>&1 | tee -a /dockerx/hip_directedtests_build.log
make check -j8 -e 2>&1 | tee -a /dockerx/hip_directedtests.log

echo "======================computeapps=============================="
echo "======================comd-amp=============================="
cd /root/driver1
git clone https://github.com/amdcomputelibraries/computeapps
cd computeapps
cd comd-amp/src-amp
make
cd ../bin
./CoMD-amp --nx 60 --ny 60 --nz 60 -e 2>&1 | tee -a /dockerx/compute-apps.log
echo "======================hpgmg-amp=============================="
cd ../../hpgmg-amp
make -f Makefile.hcc
cd build/bin
./hpgmg-fv-LC-clamp 6 8 -e 2>&1 | tee -a /dockerx/compute-apps.log

echo "======================lulesh-amp=============================="
cd ../../../lulesh-amp
make
./lulesh -s 80 -i 100 -e 2>&1 | tee -a /dockerx/compute-apps.log

echo "======================snap-hcc=============================="
cd ../snap-hcc/src

lsb_release -a >os_name.log

if grep -q 18.04 os_name.log; then
   sed -i 's/-I\/usr\/lib\/openmpi\/include/-I\/usr\/lib\/x86_64-linux-gnu\/openmpi\/include/g' Makefile
fi
make
./snap snap_input -e 2>&1 | tee -a /dockerx/compute-apps.log

echo "======================xsbench-amp=============================="

cd ../../xsbench-amp/src
make
./XSBench -s small -e 2>&1 | tee -a /dockerx/compute-apps.log

echo "======================xsbench-amp=============================="
cd /root/driver1
git clone https://github.com/gromacs/gromacs
cd gromacs
mkdir build
cd build
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON
make -j 8 2>&1 | tee -a /dockerx/gromacs_build.log

cd /root/driver1/gromacs/
cd build
make -j 8 check 2>&1 | tee -a /dockerx/gromacs_test.log


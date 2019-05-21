##Created by     : Pramendra Kumar
## Creation Date : 15/05/2017
## Description   : Script is for building MIOpen library
## Prerequisites : OpenCL needs to be installed under /opt/rocm
## Modifications : <Ravi> MIOpengemm step is added as part of installation(instead of tinygemm).

#!/bin/sh

current=`pwd`

echo AH64_uh1 | sudo apt-get -y install unzip
echo AH64_uh1 | sudo wget https://phoenixnap.dl.sourceforge.net/project/half/half/1.12.0/half-1.12.0.zip
echo AH64_uh1 | sudo unzip *.zip
echo AH64_uh1 | sudo cp -rf $current/include/half.hpp /opt/rocm/include

mkdir -p $HOME/Desktop/rocm_tests/ && mkdir -p $HOME/Desktop/rocm_tests/dnns
cd $HOME/Desktop/rocm_tests/dnns
echo AH64_uh1 | sudo  rm -rf MLOpen rocm-cmake miopengemm
echo AH64_uh1 | sudo dpkg -r miopen-hip rocm-cmake miopengemm

echo AH64_uh1 | sudo apt-get -y install libelf-dev
echo AH64_uh1 | sudo  rm -rf ~/.cache/*
echo AH64_uh1 | sudo  rm -rf ~/.config/miopen/*
echo AH64_uh1 | sudo  apt-get -y install libssl-dev libboost-all-dev cmake git
echo AH64_uh1 | sudo  ln -s /usr/include/x86_64-linux-gnu/openssl/opensslconf.h /usr/include/openssl

git clone -b develop https://streamhsa:AH64_uh1@github.com/AMDComputeLibraries/MLOpen.git
git clone https://github.com/RadeonOpenCompute/rocm-cmake.git
git clone https://github.com/ROCmSoftwarePlatform/miopengemm
#git clone https://streamhsa:AH64_uh1@github.com/RadeonOpenCompute/clang-ocl.git

cd $HOME/Desktop/rocm_tests/dnns/rocm-cmake
rm -rf build
mkdir build
cd build
cmake .. | tee mlopenocl_build.log
make -j8 package | tee -a mlopenocl_build.log
echo AH64_uh1 | sudo dpkg -i *.deb

cd $HOME/Desktop/rocm_tests/dnns/miopengemm
rm -rf build
mkdir build
cd build
#cmake -DOPENCL_INCLUDE_DIRS=/opt/rocm/opencl/include/ -DOPENCL_LIBRARIES=/opt/rocm/opencl/lib/x86_64/libamdocl64.so -DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0 .. | tee -a hipmlopen_build.log
cmake -DOPENCL_INCLUDE_DIRS=/opt/rocm/opencl/include/ -DOPENCL_LIBRARIES=/opt/rocm/opencl/lib/x86_64/libamdocl64.so .. | tee -a mlopenocl_build.log
make -j8 package | tee -a mlopenocl_build.log
echo AH64_uh1 | sudo dpkg -i *.deb

#cd $HOME/Desktop/rocm_tests/dnns/hip-mlopen/clang-ocl
#rm -rf build
#mkdir build
#cd build
#cmake .. | tee -a hipmlopen_build.log
#echo AH64_uh1 | sudo make install | tee -a hipmlopen_build.log


cd $HOME/Desktop/rocm_tests/dnns/MLOpen 

/opt/rocm/bin/rocm_agent_enumerator -t GPU >gpu_info.log
if grep -q gfx906 gpu_info.log;then
  sed -i 's/gfx900/gfx906/g' CMakeLists.txt
fi

rm -rf build
mkdir build
cd $HOME/Desktop/rocm_tests/dnns/MLOpen/build 
#CXX=/opt/rocm/hcc/bin/hcc cmake -DMIOPEN_TEST_ALL=ON -DMIOPEN_BACKEND=HIP -DMIOPEN_MAKE_BOOST_PUBLIC=ON -DCMAKE_PREFIX_PATH="/opt/rocm/hcc;/opt/rocm/hip" -DCMAKE_CXX_FLAGS="-isystem /usr/include/x86_64-linux-gnu/" -DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0 .. | tee -a hipmlopen_build.log
#CXX=/opt/rocm/hcc/bin/hcc cmake -DMIOPEN_TEST_ALL=ON -DMIOPEN_BACKEND=HIP -DMIOPEN_MAKE_BOOST_PUBLIC=ON -DMIOPEN_TEST_FLAGS="--disable-verification-cache" -DBoost_USE_STATIC_LIBS=Off -DCMAKE_PREFIX_PATH="/opt/rocm/hcc;/opt/rocm/hip" -DCMAKE_CXX_FLAGS="-isystem /usr/include/x86_64-linux-gnu/" .. | tee -a hipmlopen_build.log

#To build MIOpen with OpenCL backend 
 cmake -DMIOPEN_TEST_ALL=ON -DMIOPEN_BACKEND=OpenCL -DMIOPEN_MAKE_BOOST_PUBLIC=ON -DBoost_USE_STATIC_LIBS=Off -DMIOPEN_TEST_FLAGS="--disable-verification-cache" -DOPENCL_INCLUDE_DIRS=/opt/rocm/opencl/include/ -DOPENCL_LIBRARIES=/opt/rocm/opencl/lib/x86_64/libamdocl64.so .. | tee -a mlopenocl_build.log

make -j8 | tee -a mlopenocl_build.log
make package | tee -a mlopenocl_build.log
echo AH64_uh1 | sudo dpkg -i *.deb


echo "[STEPS]" > Results.ini
echo "Number=1" >> Results.ini
echo " " >> Results.ini
echo "[STEP_001]" >> Results.ini
echo "Description= hipmlopen build " >> Results.ini

if [ -e "/opt/rocm/miopen/lib/libMIOpen.so.1" ]; then 
  echo "Status=Passed" >> Results.ini
else
  echo "Status=Failed" >> Results.ini
fi

mv -f Results.ini $current
mv -f mlopenocl_build.log $current


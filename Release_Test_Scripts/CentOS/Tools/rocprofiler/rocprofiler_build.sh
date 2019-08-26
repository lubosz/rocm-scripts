## Created by    : Radhika Burra
## Creation Date : 03/12/2018
## Description   : Script is for build rocprofiler
## Modifications : <Paresh> Script modified for building in $HOME/Desktop path

#!/bin/sh
current=`pwd`

cd $HOME/Desktop/
echo "AH64_uh1" | sudo rm -rf rocprofiler
git clone https://github.com/ROCmSoftwarePlatform/rocprofiler.git

export CMAKE_PREFIX_PATH=/opt/rocm/hsa/include/hsa:/opt/rocm/hsa/lib
export CMAKE_BUILD_TYPE=release
export CMAKE_DEBUG_TRACE=1

cd rocprofiler
mkdir build
cd build

cmake -DCMAKE_PREFIX_PATH=/opt/rocm/lib:/opt/rocm/include/hsa -DCMAKE_INSTALL_PREFIX=/opt/rocm ..
make
sudo make install

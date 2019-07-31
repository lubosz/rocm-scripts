#!/bin/bash

set -ex

install_ubuntu() {
    apt-get update
    apt-get install -y wget
    apt-get install -y libopenblas-dev

    # Need the libc++1 and libc++abi1 libraries to allow torch._C to load at runtime
    apt-get install libc++1
    apt-get install libc++abi1

# Install required python2 packages
apt-get -y update --fix-missing --allow-insecure-repositories && DEBIAN_FRONTEND=noninteractive apt-get install -y git dkms cmake flex bison aria2 check xsltproc cifs-utils vim ssh dos2unix  python-pip-whl libpci3 libelf1 g++-multilib gcc-multilib libunwind-dev libnuma-dev bzip2 sudo file

 apt-get clean
 rm -rf /var/lib/apt/lists/*


mkdir /home/roc-master && cd /home/roc-master
current=`pwd`
wget http://10.236.104.70/job/compute-roc-master/9501/artifact/artifacts/compute-roc-master-9501.tar.bz2
#RUN wget http://172.27.226.104/artifactory/rocm-generic-local/amd/compute-roc-master/compute-roc-master-$rocm_master.tar.bz2
tar -jxvf compute*
sed -i 's/compute-artifactory.amd.com/172.27.226.104/g' deb.meta4
aria2c deb.meta4

cd ./deb 

cp -rf hip/*.deb ocl_lc/*.deb  meta/rocm-utils*.deb  rocr_debug_agent/*.deb devicelibs/*.deb hcc/*.deb clang-ocl/*.deb hsa-amd-aqlprofile/*.deb rocm-cmake/*.deb rocminfo/*.deb rocm-smi/*.deb rocprofiler/*.deb rocr/*.deb rocr_ext/*.deb roct/*.deb $current

cd $current
wget http://13.82.220.49/rocm/apt/debian/pool/main/r/rocm-profiler/rocm-profiler_5.4.6878_amd64.deb
wget http://13.82.220.49/rocm/apt/debian/pool/main/c/cxlactivitylogger/cxlactivitylogger_5.4.6878_amd64.deb
dpkg -i hsakmt-roct*.deb hsakmt-roct-dev*.deb
dpkg -i hsa-ext-rocr-dev*.deb hsa-rocr-dev*.deb
dpkg -i rocr_debug_agent*.deb


dpkg -i rocm-opencl*.deb rocm-opencl-dev*.deb rocm-smi*.deb rocm-utils*.deb rocminfo*.deb rocm-clang-ocl*.deb hip*.deb hcc*.deb  hsa-amd-aqlprofile*.deb rocprofiler-dev*.deb rocm-cmake*.deb rocm-device-libs*.deb rocm-profiler*.deb cxlactivitylogger*.deb

###########################Uncomment If you want to build HIP from Github################
#RUN git clone https://github.com/ROCm-Developer-Tools/HIP
#WORKDIR /root/driver/HIP
#RUN git reset --hard f033d8207281656c56789c9c8c37a0f42f28e890
#RUN echo y | ./install.sh
#########################################################

rm -rf ~/.cache/*

sh -c 'echo HIP_PLATFORM=hcc >> /etc/environment'
#sh -c 'echo HCC_AMDGPU_TARGET=gfx900 >> /etc/environment'

 echo "gfx900" > /opt/rocm/bin/target.lst
 echo "gfx906" >> /opt/rocm/bin/target.lst
# echo "gfx803" >> /opt/rocm/bin/target.lst

mkdir -p /opt/rocm/debians
curl http://repo.radeon.com/rocm/misc/facebook/apt/.apt_1.9.white_rabbit/debian/pool/main/h/hip-thrust/hip-thrust_1.8.2_all.deb -o /opt/rocm/debians/hip-thrust.deb
dpkg -i /opt/rocm/debians/hip-thrust.deb

export PATH=/opt/rocm/opencl/bin/x86_64:$PATH

export LD_LIBRARY_PATH=/usr/local/caffe2/lib
export PYTHONPATH=/usr/local/caffe2/lib/python2.7/dist-packages


cd $current
git clone -b master https://github.com/ROCmSoftwarePlatform/rocblas
#dos2unix ./roc-master/rocblas/install.sh
cd $current/rocblas
./install.sh -icd 2>&1 | tee rocblas-build.log

cd $current
git clone -b master https://github.com/ROCmSoftwarePlatform/hipblas
#dos2unix ./roc-master/hipblas/install.sh
cd $current/hipblas
./install.sh -icd 2>&1 | tee hipblas-build.log

cd $current
git clone -b master https://github.com/ROCmSoftwarePlatform/rocrand.git
mkdir $current/rocrand/build
cd $current/rocrand/build
CXX=/opt/rocm/hcc/bin/hcc  cmake -DBUILD_TEST=ON -DBUILD_BENCHMARK=ON -DBUILD_CRUSH_TEST=ON -DDEPENDENCIES_FORCE_DOWNLOAD=ON ../.
make -j16 2>&1 | tee rocrand-build.log
make package
dpkg -i rocrand*.deb

cd $current
 apt-get -y install libboost-program-options-dev libfftw3-dev cmake-qt-gui
 git clone -b master https://github.com/ROCmSoftwarePlatform/rocfft
# dos2unix ./roc-master/rocfft/install.sh
cd $current/rocfft
./install.sh -icd 2>&1 | tee rocfft-build.log

cd $current
git clone -b master https://github.com/ROCmSoftwarePlatform/rocsparse.git
cd $current/rocsparse
# dos2unix ./roc-master/rocsparse/install.sh
$current/rocsparse/install.sh -icd 2>&1 | tee rocsparse-build.log

cd $current
git clone -b master https://github.com/ROCmSoftwarePlatform/hipsparse.git
cd $current/hipsparse
# dos2unix ./roc-master/hipsparse/install.sh
$current/hipsparse/install.sh -icd 2>&1 | tee hipsparse-build.log

cd $current
wget https://phoenixnap.dl.sourceforge.net/project/half/half/1.12.0/half-1.12.0.zip
echo y | apt-get install zip
unzip *.zip
cp -rf $current/include/half.hpp /opt/rocm/include

apt-get -y install libelf-dev
apt-get -y install libssl-dev libboost-all-dev
 ln -s /usr/include/x86_64-linux-gnu/openssl/opensslconf.h /usr/include/openssl

 git clone https://github.com/RadeonOpenCompute/rocm-cmake.git
mkdir $current/rocm-cmake/build
cd $current/rocm-cmake/build
cmake ..
make package
dpkg -i *.deb

cd $current
 git clone https://github.com/ROCmSoftwarePlatform/miopengemm
mkdir $current/miopengemm/build
cd $current/miopengemm/build
cmake -DOPENCL_INCLUDE_DIRS=/opt/rocm/opencl/include/ -DOPENCL_LIBRARIES=/opt/rocm/opencl/lib/x86_64/libamdocl64.so ..
make -j16
 make package
 dpkg -i *.deb

cd $current
git clone -b develop https://streamhsa:AH64_uh1@github.com/AMDComputeLibraries/MLOpen.git
mkdir $current/MLOpen/build
cd $current/MLOpen/build
CXX=/opt/rocm/hcc/bin/hcc cmake -DMIOPEN_TEST_ALL=ON -DMIOPEN_BACKEND=HIP -DMIOPEN_MAKE_BOOST_PUBLIC=ON -DCMAKE_PREFIX_PATH="/opt/rocm/hcc;/opt/rocm/hip" -DCMAKE_CXX_FLAGS="-isystem /usr/include/x86_64-linux-gnu/" ..
make -j16 2>&1 | tee hipmlopen-build.log
make package 2>&1 | tee -a hipmlopen-build.log
dpkg -i *.deb 2>&1 | tee -a hipmlopen-build.log

}

install_centos() {

  yum update -y
  yum install -y wget
  yum install -y openblas-devel

  yum install -y epel-release
  yum install -y dkms kernel-headers-`uname -r` kernel-devel-`uname -r`

  echo "[ROCm]" > /etc/yum.repos.d/rocm.repo
  echo "name=ROCm" >> /etc/yum.repos.d/rocm.repo
  echo "baseurl=http://repo.radeon.com/rocm/misc/facebook/yum/.yum_1.9.white_rabbit/" >> /etc/yum.repos.d/rocm.repo
  echo "enabled=1" >> /etc/yum.repos.d/rocm.repo
  echo "gpgcheck=0" >> /etc/yum.repos.d/rocm.repo

  yum update -y

  yum install -y \
                   rocm-dev \
                   rocm-libs \
                   rocm-utils \
                   rocfft \
                   miopen-hip \
                   miopengemm \
                   rocblas \
                   rocm-profiler \
                   cxlactivitylogger \
                   rocsparse \
                   hipsparse \
                   rocrand


  pushd /tmp
  wget https://github.com/scchan/hcc/releases/download/19-host_linker_relative_path_rocdl/rocm19wb_20181109.tgz
  tar -xzf rocm19wb_20181109.tgz
  pushd rocm19wb_20181109/rpm
  rpm -i --replacefiles hcc-1.2.18445-Linux.rpm hip_base-1.5.18435.rpm hip_hcc-1.5.18435.rpm hip_doc-1.5.18435.rpm hip_samples-1.5.18435.rpm
  popd
  rm -rf rocm19wb_20181109.tgz rocm19wb_20181109
  popd

  # Cleanup
  yum clean all
  rm -rf /var/cache/yum
  rm -rf /var/lib/yum/yumdb
  rm -rf /var/lib/yum/history

  # Needed for now, will be replaced once hip-thrust is packaged for CentOS
  git clone --recursive https://github.com/ROCmSoftwarePlatform/Thrust.git /data/Thrust
  rm -rf /data/Thrust/thrust/system/cuda/detail/cub-hip
  git clone --recursive https://github.com/ROCmSoftwarePlatform/cub-hip.git /data/Thrust/thrust/system/cuda/detail/cub-hip
  ln -s /data/Thrust/thrust /opt/rocm/include/thrust
}
 
# Install Python packages depending on the base OS
if [ -f /etc/lsb-release ]; then
  install_ubuntu
elif [ -f /etc/os-release ]; then
  install_centos
else
  echo "Unable to determine OS..."
  exit 1
fi

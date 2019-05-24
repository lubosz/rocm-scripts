#!/bin/bash
username="$(id -u -n)"
echo "User name : $username"

##Adrian suggested
echo "AH64_uh1" | sudo  yum install -y epel-release rpm-build dkms rsync check check-devel cmake git

#############amdgpu test #########
echo "AH64_uh1" | sudo  yum install -y  CUnit

#############Luxmark , WF->MemHostFlags and Buffers #########
echo "AH64_uh1" | sudo  yum install -y  freeglut-devel elfutils-libelf-devel libSM libXrender fontconfig

#############Required to run GUI Apps inside docker #########
echo "AH64_uh1" | sudo  yum install -y xorg-x11-server-Xvfb 

#############Gromacs  Needs#########
echo "AH64_uh1" | sudo  yum install -y hwloc-devel fftw fftw3-devel 

##for debian package install
echo "AH64_uh1" | sudo  yum install -y dpkg dos2unix
#############computeapps - snapc and xsbench#########
echo "AH64_uh1" | sudo  yum install -y libdwarf-devel elf* omp* openmpi-bin openmpi-devel
echo "AH64_uh1" | sudo yum install -y libc++abi-dev
#############for rocr conformance#########
echo "AH64_uh1" | sudo yum install -y subunit
#############mandatory#########
echo "AH64_uh1" | sudo usermod -a -G video taccuser

#############hipcaffe#########
echo "AH64_uh1" | sudo yum install -y gflags-devel lmdb* glog-devel opencv-devel protobuf-compiler protobuf-devel hdf5-devel compat-db leveldb-devel snappy-devel atlas* blas* PyYAML
#############hipeigen#########
echo "AH64_uh1" | sudo yum install -y libXmu-devel libXmu
#############Baikal needs#########
echo AH64_uh1 | sudo yum install -y OpenImageIO glfw libGLEW



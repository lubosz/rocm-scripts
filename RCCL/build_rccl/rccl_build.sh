## Created by    : Sushant Kumar
## Creation Date : 13/05/2019
## Description   : Script is for building rccl

#!/bin/sh
current=`pwd`

LIBPATH="/opt/rocm/rccl/"
TEST=$HOME/Desktop/rocm_tests/

cd $HOME/Desktop/rocm_tests/
echo "AH64_uh1" | sudo rm -rf RCCL

git clone -b rccl https://streamhsa:AH64_uh1@github.com/ROCmSoftwarePlatform/rccl-internal.git RCCL
cd RCCL
mkdir build
cd build
CXX=/opt/rocm/bin/hcc cmake .. 2>&1 > RCCL-build.log 
make -j$(nproc) package 2>&1 >> RCCL-build.log
echo "AH64_uh1" | sudo dpkg -i rccl*.deb

mv RCCL-build.log $HOME/Desktop/rocm_tests/rccl-tests
cd $HOME/Desktop/rocm_tests/
echo "AH64_uh1" | sudo rm -rf rccl-tests

git clone -b master https://streamhsa:AH64_uh1@github.com/ROCmSoftwarePlatform/rccl-tests-internal.git rccl-tests
cd rccl-tests
echo " " 
echo " building rccl-test"
echo " ******************"
make -j$(nproc) MPI=1 2>&1 >> RCCL-build.log

if [ -e "$LIBPATH/lib/"librccl.so ]; then 
  echo "[STEPS]" > Results.ini
  echo "Number=2" >> Results.ini
  echo " " >> Results.ini
  echo "[STEP_001]" >> Results.ini
  echo "Description= rccl is built properly." >> Results.ini
  echo "Status=Passed" >> Results.ini
else
  echo "[STEPS]" > Results.ini
  echo "Number=1" >> Results.ini
  echo " " >> Results.ini
  echo "[STEP_001]" >> Results.ini
  echo "Description= rccl compilation failed.Refer RCCL-build.log" >> Results.ini
  echo "Status=Failed" >> Results.ini
fi

if [ -e "$TEST/rccl-tests/build/" ]; then
#  echo "[STEPS]" > Results.ini
#  echo "Number=1" >> Results.ini
#  echo " " >> Results.ini
  echo "[STEP_002]" >> Results.ini
  echo "Description= rccl-tests are built properly." >> Results.ini
  echo "Status=Passed" >> Results.ini
else
#  echo "[STEPS]" > Results.ini
#  echo "Number=1" >> Results.ini
#  echo " " >> Results.ini
  echo "[STEP_002]" >> Results.ini
  echo "Description= rccl-tests compilation failed.Refer RCCL-build.log" >> Results.ini
  echo "Status=Failed" >> Results.ini
fi

mv -f Results.ini $current
mv -f RCCL-build.log $current



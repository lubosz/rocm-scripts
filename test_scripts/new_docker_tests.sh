sudo apt-get install python-prettytable

cd /dockerx/

git pull https://streamhsa:AH64_uh1@github.com/RadeonOpenCompute/MLSEQA_TestRepo
cd MLSEQA_TestRepo/Libs/hipCUB
python hipCUB.py 2>&1 | tee -a /dockerx/hipCUB.log


cd /dockerx/MLSEQA_TestRepo/Libs/rocThrust
python rocThrust.py 2>&1 | tee -a /dockerx/rocThrust.log

"
./run_ocltst.sh

cd /root/driver/
git clone https://github.com/ROCmSoftwarePlatform/rccl.git && cd rccl

rm -rf build
mkdir build && cd build

sudo dpkg -r rccl

CXX=/opt/rocm/bin/hcc cmake .. 2>&1 | tee RCCL-build.log
make -j$(nproc) package 2>&1 | tee -a RCCL-build.log
sudo dpkg -i rccl*.deb

cd /root/driver/

git clone -b master https://github.com/ROCmSoftwarePlatform/rccl-tests.git && cd rccl-tests


git clone https://streamhsa:AH64_uh1@github.com/RadeonOpenCompute/MLSEQA_TestRepo

wget https://raw.githubusercontent.com/raspberrypi/linux/rpi-4.9.y/arch/arm/configs/bcmrpi_defconfig

"
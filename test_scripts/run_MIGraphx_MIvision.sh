#!/bin/sh

echo ############## MIGraphX #################

git clone https://streamhsa:AH64_uh1@github.com/RadeonOpenCompute/MLSEQA_TestRepo
dir=/root/driver/
cd $dir/
sudo dpkg -i MIGraphX*.deb
cd $dir/MIGraphX/MLSEQA_TestRepo/Feature/MIGraphX
sudo python migraphx_unittests.py
cp -rf unittestSummary.log /dockerx/MIGraphX_unittest.log

echo ############# MIVision ##################

cd MLSEQA_TestRepo/Feature/MIVisionx/
echo ############ Install MIOpen-OpenCL before running #############
sudo dpkg -r miopen-hip
cd /root/driver/MLOpen/build_Ocl
make package
sudo dpkg -i MIOpen-OpenCL*.deb
sudo ./build_mivisionx.sh 2>&1 | tee -a /dockerx/MIVisionx_build.log
sudo ./mivisionx-fp32-run-all-tests.sh 2>&1 | tee -a /dockerx/MIVisionx_fp32_run.log
sudo ./mivisionx-fp16-run-all-tests.sh 2>&1 | tee -a /dockerx/MIVisionx_fp16_run.log
sudo ./ run-video-inference.sh 2>&1 | tee -a /dockerx/MIVisionx_video_inference.log
sudo dpkg -r miopen-opencl
cd /root/driver/MLOpen/build_hip
make package
sudo dpkg -i MIOpen*.deb


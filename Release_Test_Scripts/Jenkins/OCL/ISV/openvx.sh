cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/openvx_opencl_test
rm -rf OpenVX.log
./OpenVX_Perf_Suite.sh
cp OpenVX.log ~/Desktop/logs/.

cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/Fuzzer/amdmiscompile-master
./fuzzer >> ~/Desktop/logs/Fuzzer.log 2>&1

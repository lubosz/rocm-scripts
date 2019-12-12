cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/dgemm_linux

echo AH64_uh1 | sudo -S rm -rf /tmp/*
export LD_LIBRARY_PATH=${HOME}/OpenBlas/lib:$LD_LIBRARY_PATH;
./xgemmStandaloneTest >> ~/Desktop/logs/sgemm_linux.log 2>&1

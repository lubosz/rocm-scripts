cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

echo AH64_uh1 | sudo -S rm -rf /tmp/*
cd ~/Desktop/Tests/OCL/ISV/MTY_CL/Src
echo AH64_uh1 | sudo -S rm -rf /tmp/*
export GPU_MAX_ALLOC_PERCENT=100

./mty_cl_amd

#./mty_cl_amd & > ~/Desktop/logs/MTY_CL.log 2>&1
#sleep 60 >> ~/Desktop/logs/MTY_CL.log 2>&1
#kill -9 $(pgrep mty_cl_amd) >> ~/Desktop/logs/MTY_CL.log 2>&1

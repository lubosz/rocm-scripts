cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/CellularAutomation2D_GOL/OpenCL
./GOL_cl >> ~/Desktop/logs/GOL.log 2>&1
./GOL_local_cl >> ~/Desktop/logs/GOL.log 2>&1

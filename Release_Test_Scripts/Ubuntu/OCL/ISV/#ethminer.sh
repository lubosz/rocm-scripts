cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/ethminer-master/build/ethminer
./ethminer -G --benchmark >> ~/Desktop/logs/ethminer.log 2>&1


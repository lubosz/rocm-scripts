cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/ocltst/lnx64_release
./perf.sh > ~/Desktop/logs/oclperf.log 2>&1

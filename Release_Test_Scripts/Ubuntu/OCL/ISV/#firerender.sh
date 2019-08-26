cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/FireRender-fr1.266_updated
cd UnitTest

export GPU_MAX_ALLOC_PERCENT=100
./runFuncTests.sh >> ~/Desktop/logs/FireRender.log 2>&1

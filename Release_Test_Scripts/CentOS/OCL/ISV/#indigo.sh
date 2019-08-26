cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/IndigoRender/IndigoRenderer_x64_v3.8.37
./indigo >> ~/Desktop/logs/IndigoRenderer.log 2>&1

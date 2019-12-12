cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/QCDGPU/QCDGPU-master/O\(N\)
rm *.bin
./QCDGPU > ~/Desktop/logs/QCDGPU.log 2>&1

cd ~/Desktop/Tests/OCL/ISV/QCDGPU/QCDGPU-master/SU\(N\)
rm *.bin
./QCDGPU.amd >> ~/Desktop/logs/QCDGPU_amd.log 2>&1

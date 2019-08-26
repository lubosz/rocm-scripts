cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/QuickProbes/Source/bin

echo AH64_uh1 | sudo -S rm -rf /tmp/*
echo AH64_uh1 | sudo -S rm -rf *.bin
export GPU_MAX_ALLOC_PERCENT=100
./quickprobs -p 0 -d 0 -c 5 ../../InputFiles_RealLifeData/PF07520_full.txt & >> ~/Desktop/logs/quickprobs.log 2>&1
sleep 60
kill -9 $(pgrep quickprobs)

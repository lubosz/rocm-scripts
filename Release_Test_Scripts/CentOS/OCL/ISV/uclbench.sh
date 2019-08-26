cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/uCLbench/build/bin

echo "buffer_bandwidth-----------------" >> ~/Desktop/logs/uCLbench.log 2>&1
./buffer_bandwidth --device=0 >> ~/Desktop/logs/uCLbench.log 2>&1
echo "\n\n\n" >> ~/Desktop/logs/uCLbench.log 2>&1

echo "./kernel_overheads -----------------" >> ~/Desktop/logs/uCLbench.log 2>&1
./kernel_overheads --device 0 >> ~/Desktop/logs/uCLbench.log 2>&1
echo "\n\n\n" >> ~/Desktop/logs/uCLbench.log 2>&1

echo "mem_latency-----------------" >> ~/Desktop/logs/uCLbench.log 2>&1
./mem_latency --device=0 >> ~/Desktop/logs/uCLbench.log 2>&1
echo "\n\n\n" >> ~/Desktop/logs/uCLbench.log 2>&1

echo "mem_streaming-----------------" >> ~/Desktop/logs/uCLbench.log 2>&1
./mem_streaming --device=0 >> ~/Desktop/logs/uCLbench.log 2>&1
echo "\n\n\n" >> ~/Desktop/logs/uCLbench.log 2>&1

echo "arith speed-----------------" >> ~/Desktop/logs/uCLbench.log 2>&1
./arith_speed --device=0 >> ~/Desktop/logs/uCLbench.log 2>&1
echo "\n\n\n" >> ~/Desktop/logs/uCLbench.log 2>&1

echo "branch penalty-----------------" >> ~/Desktop/logs/uCLbench.log 2>&1
./branch_penalty --device=0 >> ~/Desktop/logs/uCLbench.log 2>&1

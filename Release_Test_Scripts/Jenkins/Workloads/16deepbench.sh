cd ~/Desktop/rocm/workloads/DNNs/deepbench

echo AH64_uh1 | sudo -S rm -rf ~/.cache/miopen/

git clone https://github.com/rocmsoftwareplatform/rccl && cd rccl
cd src
make lib
echo AH64_uh1 | sudo -S make install


cd ~/Desktop/rocm/workloads/DNNs/deepbench/code/amd
export LD_LIBRARY_PATH=/opt/rocm/lib:/opt/rocm/rccl/lib:$LD_LIBRARY_PATH
make clean
make all -j4 >> ~/Desktop/logs/16deepbench_build.log 2>&1

./bin/conv_bench >> ~/Desktop/logs/16deepbench_conv.log 2>&1
./bin/gemm_bench >> ~/Desktop/logs/16deepbench_gemm.log 2>&1
./bin/rnn_bench >> ~/Desktop/logs/16deepbench_rnn.log 2>&1
./bin/rccl_single_all_reduce 2 >> ~/Desktop/logs/16deepbench_rccl.log 2>&1


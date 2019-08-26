cd ~/Desktop/DTB/src/hip/HIP-Examples

cd add4
make clean
./buildit.sh
./runhip.sh > ~/Desktop/logs/3hip-examples-add4.log 2>&1

cd ../cuda-stream
make clean
make 
./stream > ~/Desktop/logs/3hip-examples-cuda-stream.log 2>&1

cd ../gpu-burn
make clean
make
./build/gpuburn-hip > ~/Desktop/logs/3hip-examples-gpuburn.log 2>&1

cd ../mini-nbody/hip
echo "-----------HIP-nbody-block----------" > ~/Desktop/logs/3hip-examples-mini-nbody.log 2>&1
./HIP-nbody-block.sh | tee -a ~/dockerx/3hip-examples-mini-nbody.log 2>&1
echo "-----------HIP-nbody-orig----------" | tee -a ~/dockerx/3hip-examples-mini-nbody.log 2>&1
./HIP-nbody-orig.sh | tee -a ~/dockerx/3hip-examples-mini-nbody.log 2>&1
echo "-----------HIP-nbody-soa-----------" | tee -a ~/dockerx/3hip-examples-mini-nbody.log 2>&1
./HIP-nbody-soa.sh | tee -a ~/dockerx/3hip-examples-mini-nbody.log 2>&1

cd ../../reduction
make clean
make 
./run.sh > ~/Desktop/logs/3hip-examples-reduction.log 2>&1

cd ../rtm8
./build_hip.sh 
./rtm8_hip > ~/Desktop/logs/3hip-examples-rtm8.log 2>&1

cd ../strided-access
make clean
make
./strided-access > ~/Desktop/logs/3hip-examples-strided-access.log 2>&1

cd ../vectorAdd
make clean
make > ~/Desktop/logs/3hip-examples-vectorAdd.log 2>&1



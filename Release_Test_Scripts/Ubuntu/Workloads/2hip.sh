cd ~/Desktop/DTB/src/hip
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$PWD/install
make -j16
make install
make check -j16 | tee -a ~/dockerx/2hip_DirectedTests.log 2>&1

cd ~/Desktop/DTB/src/hip/samples/0_Intro/bit_extract
make 
./bit_extract > ~/Desktop/logs/2hip-0Intro-bit_extract.log 2>&1

cd ../hcc_dialects
make
./vadd_hc_am | tee -a ~/dockerx/2hip-0Intro-hcc_dialects.log 2>&1
./vadd_hc_array | tee -a ~/dockerx/2hip-0Intro-hcc_dialects.log 2>&1
./vadd_hc_arrayview | tee -a ~/dockerx/2hip-0Intro-hcc_dialects.log 2>&1


/opt/rocm/bin/rocm_agent_enumerator -t GPU >> gpu_data.log
if grep -q gfx900 gpu_data.log;then
  export ROCM_TARGET=gfx900
fi

cd ../module_api
make
./runKernel.hip.out > ~/Desktop/logs/2hip-0Intro-module_api.log 2>&1
./launchKernelHcc.hip.out > ~/Desktop/logs/2hip-0Intro-module_api.log 2>&1

cd ../module_api_global
make
./runKernel.hip.out > ~/Desktop/logs/2hip-0Intro-module_api_global.log 2>&1

unset ROCM_TARGET

cd ../square
echo AH64_uh1 | sudo -S make
./square.out > ~/Desktop/logs/2hip-0Intro-square.log 2>&1

cd ../../1_Utils/hipBusBandwidth
echo AH64_uh1 | sudo -S make
./hipBusBandwidth > ~/Desktop/logs/2hip-1Utils-hipBusBandwidth.log 2>&1
./hipBusBandwidth --unpinned > ~/Desktop/logs/2hip-1Utils-hipBusBandwidth-unpinned.log 2>&1
./hipBusBandwidth --p2p -o 524288 > ~/Desktop/logs/2hip-1Utils-hipBusBandwidth-peer2peer.log 2>&1

cd ../hipDispatchLatency
echo AH64_uh1 | sudo -S make
./hipDispatchLatency  > ~/Desktop/logs/2hip-1Utils-hipDispatchLatency.log 2>&1

cd ../hipCommander
echo AH64_uh1 | sudo -S make
./hipCommander  > ~/Desktop/logs/2hip-1Utils-hipCommander.log 2>&1

cd ../hipInfo
echo AH64_uh1 | sudo -S make
./hipInfo  > ~/Desktop/logs/2hip-1Utils-hipInfo.log 2>&1

cd ../../2_Cookbook/0_MatrixTranspose
echo AH64_uh1 | sudo -S make | tee -a ~/dockerx/2hip-2Cookbook-0MatrixTranspose.log 2>&1

cd ../1_hipEvent
echo AH64_uh1 | sudo -S make | tee -a ~/dockerx/2hip-2Cookbook-1hipEvent.log 2>&1

cd ../2_Profiler
echo AH64_uh1 | sudo -S make | tee -a ~/dockerx/2hip-2Cookbook-2Profiler.log 2>&1

cd ../3_shared_memory
echo AH64_uh1 | sudo -S make | tee -a ~/dockerx/2hip-2Cookbook-3sharedmemory.log 2>&1

cd ../4_shfl
echo AH64_uh1 | sudo -S make | tee -a ~/dockerx/2hip-2Cookbook-4shfl.log 2>&1

cd ../5_2dshfl
echo AH64_uh1 | sudo -S make | tee -a ~/dockerx/2hip-2Cookbook-5-2dshfl.log 2>&1

cd ../6_dynamic_shared
echo AH64_uh1 | sudo -S make | tee -a ~/dockerx/2hip-2Cookbook-6dynamicshared.log 2>&1

cd ../7_streams
echo AH64_uh1 | sudo -S make | tee -a ~/dockerx/2hip-2Cookbook-7streams.log 2>&1

cd ../8_peer2peer
echo AH64_uh1 | sudo -S make | tee -a ~/dockerx/2hip-2Cookbook-8peer2peer.log 2>&1

cd ../9_unroll
echo AH64_uh1 | sudo -S make | tee -a ~/dockerx/2hip-2Cookbook-9unroll.log 2>&1

cd ../10_inline_asm
echo AH64_uh1 | sudo -S make | tee -a ~/dockerx/2hip-2Cookbook-10inline_asm.log 2>&1

/opt/rocm/bin/rocm_agent_enumerator -t GPU >> gpu_data.log
if grep -q gfx900 gpu_data.log;then
export ROCM_TARGET=gfx900
fi

cd ../11_texture_driver
echo AH64_uh1 | sudo -S make
./texture2dDrv.out | tee -a ~/dockerx/2hip-2Cookbook-11_texture_driver.log 2>&1

unset ROCM_TARGET

cd ../12_cmake_hip_add_executable
mkdir build && cd build
cmake ..
make
./MatrixTranspose | tee -a ~/dockerx/2hip-2Cookbook-12_cmake_hip_add_executable.log 2>&1



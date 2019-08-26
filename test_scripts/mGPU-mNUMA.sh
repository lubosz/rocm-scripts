#!/bin/bash

cd ~/dockerx/

git clone https://streamhsa:AH64_uh1@github.com/RadeonOpenCompute/MLSEQA_TestRepo
cd MLSEQA_TestRepo/HIP/Multi-Gpu-Multi-Numa-node-tests/
chmod 777 -R *

cd INTER-NUMA-Ops

printf "\n\n===============INTER-NUMA-Ops=================\n" 2>&1 | tee -a ~/dockerx/mGPU-mNUMA.log

./INTER-NUMA-Ops.sh 2>&1 | tee -a ~/dockerx/mGPU-mNUMA.log


cd ../INTRA-NUMA-Mem-I

printf "\n\n===============INTRA-NUMA-Mem-I=================\n" 2>&1 | tee -a ~/dockerx/mGPU-mNUMA.log

./BuildnRun.sh 2>&1 | tee -a ~/dockerx/mGPU-mNUMA.log


cd ../INTRA-NUMA-Operations

printf "\n\n===============INTRA-NUMA-Operations=================\n" 2>&1 | tee -a ~/dockerx/mGPU-mNUMA.log

./BuildnRun.sh 2>&1 | tee -a ~/dockerx/mGPU-mNUMA.log


cd ../INTRA-NUMA-hipHM

printf "\n\n===============INTRA-NUMA-hipHM=================\n" 2>&1 | tee -a ~/dockerx/mGPU-mNUMA.log

./BuildnRun.sh 2>&1 | tee -a ~/dockerx/mGPU-mNUMA.log


cd ../NTRA-NUMA-hipHR

printf "\n\n===============NTRA-NUMA-hipHR=================\n" 2>&1 | tee -a ~/dockerx/mGPU-mNUMA.log

./BuildnRun.sh 2>&1 | tee -a ~/dockerx/mGPU-mNUMA.log

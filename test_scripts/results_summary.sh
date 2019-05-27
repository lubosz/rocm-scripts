#!/bin/bash

cd /dockerx/


printf "\n\n===============MIOpen=================\n" 2>&1 | tee -a /dockerx/full_summary.log

timeout 1s tail -f mlopen-ut.log 2>&1 | tee -a /dockerx/full_summary.log

printf "\n\n===============rocALUTION=================\n" 2>&1 | tee -a /dockerx/full_summary.log

timeout 1s tail -f rocalution-test.log 2>&1 | tee -a /dockerx/full_summary.log

printf "\n\n===============rocPRIM=================\n" 2>&1 | tee -a /dockerx/full_summary.log

timeout 1s tail -f rocPRIM_unittest.log 2>&1 | tee -a /dockerx/full_summary.log

printf "\n\n===============hipSPARSE=================\n" 2>&1 | tee -a /dockerx/full_summary.log

timeout 1s tail -f hipsparse-test.log 2>&1 | tee -a /dockerx/full_summary.log

printf "\n\n===============rocSPARSE=================\n" 2>&1 | tee -a /dockerx/full_summary.log

timeout 1s tail -f rocsparse-test.log 2>&1 | tee -a /dockerx/full_summary.log

printf "\n\n===============rocFFT=================\n" 2>&1 | tee -a /dockerx/full_summary.log

timeout 1s tail -f rocfft.log 2>&1 | tee -a /dockerx/full_summary.log

printf "\n\n===============hipBLAS=================\n" 2>&1 | tee -a /dockerx/full_summary.log

timeout 1s tail -f hipblas.log 2>&1 | tee -a /dockerx/full_summary.log

printf "\n\n===============rocBLAS=================\n" 2>&1 | tee -a /dockerx/full_summary.log

timeout 1s tail -f rocblas.log 2>&1 | tee -a /dockerx/full_summary.log

printf "\n\n===============rocRAND_Kernel_BM=================\n" 2>&1 | tee -a /dockerx/full_summary.log

timeout 1s tail -f bm_rocrand_kernal.log 2>&1 | tee -a /dockerx/full_summary.log

printf "\n\n===============rocRAND_Generate_BM=================\n" 2>&1 | tee -a /dockerx/full_summary.log

timeout 1s tail -f bm_rocrand_generate.log 2>&1 | tee -a /dockerx/full_summary.log

printf "\n\n===============rocRAND=================\n" 2>&1 | tee -a /dockerx/full_summary.log

timeout 1s tail -f rocrand-ut.log 2>&1 | tee -a /dockerx/full_summary.log

printf "\n\n===============hipCUB=================\n" 2>&1 | tee -a /dockerx/full_summary.log

timeout 1s tail -f hipCUB.log 2>&1 | tee -a /dockerx/full_summary.log

printf "\n\n===============rocTHRUST=================\n" 2>&1 | tee -a /dockerx/full_summary.log

timeout 1s tail -f rocTHRUST.log 2>&1 | tee -a /dockerx/full_summary.log
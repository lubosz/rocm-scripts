#!/bin/bash

cd /dockerx/


echo "\n\n===============MIOpen=================\n"

timeout 1s tail -f mlopen-ut.log >> ~/dockerx/full_summary.log

echo "\n\n===============rocALUTION=================\n"

timeout 1s tail -f rocalution-test.log >> ~/dockerx/full_summary.log

echo "\n\n===============rocPRIM=================\n"

timeout 1s tail -f rocPRIM_unittest.log >> ~/dockerx/full_summary.log

echo "\n\n===============hipSPARSE=================\n"

timeout 1s tail -f hipsparse-test.log >> ~/dockerx/full_summary.log

echo "\n\n===============rocSPARSE=================\n"

timeout 1s tail -f rocsparse-test.log >> ~/dockerx/full_summary.log

echo "\n\n===============rocFFT=================\n"

timeout 1s tail -f rocfft.log >> ~/dockerx/full_summary.log

echo "\n\n===============hipBLAS=================\n"

timeout 1s tail -f hipblas.log >> ~/dockerx/full_summary.log

echo "\n\n===============rocBLAS=================\n"

timeout 1s tail -f rocblas.log >> ~/dockerx/full_summary.log

echo "\n\n===============rocRAND_Kernel_BM=================\n"

timeout 1s tail -f bm_rocrand_kernal.log >> ~/dockerx/full_summary.log

echo "\n\n===============rocRAND_Generate_BM=================\n"

timeout 1s tail -f bm_rocrand_generate.log >> ~/dockerx/full_summary.log

echo "\n\n===============rocRAND=================\n"

timeout 1s tail -f rocrand-ut.log >> ~/dockerx/full_summary.log
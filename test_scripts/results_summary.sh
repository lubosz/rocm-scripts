#!/bin/bash

echo (===============MIOpen=================)

tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

break

echo (===============rocALUTION=================)

tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

break

echo (===============rocPRIM=================)

tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

break

echo (===============hipSPARSE=================)

tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

break

echo (===============rocSPARSE=================)

tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

break

echo (===============rocFFT=================)

tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

break

echo (===============hipBLAS=================)

tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

break

echo (===============rocBLAS=================)

tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

break

echo (===============rocRAND_Kernel_BM=================)

tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

break

echo (===============rocRAND_Generate_BM=================)

tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

break

echo (===============rocRAND=================)

tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

break
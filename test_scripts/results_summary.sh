#!/bin/bash

cd /dockerx/


echo "===============MIOpen================="

timeout 1s tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

echo "===============rocALUTION================="

timeout 1s tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

echo "===============rocPRIM================="

timeout 1s tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

echo "===============hipSPARSE================="

timeout 1s tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

echo "===============rocSPARSE================="

timeout 1s tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

echo "===============rocFFT================="

timeout 1s tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

echo "===============hipBLAS================="

timeout 1s tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

echo "===============rocBLAS================="

timeout 1s tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

echo "===============rocRAND_Kernel_BM================="

timeout 1s tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

echo "===============rocRAND_Generate_BM================="

timeout 1s tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log

echo "===============rocRAND================="

timeout 1s tail -f mlopen-ut.log 2>&1 | tee -a ~/dockerx/full_summary.log
#!/bin/bash

cd /dockerx/


echo "\n\n\n===============MIOpen================="

timeout 1s tail -f mlopen-ut.log >> ~/dockerx/full_summary.log

echo "\n\n\n===============rocALUTION================="

timeout 1s tail -f mlopen-ut.log >> ~/dockerx/full_summary.log

echo "\n\n\n===============rocPRIM================="

timeout 1s tail -f mlopen-ut.log >> ~/dockerx/full_summary.log

echo "\n\n\n===============hipSPARSE================="

timeout 1s tail -f mlopen-ut.log >> ~/dockerx/full_summary.log

echo "\n\n\n===============rocSPARSE================="

timeout 1s tail -f mlopen-ut.log >> ~/dockerx/full_summary.log

echo "\n\n\n===============rocFFT================="

timeout 1s tail -f mlopen-ut.log >> ~/dockerx/full_summary.log

echo "\n\n\n===============hipBLAS================="

timeout 1s tail -f mlopen-ut.log >> ~/dockerx/full_summary.log

echo "\n\n\n===============rocBLAS================="

timeout 1s tail -f mlopen-ut.log >> ~/dockerx/full_summary.log

echo "\n\n\n===============rocRAND_Kernel_BM================="

timeout 1s tail -f mlopen-ut.log >> ~/dockerx/full_summary.log

echo "\n\n\n===============rocRAND_Generate_BM================="

timeout 1s tail -f mlopen-ut.log >> ~/dockerx/full_summary.log

echo "\n\n\n===============rocRAND================="

timeout 1s tail -f mlopen-ut.log >> ~/dockerx/full_summary.log
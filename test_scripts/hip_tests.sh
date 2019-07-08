#!/bin/sh
dir=/dockerx/rocm-scripts/ROCm_sanity_tests
echo Y | sudo apt-get install libgflags-dev
echo ##################### hipmgbench #################

cd $dir/hipmgbench/L1/fullduplex
./hipfullduplex.sh
cd $dir/hipmgbench/L1/halfduplex
./hiphalfduplex.sh
cd $dir/hipmgbench/L1/uva
./hipuva.sh

echo ##################### hipHammerTests #################

cd $dir/hipHammerTests/hipCopyHammer_D0hD1/
./hipCopyHammer_D0hD1.sh
cd $dir/hipHammerTests/hipCopyHammer_D2D/
./hipCopyHammer_D2D.sh
cd $dir/hipHammerTests/hipCopyHammer_D2H
./hipCopyHammer_D2H.sh
cd $dir/hipHammerTests/hipCopyHammer_H2D
./hipCopyHammer_H2D.sh

echo ##################### multi-gpu-bwtest #################

cd $dir/multi-gpu-bwtest
./hipBWTest.sh


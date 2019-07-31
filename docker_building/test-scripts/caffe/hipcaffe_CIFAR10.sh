##Description   : Scipt for executing CIFAR10 training
##Written by    : Ravikumar Kothakota
##Date          : 16-May-2017
##Modifications : <Ravi> Fail patterns added on 15-Nov-2017

#!/bin/sh
cwd=`pwd`
Numbers="$HOME/Desktop/Numbers"
cd $HOME/Desktop/rocm_tests/dnns/hipcaffe
export PATH=/opt/rocm/bin:$PATH
export LD_LIBRARY_PATH=/opt/rocm/lib:$LD_LIBRARY_PATH

./build/tools/caffe train --solver=examples/cifar10/cifar10_quick_solver.prototxt 2>&1 | tee hipcaffe_cifar10.log

cp -rf hipcaffe_cifar10.log $Numbers

RUN_PATT1='failed'
RUN_PATT2='error'
RUN_PATT3='fault'
RUN_PATT4='Aborted'
RUN_PATT5="No such file or directory"

echo "[STEPS]" > Results.ini
echo "Number=1" >> Results.ini
echo " " >> Results.ini
echo "[STEP_001]" >> Results.ini
echo "Description= hipcaffe_cifar10 " >> Results.ini

if grep -qiE "$RUN_PATT1|$RUN_PATT2|$RUN_PATT3|$RUN_PATT4|$RUN_PATT5" hipcaffe_cifar10.log;
 then 
  echo "Status=Failed" >> Results.ini
 else
  echo "Status=Passed" >> Results.ini
fi

mv -f Results.ini $cwd
mv -f hipcaffe_cifar10.log $cwd


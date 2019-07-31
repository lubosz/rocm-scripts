##Description   : Scipt for executing MNIST training
##Written by    : Ravikumar Kothakota
##Date          : 16-May-2017
## Modifications: <Ravi> Fail patterns added on 15-Nov-2017
## Modifications: <Pramendra> Change the logic based on passing instead of failing.

#!/bin/sh
cwd=`pwd`
Numbers="$HOME/Desktop/Numbers"
cd $HOME/Desktop/rocm_tests/dnns/hipcaffe
export PATH=/opt/rocm/bin:$PATH
export LD_LIBRARY_PATH=/opt/rocm/lib:$LD_LIBRARY_PATH


./examples/mnist/train_lenet.sh 2>&1 | tee hipcaffe_mnist.log

cp -rf hipcaffe_mnist.log $Numbers

RUN_PATT1='Optimization Done'

echo "[STEPS]" > Results.ini
echo "Number=1" >> Results.ini
echo " " >> Results.ini
echo "[STEP_001]" >> Results.ini
echo "Description= hipcaffe_mnist " >> Results.ini

if grep -qE "$RUN_PATT1" hipcaffe_mnist.log;
 then 
  echo "Status=Passed" >> Results.ini
 else
  echo "Status=Failed" >> Results.ini
fi

mv -f Results.ini $cwd
mv -f hipcaffe_mnist.log $cwd


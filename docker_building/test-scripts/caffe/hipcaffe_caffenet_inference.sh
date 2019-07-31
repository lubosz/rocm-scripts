##Description   : Scipt for executing Caffenet_inference
##Written by    : Ravikumar Kothakota
##Date          : 16-May-2017
##Modifications : <Ravi> Fail patterns added on 15-Nov-2017

#!/bin/sh
cwd=`pwd`
Numbers="$HOME/Desktop/Numbers"
echo "AH64_uh1" | sudo -S apt-get install python-yaml

cd $HOME/Desktop/rocm_tests/dnns/hipcaffe
export PATH=/opt/rocm/bin:$PATH
export LD_LIBRARY_PATH=/opt/rocm/lib:$LD_LIBRARY_PATH

./build/examples/cpp_classification/classification.bin \
        models/bvlc_reference_caffenet/deploy.prototxt \
    models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel \
    data/ilsvrc12/imagenet_mean.binaryproto \
    data/ilsvrc12/synset_words.txt \
    examples/images/cat.jpg 2>&1 | tee hipcaffe_caffenet.log

cp -rf hipcaffe_caffenet.log $Numbers
  
RUN_PATT1='failed'
RUN_PATT2='error'
RUN_PATT3='fault'
RUN_PATT4='Aborted'
RUN_PATT5="No such file or directory"

echo "[STEPS]" > Results.ini
echo "Number=1" >> Results.ini
echo " " >> Results.ini
echo "[STEP_001]" >> Results.ini
echo "Description= hipcaffe_mnist " >> Results.ini

if grep -qiE "$RUN_PATT1|$RUN_PATT2|$RUN_PATT3|$RUN_PATT4|$RUN_PATT5" hipcaffe_caffenet.log;
 then 
  echo "Status=Failed" >> Results.ini
 else
  echo "Status=Passed" >> Results.ini
fi

mv -f Results.ini $cwd
mv -f hipcaffe_caffenet.log $cwd


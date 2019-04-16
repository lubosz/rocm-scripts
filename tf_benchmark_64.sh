#!/bin/bash

cwd=`pwd`
BASEDIR=$HOME

cd $cwd
#rm -rf logs
mkdir -p /dockerx/tf-logs

export MODELDIR="$BASEDIR/models"
export BENCHDIR="$BASEDIR/benchmarks"
export LOGDIR="/dockerx/tf-logs"

download_tensorflow_models()
{
    cd $BASEDIR
        rm -rf models
    git clone https://github.com/tensorflow/models.git
    # FIXME:  workaround to support TF v1.0.1
    pushd models
    popd
}
download_tensorflow_benchmarks()
{
    cd $BASEDIR
        rm -rf benchmarks
        git clone -b cnn_tf_v1.12_compatible https://github.com/tensorflow/benchmarks && cd benchmarks
        #git checkout -b may22 ddb23306fdc60fefe620e6ce633bcd645561cb0d
        #sed -i 's|from tensorflow.contrib import nccl|#from tensorflow.contrib import nccl|g' ./scripts/tf_cnn_benchmarks/variable_mgr.py
        cd ..
    pushd benchmarks
    popd
}

run_tf_cnn_benchmarks()
{
    echo "=======================tf_cnn_benchmarks==============="
        cd $BENCHDIR
 #       cd $BENCHDIR/scripts/tf_cnn_benchmarks/
#       sed -i 's/import cPickle/import pickle/g' datasets.py
        cd $BENCHDIR
#     MODELS="alexnet"
    MODELS="alexnet googlenet inception3 inception4 resnet50 resnet152_v2 vgg11 vgg16 vgg19 resnet101 resnet50_v1.5"
        NGPUS=4
        ITERATIONS=500
#       BATCH_SIZE=( 1 2 4 8 16 32 64 )
        BATCH_SIZE=64

        for j in ${BATCH_SIZE[@]}
        do
        for i in ${MODELS[@]}
        do
    /usr/bin/python3 ./scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py --model=$i \
    --print_training_accuracy=True \
    --num_batches=${ITERATIONS} --variable_update=parameter_server --local_parameter_device=cpu \
    --num_gpus=${NGPUS} --batch_size=$j  2>&1 | tee $LOGDIR/tf-$i-$j.txt
    done
    done
}
run_tf_cnn_benchmarks


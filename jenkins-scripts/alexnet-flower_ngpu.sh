#!/bin/bash
current=`pwd`
MODELDIR=/root/models
mkdir -p /dockerx/flower-alexnet
rm -rf /dockerx/flower-alexnet/*
mkdir -p /dockerx/tf-logs
LOGDIR=/dockerx/tf-logs
cp -rf /dockerx/rocm-scripts/test_scripts/preprocessing_factory.py /root/models/research/slim/preprocessing/
run_flower_alexnet()
{
    echo "=======================flower-alexnet==============="
        cd $MODELDIR/research/slim
     chmod u+x download_and_convert_data.py
    python3 download_and_convert_data.py --dataset_name=flowers --dataset_dir=/dockerx/flower-alexnet
   
     python3 train_image_classifier.py --train_dir=/tmp/flowers-models/alexnet --dataset_name=flowers --dataset_split_name=train --dataset_dir=/dockerx/flower-alexnet --model_name=alexnet_v2 --max_number_of_steps=500 --batch_size=128 --num_clones=$ngpu 2>&1 | tee  flower-alexnet.txt

         cp -rf flower-alexnet.txt $LOGDIR

        #Total Avg. Execution time : 40mins
        # Expected "final" output:
        #2018-03-30 04:21:55.142483: I tensorflow/core/kernels/logging_ops.cc:79] eval/Accuracy[0.8526]
        #2018-03-30 04:21:55.142565: I tensorflow/core/kernels/logging_ops.cc:79] eval/Recall_5[0.9918]
        #INFO:tensorflow:Finished evaluation at 2018-03-30-04:21:55

}

run_flower_alexnet

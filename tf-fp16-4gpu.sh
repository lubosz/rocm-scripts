#!/bin/bash
export MIOPEN_DEBUG_AMD_WINOGRAD_RXS_FP16=1
export TF_ROCM_FUSION_ENABLE=1


cwd=`pwd`
BASEDIR=$HOME

cd $cwd
mkdir -p /dockerx/tf-logs

export BENCHDIR="$BASEDIR/benchmarks"
export LOGDIR="/dockerx/tf-logs"


function tf_cnn_benchmarks()
{
  model=$1
  num_gpus=$2
  bsz=$3
  f_only=$4
  num_batches=500
  display_every=10
  log_file=$logfile/${model}_${bsz}_${f_only}_${num_gpus}.log
  #echo "Model:${model}_${bsz}_${f_only}_${num_gpus}"
  python3 tf_cnn_benchmarks.py --num_gpus=$num_gpus --batch_size=$bsz --model=$model --forward_only=${f_only} --print_training_accuracy=True --num_batches=${num_batches} --display_every=${display_every} --use_fp16=True --xla=False 2>&1 | tee $LOGDIR/$log_file
  #grep -E "total images/sec" $log_file
}

function tf_test()
{
  nets=$1
  gpu_array=$2
  batch_array=$3
  modes=$4
  for net in ${nets[@]}
  do
    for num_gpus in ${gpu_array[@]}
    do
      for batch in ${batch_array[@]}
      do
        for f_only in ${modes[@]}
        do
          tf_cnn_benchmarks $net $num_gpus $batch $f_only
        done
      done
    done
  done
}

gpu_array=(4)
modes=('False')
cd /root/benchmarks/scripts/tf_cnn_benchmarks
nets=(resnet50)
batch_array=(128)
tf_test $nets $gpu_array $batch_array $modes

cd $LOGDIR
cnn_bms=`grep -E "total images/sec" tf-resnet-fp16-$bsz.log | wc -l`

echo "[STEPS]" > Results.ini
echo "Number=1" >> Results.ini
echo " " >> Results.ini

echo "[STEP_007]" >> Results.ini
echo "Description= cnn_bms" >> Results.ini
if [ $cnn_bms -eq 9 ]; then
  echo "Status=Passed" >> Results.ini
else
  echo "Status=Failed" >> Results.ini
fi

cp -rf Results.ini ../


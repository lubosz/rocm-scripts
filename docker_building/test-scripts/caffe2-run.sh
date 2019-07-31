#!/bin/bash
export PATH=/opt/rocm/bin:$PATH
export PATH=/opt/rocm/hcc/bin:$PATH
export PATH=/opt/rocm/hip/bin:$PATH
export PATH=/opt/rocm/opencl/bin/x86_64:$PATH
export LD_LIBRARY_PATH=/usr/local/caffe2/lib
export PYTHONPATH=/usr/local/caffe2/lib/python2.7/dist-packages

 
# check if caffe2 is  build and installed properly. success => all good; failure => not built and installed properly.
echo "===============If success, caffe2 installed properly======="
  cd /home/pytorch/build_caffe2
  python -c 'from caffe2.python import core' 2>/dev/null && echo "Success" || echo "Failure"
  
# run the unit tests
echo "=========================start caffe2 unittests====================="
cd /home/pytorch/
 .jenkins/caffe2/test.sh 2>&1 | tee caffe2_tests.log 
  
  echo "=========================end caffe2 unittests====================="
#Run the Benchmark

echo "=========================start caffe2 benchmark====================="
cd /home/pytorch/build_caffe2

#Navigate to build directory, cd pytorch/build_caffe2 to run benchmarks.
#Caffe2 benchmarking script supports the following networks.
#    MLP
#    AlexNet
#    OverFeat
#    VGGA
#    Inception
#    Inception_v2
#    Resnet50

#Special case: Inception_v2 and Resnet50 will need their corresponding protobuf files to run the benchmarks. Protobufs can be downloaded from caffe2 model zoo using the below command. Substitute model_name with inception_v2 or resnet50
#python caffe2/python/models/download.py <model_name>

python caffe2/python/models/download.py inception_v2
python caffe2/python/models/download.py resnet50

#This will download the protobufs to current working directory.

#To run benchmarks for networks MLP, AlexNet, OverFeat, VGGA, Inception, run the command replacing <name_of_the_netwrok> with one of the networks.
#python caffe2/python/convnet_benchmarks.py --batch_size 64 --model <name_of_the_network> --engine MIOPEN --layer_wise_benchmark True --net_type simple

echo "========================= caffe2 MLP model====================="
python caffe2/python/convnet_benchmarks.py --batch_size 64 --model MLP --engine MIOPEN --layer_wise_benchmark True --net_type simple 2>&1 | tee caffe2-mlp.log
echo "========================= caffe2 Alexnet model====================="
python caffe2/python/convnet_benchmarks.py --batch_size 64 --model AlexNet --engine MIOPEN --layer_wise_benchmark True --net_type simple 2>&1 | tee caffe2-alexnet.log
echo "========================= caffe2 OverFeat model====================="
python caffe2/python/convnet_benchmarks.py --batch_size 64 --model OverFeat --engine MIOPEN --layer_wise_benchmark True --net_type simple 2>&1 | tee caffe2-overfeat.log
echo "========================= caffe2 VGGA model====================="
python caffe2/python/convnet_benchmarks.py --batch_size 64 --model VGGA --engine MIOPEN --layer_wise_benchmark True --net_type simple 2>&1 | tee caffe2-vgga.log
echo "========================= caffe2 Inception model====================="
python caffe2/python/convnet_benchmarks.py --batch_size 64 --model Inception --engine MIOPEN --layer_wise_benchmark True --net_type simple 2>&1 | tee caffe2-inception.log

#To run Inception_v2 or Resnet50, please add additional argument --model_path to the above command which should point to the model directories downloaded above.
#python caffe2/python/convnet_benchmarks.py --batch_size 64 --model <name_of_the_network> --engine MIOPEN --layer_wise_benchmark True --net_type simple --model_path <path_to_model_protobufs>

echo "========================= caffe2 Inception_v2 model====================="
python caffe2/python/convnet_benchmarks.py --batch_size 64 --model Inception_v2 --engine MIOPEN --layer_wise_benchmark True --net_type simple --model_path /home/pytorch/build_caffe2/inception_v2 2>&1 | tee caffe2-inception_v2.log
echo "========================= caffe2 Resnet50 model====================="
python caffe2/python/convnet_benchmarks.py --batch_size 64 --model Resnet50 --engine MIOPEN --layer_wise_benchmark True --net_type simple --model_path /home/pytorch/build_caffe2/resnet50 2>&1 | tee caffe2-resnet50.log

echo "========================end caffe2 benchmark====================="
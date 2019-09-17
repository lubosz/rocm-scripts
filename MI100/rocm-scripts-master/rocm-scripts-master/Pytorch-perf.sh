#!/bin/bash
cd /root/pytorch/build
export LD_LIBRARY_PATH=/opt/rocm/lib:$LD_LIBRARY_PATH
wget  https://raw.githubusercontent.com/wiki/ROCmSoftwarePlatform/pytorch/micro_benchmarking_pytorch.py
wget  https://raw.githubusercontent.com/wiki/ROCmSoftwarePlatform/pytorch/fp16util.py 
wget https://raw.githubusercontent.com/wiki/ROCmSoftwarePlatform/pytorch/shufflenet.py 
wget https://raw.githubusercontent.com/wiki/ROCmSoftwarePlatform/pytorch/shufflenet_v2.py 

chmod 775 micro_benchmarking_pytorch.py fp16util.py shufflenet.py shufflenet_v2.py 

pip install torchvision==0.2.2.post3

echo "========================= pytorch resnet50 256====================="
python micro_benchmarking_pytorch.py --network resnet50 --batch-size 256 --iterations 10
echo "========================= pytorch resnet101 128====================="
python micro_benchmarking_pytorch.py --network resnet101 --batch-size 128 --iterations 10
echo "========================= pytorch resnet152 128====================="
python micro_benchmarking_pytorch.py --network resnet152 --batch-size 128 --iterations 10
echo "========================= pytorch Alexnet 1024====================="
python micro_benchmarking_pytorch.py --network alexnet --batch-size 1024 --iterations 10
echo "========================= pytorch Squeezenet 128===================="
python micro_benchmarking_pytorch.py --network SqueezeNet --batch-size 128 --iterations 10 
echo "========================= pytorch Inceptionv3 256====================="
python micro_benchmarking_pytorch.py --network inception_v3 --batch-size 256 --iterations 10
echo "========================= pytorch densenet121 128====================="
python micro_benchmarking_pytorch.py --network densenet121 --batch-size 128 --iterations 10
echo "========================= pytorch vgg16 128====================="
python micro_benchmarking_pytorch.py --network vgg16 --batch-size 128 --iterations 10 
echo "========================= pytorch vgg19 128===================="
python micro_benchmarking_pytorch.py --network vgg19 --batch-size 128 --iterations 10

echo "========================= pytorch  resnet50 fp16 256====================="
python micro_benchmarking_pytorch.py --network resnet50 --batch-size 256 --iterations 10 --fp16 1
echo "========================= pytorch  resnet101 fp16 128====================="
python micro_benchmarking_pytorch.py --network resnet101 --batch-size 128 --iterations 10 --fp16 1
echo "========================= pytorch  resnet152 fp16 128 ====================="
python micro_benchmarking_pytorch.py --network resnet152 --batch-size 128 --iterations 10 --fp16 1
echo "========================= pytorch  alexnet fp16 1024====================="
python micro_benchmarking_pytorch.py --network alexnet --batch-size 1024 --iterations 10 --fp16 1
echo "========================= pytorch  squeeznet fp16 128====================="
python micro_benchmarking_pytorch.py --network SqueezeNet --batch-size 128 --iterations 10 --fp16 1
echo "========================= pytorch inceptionv3 fp16 256====================="
python micro_benchmarking_pytorch.py --network inception_v3 --batch-size 256 --iterations 10 --fp16 1
echo "========================= pytorch  densenet121 fp16 128====================="
python micro_benchmarking_pytorch.py --network densenet121 --batch-size 128 --iterations 10 --fp16 1
echo "========================= pytorch  vgg16 fp16 128====================="
python micro_benchmarking_pytorch.py --network vgg16 --batch-size 128 --iterations 10 --fp16 1
echo "========================= pytorch  vgg19 fp16 128====================="
python micro_benchmarking_pytorch.py --network vgg19 --batch-size 128 --iterations 10 --fp16 1

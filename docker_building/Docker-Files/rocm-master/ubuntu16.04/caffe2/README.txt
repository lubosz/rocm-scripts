Below is new step to build Caffe2 dockerimage. Existing dockerfile is not valid anymore.


How to build caffe2 dockerimage
1.git clone https://github.com/pytorch/pytorch
2. Copy attached script  install_rocm.sh to "pytorch/docker/caffe2/jenkins/common" path. Overwrite the existing one for roc-master. If you need for release , no need to copy attached sh file.
     edit the repo path in existing default "install_rocm.sh"
     
cp -rf install_rocm.sh  pytorch/docker/caffe2/jenkins/common
     
3. cd pytorch/docker/caffe2/jenkins

4. ./build.sh py2-clang7-rocmdeb-ubuntu16.04

It will create docker image

5. Lauch the container using the above dockerimage

6. Inside docker container, do below

cd /home/ && git clone  https://github.com/pytorch/pytorch
cd pytorch

git submodule init
git submodule update --init --recursive

#For gfx900, do below

.jenkins/caffe2/build.sh 2>&1 | tee caffe2_build.log 

#gfx906, do below

HCC_AMDGPU_TARGET=gfx906 .jenkins/caffe2/build.sh 2>&1 | tee caffe2_build.log
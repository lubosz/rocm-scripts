1. These dockerfile are to build dockerimage based on rocm-release 
2. It can be used for both UB16.04 or 18.04. You just need to change "base/Dockerfile" inside Ubuntu16 folder image name as per your requirement
3. You need to use centos7 folder fr centos
4. base/Dockerfile will build images with all roc-master component ( excluding kfd, firmware )
5. There is "*all*" dockerfile also. It will build all as mentioned in point3 + + all mathlibs + hipcaffe + deepbench + rccl. Just you need to rename it as "Dockerfile" 
6. Caffe2 or Pytorch or CNTK needs to be built seperately as lot of chanages needs to be done specific to these apps.
7. Use *.sh file to build the dockerimage. You need to edit sh file first according to your need.
8. Build docker image after editing sh file as "sudo ./*.sh <roc-rel#>. For eg: sudo ./*.sh 1.9


1. These dockerfile are to build dockerimage based on rocm-master
2. It can be used for both UB16.04 or 18.04. You just need to change "base/Dockerfile" image name as per your requirement
3. base/Dockerfile will build images with all roc-master component ( excluding kfd, firmware ) + all mathlibs + hipcaffe + deepbench + rccl
4. There is "*all*" dockerfile also. It will build all as mentioned in point3 + tf. Just you need to rename it as "Dockerfile" 
5. Caffe2 or Pytorch or CNTK needs to be built seperately and lot of chanages needs to be done specific to these apps.
6. Use *.sh file to build the dockerimage. You need to edit sh file first according to your need.
7. Build docker image after editing sh file as "sudo ./*.sh <roc-master-build#>. For eg: sudo ./*.sh 9369


How to build Pytorch and Tensorflow DOcker images

Clone the base , pytorch and tf1.12 and *.sh at local path under one directory.
Use the sh file as below to build , images
./docker...*.sh <build#>
It will build base image having roc-master componet + mathlibs + MIOpen
On top of above base image , it will call tf1.12/Dockerfile to build tf1.12 and pytorch/Dockerfile to build pytorch

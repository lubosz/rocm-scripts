#!/bin/bash
sudo yum autoremove rocm-opencl

sudo yum autoremove rocm-libs miopen-hip miopengemm

sudo rm -rf /opt/rocm/*          #Remove the residue if its there

sudo rm -rf /var/cache/yum   #Remove the cache

sudo yum clean all

sudo reboot
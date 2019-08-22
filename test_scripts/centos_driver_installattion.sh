#!/bin/sh
sudo yum clean all && sudo rm -rf /var/cache/yum
sudo yum install -y epel-release
sudo yum install -y dkms kernel-headers-`uname -r` kernel-devel-`uname -r`
su root

echo "[ROCm]" > /etc/yum.repos.d/rocm.repo
echo "name=ROCm" >> /etc/yum.repos.d/rocm.repo
echo "baseurl=http://10.216.151.220/artifactory/rocm-osdb-rpm/compute-rocm-dkms-no-npi-$1" >> /etc/yum.repos.d/rocm.repo
echo "enabled=1" >> /etc/yum.repos.d/rocm.repo
echo "gpgcheck=0" >> /etc/yum.repos.d/rocm.repo

exit
sudo yum install --nogpgcheck -y rocm-dkms

sudo yum install --nogpgcheck -y rocm-libs miopen-hip miopengemm
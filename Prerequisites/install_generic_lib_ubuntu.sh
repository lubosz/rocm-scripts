#!/bin/bash
username="AH64_uh1"
echo "User name : $username"
################new requirement from roc-master 6445############
echo $username | sudo usermod -a -G video taccuser
#############Common ones#########
echo $username | sudo apt-get -y  install dos2unix smbclient vim ssh
echo $username | sudo apt-get -y  install cifs-utils expect cmake git

#############Sikuli needs#########
echo $username | sudo apt-get -y  install openjdk-8-jre-headless
#############dt99 script needs#########
echo $username | sudo apt-get -y  install mesa-utils
#############Gromacs Needs#########
echo $username | sudo apt-get -y  install libhwloc-common libhwloc-dev libhwloc-plugins
echo $username | sudo apt-get -y  install libatlas3-base
#############Baikal needs#########
echo $username | sudo apt-get -y  install libopenimageio1.6
#############Luxmark needs#########
echo $username | sudo apt-get -y  install freeglut3-dev
#############below is suggested by Adrain#########
echo $username | sudo apt-get -y  install check xsltproc

#############roc-master driver hcc needs#########
echo $username | sudo apt-get -y  install g++-multilib gcc-multilib libunwind-dev  libnuma-dev
#############computeapps - snapc and xsbench#########
echo $username | sudo apt-get -y install libdwarf-dev libelf-dev libomp-dev openmpi-bin libopenmpi-dev
echo $username | sudo apt-get -y install libboost*
#############hcfft#########
#echo $username | sudo apt-get -y install libfftw3-dev
#############this is required to grab deb or rpm files with latest change in mainline build install method#########
echo $username | sudo apt-get -y install aria2
#############KFD requirements from 4.16 kernel#########
echo $username | sudo apt-get -y install flex bison
################for miopen to build############
echo $username | sudo apt-get install cmake

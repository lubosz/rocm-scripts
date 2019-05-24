#!/bin/bash
username="$(id -u -n)"
echo "User name : $username"

echo $username | sudo -S dnf install libcxx-devel OpenImageIO
echo $username | sudo -S dnf install gcc-c++ cmake freeglut-devel libstdc++-static
echo $username | sudo -S dnf install hwloc-devel fftw fftw3-devel
echo $username | sudo -S dnf install check check-devel



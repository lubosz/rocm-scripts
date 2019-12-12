cd ~/Desktop/rocm/workloads/mathlibs/rocprim

echo AH64_uh1 | sudo -S rm -rf build
mkdir build; cd build

CXX=/opt/rocm/hcc/bin/hcc cmake -DDISABLE_WERROR=ON ../. >> ~/Desktop/logs/11rocprim_build.log 2>&1
make -j >> ~/Desktop/logs/11rocprim_build.log 2>&1

#To run unit tests
ctest --output-on-failure >> ~/Desktop/logs/11rocprim_unittest.log 2>&1



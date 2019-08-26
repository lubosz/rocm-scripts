cd ~/Desktop/rocm/workloads/mathlibs/hipcub

echo AH64_uh1 | sudo -S rm -rf build
mkdir build; cd build

CXX=/opt/rocm/hcc/bin/hcc cmake -DDISABLE_WERROR=ON ../. | tee -a ~/dockerx/13hipcub_build.log 2>&1
make -j | tee -a ~/dockerx/13hipcub_build.log 2>&1

#To run unit tests
ctest --output-on-failure | tee -a ~/dockerx/13hipcub_unittest.log 2>&1



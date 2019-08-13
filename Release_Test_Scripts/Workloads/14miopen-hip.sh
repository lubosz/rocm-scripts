cd ~/Desktop/rocm/workloads/DNNs/miopen-hip

echo AH64_uh1 | sudo -S rm -rf ~/.cache/miopen/

echo AH64_uh1 | sudo -S rm -rf build
mkdir build && cd build
export LD_LIBRARY_PATH=/opt/rocm/hip/lib/:/opt/rocm/miopengemm/lib

echo AH64_uh1 | sudo -S mount -t cifs -o username=taccuser,password=AH64_uh1,vers=1.0 //hydinstreamcqe1/hsa /mnt
echo AH64_uh1 | sudo -S cp -rf /mnt/Taccuser/Ravi/LC_testdata/mlopen/* /opt/rocm/include/.

echo AH64_uh1 | sudo -S apt-get -y install libssl-dev
echo AH64_uh1 | sudo -S ln -s /usr/include/x86_64-linux-gnu/openssl/opensslconf.h /usr/include/openssl

CXX=/opt/rocm/hcc/bin/hcc cmake -DMIOPEN_TEST_ALL=ON -DBoost_USE_STATIC_LIBS=Off -DMIOPEN_BACKEND=HIP -DCMAKE_PREFIX_PATH="/opt/rocm/hcc;/opt/rocm/hip" -DCMAKE_CXX_FLAGS="-isystem /usr/include/x86_64-linux-gnu/" -DMIOPEN_TEST_FLAGS='--disable-verification-cache' .. | tee -a ~/dockerx/14miopen-hip-build.log 2>&1

export MIOPEN_CONV_PRECISE_ROCBLAS_TIMING=0
sudo make check | tee -a ~/dockerx/14miopen-hip-test.log 2>&1

sudo make MIOpenDriver | tee -a ~/dockerx/14miopen-hip-driver.log 2>&1

 ./bin/MIOpenDriver conv -s 0 -v 0 -t 1 -F 1 -W 28 -H 28 -c 256 -n 8 -k 512 -x 3 -y 3 -p 1 -q 1 -u 1 -v 1 | tee -a ~/dockerx/14miopen-hip-benchmark.log 2>&1
 
unset MIOPEN_CONV_PRECISE_ROCBLAS_TIMING

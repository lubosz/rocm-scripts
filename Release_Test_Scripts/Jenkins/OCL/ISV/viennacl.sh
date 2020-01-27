cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/ViennaCL/
chmod +x * -R
echo AH64_uh1 | sudo -S rm -rf /tmp/*

cd ~/Desktop/Tests/OCL/ISV/ViennaCL/build/examples/benchmarks
echo "==========Test started========" >> ~/Desktop/logs/ViennaCL.log 2>&1
./dense_blas-bench-opencl >> ~/Desktop/logs/ViennaCL.log 2>&1

#./direct_solve-bench-opencl
./opencl-bench-opencl >> ~/Desktop/logs/ViennaCL.log 2>&1

cd ..
#benchmarks/sparse-bench-opencl
#benchmarks/solver-bench-opencl &
#sleep 60
#kill -9 $(pgrep solver-bench*)
echo "==========Test ended========" >> ~/Desktop/logs/ViennaCL.log 2>&1

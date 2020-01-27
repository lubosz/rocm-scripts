cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd  ~/Desktop/Tests/OCL/ISV/Rodinia/rodinia_2.4/opencl
echo AH64_uh1 | sudo -S rm -rf /tmp/*

cd backprop 
echo "==========backprop======" >> ~/Desktop/logs/Rodinia.log 2>&1
./run >> ~/Desktop/logs/Rodinia.log 2>&1

cd ..
cd bfs
echo "========bfs==============" >> ~/Desktop/logs/Rodinia.log 2>&1
./run >> ~/Desktop/logs/Rodinia.log 2>&1

cd ..
cd heartwall
echo "===========heartwall=======" >> ~/Desktop/logs/Rodinia.log 2>&1
./run >> ~/Desktop/logs/Rodinia.log 2>&1

cd ..
cd hotspot
echo "===========hotspot=======" >> ~/Desktop/logs/Rodinia.log 2>&1
./run >> ~/Desktop/logs/Rodinia.log 2>&1

cd ..
cd kmeans
echo "==========kmeans=========" >> ~/Desktop/logs/Rodinia.log 2>&1
./run >> ~/Desktop/logs/Rodinia.log 2>&1

cd ..
cd lavaMD
echo "=========lavaMD===========" >> ~/Desktop/logs/Rodinia.log 2>&1
./run >> ~/Desktop/logs/Rodinia.log 2>&1

cd ..
cd leukocyte/OpenCL
echo "==========leukocyte===========" >> ~/Desktop/logs/Rodinia.log 2>&1
./run >> ~/Desktop/logs/Rodinia.log 2>&1

cd ../../
cd lud/ocl
echo "=============lud=============" >> ~/Desktop/logs/Rodinia.log 2>&1
./run >> ~/Desktop/logs/Rodinia.log 2>&1

cd ../../
cd nw
echo "============nw================" >> ~/Desktop/logs/Rodinia.log 2>&1
./run >> ~/Desktop/logs/Rodinia.log 2>&1


cd ..
cd pathfinder
echo "==========pathfinder=============" >> ~/Desktop/logs/Rodinia.log 2>&1
./run >> ~/Desktop/logs/Rodinia.log 2>&1

cd ..
cd streamcluster
echo "=======streamcluster===========" >> ~/Desktop/logs/Rodinia.log 2>&1
./run >> ~/Desktop/logs/Rodinia.log 2>&1

cd ..
cd cfd
echo "===========cfd=======" >> ~/Desktop/logs/Rodinia.log 2>&1
./run >> ~/Desktop/logs/Rodinia.log 2>&1

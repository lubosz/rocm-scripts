cd ~/Desktop/Tests/OCL/ComputeApps
chmod +x * -R
echo AH64_uh1 | sudo -S rm -rf /tmp/*

cd ~/Desktop/Tests/OCL/ComputeApps/comd-cl 
echo "==========CoMD-ocl========" >> ~/Desktop/logs/CompApps_CoMD.log 2>&1
./CoMD-ocl >> ~/Desktop/logs/CompApps_CoMD.log 2>&1

cd ~/Desktop/Tests/OCL/ComputeApps/lulesh-cl 
echo "==========lulesh========" >> ~/Desktop/logs/CompApps_lulesh.log 2>&1
./lulesh >> ~/Desktop/logs/CompApps_lulesh.log 2>&1

cd ~/Desktop/Tests/OCL/ComputeApps/xsbench-cl/src 
echo "==========XSBench========" >> ~/Desktop/logs/CompApps_XSbench.log 2>&1
./XSBench >> ~/Desktop/logs/CompApps_XSbench.log 2>&1

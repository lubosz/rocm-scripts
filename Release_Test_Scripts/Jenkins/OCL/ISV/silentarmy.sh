cd ~/Desktop/Tests/OCL/mGPUBandwidthTest
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/silentarmy-master
./silentarmy --use=0 >> ~/Desktop/logs/silentarmy.log 2>&1


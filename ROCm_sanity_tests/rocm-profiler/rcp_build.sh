## Created by    : Paresh Patel
## Creation Date : 04/12/2018
## Description   : Script is for build rocm-profiler(RCP)

#!/bin/sh
current=`pwd`

cd $HOME/Desktop/
echo "AH64_uh1" | sudo rm -rf RCP
echo "AH64_uh1" | sudo mkdir RCP
cd $HOME/Desktop/RCP/
if [ ! -d "/mnt/ROCm-TestApps/rocm-profiler" ]; then
    mount  -t cifs -o username=taccuser,password="AH64_uh1" //hydinstreamcqe1/hsa /mnt
fi
echo "AH64_uh1" | sudo cp /mnt/ROCm-TestApps/rocm-profiler/rocm-profiler_5.6.7194-g4c4fec8_amd64.deb $HOME/Desktop/RCP/
echo "AH64_uh1" | sudo cp /mnt/ROCm-TestApps/rocm-profiler/cxlactivitylogger_5.6.7194-gaacfd47_amd64.deb $HOME/Desktop/RCP/
echo "AH64_uh1" | sudo dpkg -i rocm-profiler_5.6.7194-g4c4fec8_amd64.deb
echo "AH64_uh1" | sudo dpkg -i cxlactivitylogger_5.6.7194-gaacfd47_amd64.deb
#chmod -R 777 *
#echo "AH64_uh1" | sudo cp -r $HOME/Desktop/RCP/bin/ /opt/rocm/profiler/bin/

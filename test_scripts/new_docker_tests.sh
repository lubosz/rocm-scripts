sudo apt-get install python-prettytable

cd /root/driver/

git clone https://streamhsa:AH64_uh1@github.com/RadeonOpenCompute/MLSEQA_TestRepo
cd MLSEQA_TestRepo/Libs/hipCUB
python hipCUB.py 2>&1 | tee -a /dockerx/hipCUB.log


cd /root/driver/MLSEQA_TestRepo/Libs/rocThrust
python rocThrust.py 2>&1 | tee -a /dockerx/rocThrust.log

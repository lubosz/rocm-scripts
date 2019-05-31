sudo apt-get install python-prettytable

cd ~/Desktop/

git clone https://streamhsa:AH64_uh1@github.com/RadeonOpenCompute/MLSEQA_TestRepo
cd MLSEQA_TestRepo/HIP/HIPinMultiprocessing/fork
./BuildnRun.sh
timeout 1s tail -f Results.ini 2>&1 | tee -a ~/dockerx/full_summary.log


cd MLSEQA_TestRepo/HIP/HIPinMultiprocessing/exec
./BuildnRun.sh
timeout 1s tail -f Results.ini 2>&1 | tee -a ~/dockerx/full_summary.log
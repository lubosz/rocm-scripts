sudo apt-get install python-prettytable

cd ~/Desktop/

git clone https://streamhsa:AH64_uh1@github.com/RadeonOpenCompute/MLSEQA_TestRepo
cd MLSEQA_TestRepo/HIP/HIPinMultiprocessing/fork
chmod 777 -R *
./BuildnRun.sh
timeout 1s tail -f Results.ini 2>&1 | tee -a ~/dockerx/full_summary.log


cd MLSEQA_TestRepo/HIP/HIPinMultiprocessing/exec
chmod 777 -R *
./BuildnRun.sh
timeout 1s tail -f Results.ini 2>&1 | tee -a ~/dockerx/full_summary.log

#rocm-profiler

echo AH64_uh1 | sudo -S rm -rf ~/dockerx/rocm-profiler

mkdir -p ~/dockerx/rocm-profiler && cd ~/dockerx/rocm-profiler

wget http://13.82.220.49/rocm/apt/debian/pool/main/r/rocm-profiler/rocm-profiler_5.6.7262_amd64.deb && wget http://13.82.220.49/rocm/apt/debian/pool/main/c/cxlactivitylogger/cxlactivitylogger_5.6.7259_amd64.deb && http://compute-artifactory.amd.com/artifactory/list/rocm-osdb-deb/compute-rocm-dkms-no-npi-519/rocprofiler-dev-1.0.0-Linux.deb

wget https://raw.githubusercontent.com/RadeonOpenCompute/MLSEQA_TestRepo/master/ROCM_Tools/rocm_profiler/env_file?token=AB7ZUFVMLAQEVBHQE5DLDKS5JEMYG -O env_file

wget https://raw.githubusercontent.com/RadeonOpenCompute/MLSEQA_TestRepo/master/ROCM_Tools/rocm_profiler/rcp_build.sh?token=AB7ZUFXUI3KNOVWLEMTZASS5JEMYS -O rcp_build.sh

wget https://raw.githubusercontent.com/RadeonOpenCompute/MLSEQA_TestRepo/master/ROCM_Tools/rocm_profiler/rcp_tests.py?token=AB7ZUFS73X4JYZOFBT55ODK5JEMYY -O rcp_tests.py

chmod 777 *

echo y | sudo dpkg -i *.deb

echo y | sudo -S python rcp_tests.py

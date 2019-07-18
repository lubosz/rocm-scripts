cd ~/dockerx/
rm -rf rocm_smi_tool

mkdir -p ~/dockerx/rocm_smi_tool && cd ~/dockerx/rocm_smi_tool

wget https://raw.githubusercontent.com/RadeonOpenCompute/MLSEQA_TestRepo/master/ROCM_Tools/rocm_smi_tool/rocm_smi_common.py?token=AB7ZUFXBZ3MX6PPFH4AWVW25HGJNM -O rocm_smi_common.py
wget https://raw.githubusercontent.com/RadeonOpenCompute/MLSEQA_TestRepo/master/ROCM_Tools/rocm_smi_tool/rocm_smi_sanity.py?token=AB7ZUFTHXMOIUH3LO3X4MUC5HGK42 -O rocm_smi_sanity.py
wget https://raw.githubusercontent.com/RadeonOpenCompute/MLSEQA_TestRepo/master/ROCM_Tools/rocm_smi_tool/rocm_smi_system_info.py?token=AB7ZUFWUL5IWDR6A4HWDNY25HGK64 -O rocm_smi_system_info.py
wget https://raw.githubusercontent.com/RadeonOpenCompute/MLSEQA_TestRepo/master/ROCM_Tools/rocm_smi_tool/rocm_smi_workload_tests.py?token=AB7ZUFQ3H3A5FJFDLGKEGKC5HGLBS -O rocm_smi_workload_tests.py


#cd /opt/rocm/bin
#python rocm_smi.py 2>&1 | tee -a ~/dockerx/rocm_smi.log
#cd $HOME/
#git clone https://streamhsa:AH64_uh1@github.com/RadeonOpenCompute/MLSEQA_TestRepo
#cd $HOME/MLSEQA_TestRepo/ROCM_Tools/rocm_smi_tool
echo AH64_uh1 | sudo -S python rocm_smi_sanity.py
mv Results.ini rocm_smi_sanity.log
mv rocm_smi_sanity.log ~/dockerx/
#sudo python rocm_smi_test.py
#mv Results.ini rocm_smi_test.log
#mv rocm_smi_test.log ~/dockerx/
echo AH64_uh1 | sudo -S python rocm_smi_workload_tests.py
mv Results.ini rocm_smi_workloads.log
mv rocm_smi_workloads.log ~/dockerx/
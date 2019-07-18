cd ~/dockerx/
rm -rf rocm_smi_tool

mkdir -p ~/dockerx/rocm_smi_tool && chmod 777 -R rocm_smi_tool && cd ~/dockerx/rocm_smi_tool

wget https://raw.githubusercontent.com/RadeonOpenCompute/MLSEQA_TestRepo/master/ROCM_Tools/rocm_smi_tool/rocm_smi_common.py?token=AB7ZUFXBZ3MX6PPFH4AWVW25HGJNM -O rocm_smi_common.py
wget https://raw.githubusercontent.com/RadeonOpenCompute/MLSEQA_TestRepo/master/ROCM_Tools/rocm_smi_tool/rocm_smi_sanity.py?token=AB7ZUFTHXMOIUH3LO3X4MUC5HGK42 -O rocm_smi_sanity.py
wget https://raw.githubusercontent.com/RadeonOpenCompute/MLSEQA_TestRepo/master/ROCM_Tools/rocm_smi_tool/rocm_smi_system_info.py?token=AB7ZUFWUL5IWDR6A4HWDNY25HGK64 -O rocm_smi_system_info.py
wget https://raw.githubusercontent.com/RadeonOpenCompute/MLSEQA_TestRepo/master/ROCM_Tools/rocm_smi_tool/rocm_smi_workload_tests.py?token=AB7ZUFQ3H3A5FJFDLGKEGKC5HGLBS -O rocm_smi_workload_tests.py

echo AH64_uh1 | sudo -S python3 rocm_smi_sanity.py
mv Results.ini rocm_smi_sanity.log
mv rocm_smi_sanity.log ~/dockerx/

echo AH64_uh1 | sudo -S python3 rocm_smi_workload_tests.py
mv Results.ini rocm_smi_workloads.log
mv rocm_smi_workloads.log ~/dockerx/
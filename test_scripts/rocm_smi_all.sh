cd ~/dockerx/
echo AH64_uh1 | sudo -S rm -rf rocm_smi_tool

mkdir -p ~/dockerx/rocm_smi_tool && chmod 777 -R rocm_smi_tool && cd ~/dockerx/rocm_smi_tool

wget https://raw.githubusercontent.com/RadeonOpenCompute/MLSEQA_TestRepo/master/ROCM_Tools/rocm_smi_tool/rocm_smi_common.py?token=AB7ZUFUDFAMZVCOMZCAPYBC5JVHWU -O rocm_smi_common.py
wget https://raw.githubusercontent.com/RadeonOpenCompute/MLSEQA_TestRepo/master/ROCM_Tools/rocm_smi_tool/rocm_smi_sanity.py?token=AB7ZUFXZIGQZB6ROFFDO6NK5JVHW4 -O rocm_smi_sanity.py
wget https://raw.githubusercontent.com/RadeonOpenCompute/MLSEQA_TestRepo/master/ROCM_Tools/rocm_smi_tool/rocm_smi_system_info.py?token=AB7ZUFX6ZMGUJ7Q3B7EA5DC5JVHXG -O rocm_smi_system_info.py
wget https://raw.githubusercontent.com/RadeonOpenCompute/MLSEQA_TestRepo/master/ROCM_Tools/rocm_smi_tool/rocm_smi_workload_tests.py?token=AB7ZUFUWFYU6BCF45CG47BK5JVHXS -O rocm_smi_workload_tests.py

echo AH64_uh1 | sudo -S python3 rocm_smi_sanity.py
cp rocm_smi_sanity.summary ~/dockerx/

echo AH64_uh1 | sudo -S python3 rocm_smi_workload_tests.py
cp rocm_smi_workloads.summary ~/dockerx/
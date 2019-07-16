cd /opt/rocm/bin
python rocm_smi.py 2>&1 | tee -a ~/dockerx/rocm_smi.log
cd $HOME/
git clone https://streamhsa:AH64_uh1@github.com/RadeonOpenCompute/MLSEQA_TestRepo
cd $HOME/MLSEQA_TestRepo/ROCM_Tools/rocm_smi_tool
sudo python rocm_smi_sanity.py
mv Results.ini rocm_smi_sanity.log
mv rocm_smi_sanity.log ~/dockerx/
sudo python rocm_smi_test.py
mv Results.ini rocm_smi_test.log
mv rocm_smi_test.log ~/dockerx/
sudo python rocm_smi_workload_tests.py
mv Results.ini rocm_smi_workloads.log
mv rocm_smi_workloads.log ~/dockerx/
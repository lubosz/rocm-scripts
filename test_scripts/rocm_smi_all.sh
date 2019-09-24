#!/bin/bash

logs=~/dockerx/

################ Update Git Repo in ~/dockerx/MLSEQA_TestRepo/ #######################

rm -rf $logs/ROCM_Tools/

cd ~/dockerx/MLSEQA_TestRepo/

git stash

git pull https://streamhsa:AH64_uh1@github.com//RadeonOpenCompute/MLSEQA_TestRepo

cp -rf ROCM_Tools $logs

cd $logs/ROCM_Tools/

chmod 777 -R *

################ start rocm_smi_lib_test #######################

cd $logs/ROCM_Tools/rocm_smi_lib_test

sudo python smi_lib_app_test.py

cp -rf smi_lib_app_test.summary $logs
cp -rf smi_lib_app_test_github_func.log $logs
cp -rf smi_lib_app_test_unit.log $logs
cp -rf smi_lib_app_test_stress.log $logs

################ start rocprofiler #######################

cd $logs/ROCM_Tools/rocprofiler

sudo python3 rocprofiler_tests.py

cp -rf rocprofiler_tests.summary $logs
cp -rf rocprofiler_tests.log $logs

################ start rocm_smi_sanity #######################

cd $logs/ROCM_Tools/rocm_smi_tool

sudo python3 rocm_smi_sanity.py

cp -rf rocm_smi_sanity.summary $logs
cp -rf rocm_smi_sanity.log $logs

################ start rocm_smi_workload_tests #######################

cd $logs/ROCM_Tools/rocm_smi_tool

sudo python3 rocm_smi_workload_tests.py

cp -rf rocm_smi_workload_tests.summary $logs
cp -rf rocm_smi_workload_tests.log $logs

cd $logs

echo '################### rocm_smi_workload_tests ##########################'
cat rocm_smi_workload_tests.summary

echo '################### rocm_smi_sanity ##########################'
cat rocm_smi_sanity.summary

echo '################### rocprofiler_tests ##########################'
cat rocprofiler_tests.summary

echo '################### smi_lib_app_test ##########################'
cat smi_lib_app_test.summary
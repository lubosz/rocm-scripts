mkdir -p ~/dockerx/ocltst/

cd ~/Desktop/package/bin/ocltst

export LD_LIBRARY_PATH=.

./ocltst -m oclregression.so -A oclregression.exclude 2>&1 | tee -a ~/dockerx/ocltst/oclregression.log
./ocltst -m ocldebugger.so -A ocldebugger.exclude 2>&1 | tee -a ~/dockerx/ocltst/ocldebugger.log
./ocltst -m oclmediafunc.so -A oclmediafunc.exclude 2>&1 | tee -a ~/dockerx/ocltst/oclmediafunc.log
./ocltst -m oclprofiler.so -A oclprofiler.exclude 2>&1 | tee -a ~/dockerx/ocltst/oclprofiler.log
./ocltst -m oclcompiler.so -A oclcompiler.exclude 2>&1 | tee -a ~/dockerx/ocltst/oclcompiler.log
./ocltst -m oclgl.so -A oclgl.exclude 2>&1 | tee -a ~/dockerx/ocltst/oclgl.log
./ocltst -m oclperf.so -A oclperf.exclude 2>&1 | tee -a ~/dockerx/ocltst/oclperf.log
./ocltst -m oclruntime.so -A oclruntime.exclude 2>&1 | tee -a ~/dockerx/ocltst/oclruntime.log


cd ~/dockerx/ocltst

grep -nir "Total Passed Tests:" *.log

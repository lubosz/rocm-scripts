cd ~/Desktop/

mkdir results

mkdir ~/Desktop/results/$(date +%d%m%Y)

cd ~/Desktop/package/bin/ocltst

export LD_LIBRARY_PATH=.

./ocltst -m oclregression.so -A oclregression.exclude 2>&1 | tee -a ~/Desktop/results/$(date +%d%m%Y)/oclregression.log
./ocltst -m ocldebugger.so -A ocldebugger.exclude 2>&1 | tee -a ~/Desktop/results/$(date +%d%m%Y)/ocldebugger.log
./ocltst -m oclmediafunc.so -A oclmediafunc.exclude 2>&1 | tee -a ~/Desktop/results/$(date +%d%m%Y)/oclmediafunc.log
./ocltst -m oclprofiler.so -A oclprofiler.exclude 2>&1 | tee -a ~/Desktop/results/$(date +%d%m%Y)/oclprofiler.log
./ocltst -m oclcompiler.so -A oclcompiler.exclude 2>&1 | tee -a ~/Desktop/results/$(date +%d%m%Y)/oclcompiler.log
./ocltst -m oclgl.so -A oclgl.exclude 2>&1 | tee -a ~/Desktop/results/$(date +%d%m%Y)/oclgl.log
./ocltst -m oclperf.so -A oclperf.exclude 2>&1 | tee -a ~/Desktop/results/$(date +%d%m%Y)/oclperf.log
./ocltst -m oclruntime.so -A oclruntime.exclude 2>&1 | tee -a ~/Desktop/results/$(date +%d%m%Y)/oclruntime.log


cd ~/Desktop/results/$(date +%d%m%Y)

grep -nir "Total Passed Tests:" *.log
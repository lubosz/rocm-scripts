mkdir ~/Desktop/results/$(date +%d%m%Y)

cd ~/Desktop/package/bin/ocltst

export LD_LIBRARY_PATH=.

./ocltst -m oclregression.so -A oclregression.exclude >> ~/Desktop/results/$(date +%d%m%Y)/oclregression.log
./ocltst -m oclruntime.so -A oclruntime.exclude >> ~/Desktop/results/$(date +%d%m%Y)/oclruntime.log
./ocltst -m ocldebugger.so -A ocldebugger.exclude >> ~/Desktop/results/$(date +%d%m%Y)/ocldebugger.log
./ocltst -m oclmediafunc.so -A oclmediafunc.exclude >> ~/Desktop/results/$(date +%d%m%Y)/oclmediafunc.log
./ocltst -m oclprofiler.so -A oclprofiler.exclude >> ~/Desktop/results/$(date +%d%m%Y)/oclprofiler.log
./ocltst -m oclcompiler.so -A oclcompiler.exclude >> ~/Desktop/results/$(date +%d%m%Y)/oclcompiler.log
./ocltst -m oclgl.so -A oclgl.exclude >> ~/Desktop/results/$(date +%d%m%Y)/oclgl.log
./ocltst -m oclperf.so -A oclperf.exclude >> ~/Desktop/results/$(date +%d%m%Y)/oclperf.log
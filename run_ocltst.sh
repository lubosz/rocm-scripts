mkdir ~/Desktop/results/$(date +%d%m%Y)

cd ~/Desktop/package/bin/ocltst

export LD_LIBRARY_PATH=.

./ocltst -m oclregression.so -A oclregression.exclude >> ~/Desktop/results/oclregression.log
./ocltst -m oclruntime.so -A oclruntime.exclude >> ~/Desktop/results/oclruntime.log
./ocltst -m ocldebugger.so -A ocldebugger.exclude >> ~/Desktop/results/ocldebugger.log
./ocltst -m oclmediafunc.so -A oclmediafunc.exclude >> ~/Desktop/results/oclmediafunc.log
./ocltst -m oclprofiler.so -A oclprofiler.exclude >> ~/Desktop/results/oclprofiler.log
./ocltst -m oclcompiler.so -A oclcompiler.exclude >> ~/Desktop/results/oclcompiler.log
./ocltst -m oclgl.so -A oclgl.exclude >> ~/Desktop/results/oclgl.log
./ocltst -m oclperf.so -A oclperf.exclude >> ~/Desktop/results/oclperf.log
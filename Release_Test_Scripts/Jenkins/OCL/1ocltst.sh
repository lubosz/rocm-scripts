cd ~/Desktop/DTB/bin/ocltst
export LD_LIBRARY_PATH=$PWD
#./ocltst -m oclruntime.so -A oclruntime.exclude >> ~/Desktop/logs/1oclruntime.log 2>&1
./ocltst -m oclregression.so -A oclregression.exclude >> ~/Desktop/logs/1oclregression.log 2>&1
./ocltst -m oclcompiler.so -A oclcompiler.exclude >> ~/Desktop/logs/1oclcompiler.log 2>&1
./ocltst -m oclprofiler.so -A oclprofiler.exclude >> ~/Desktop/logs/1oclprofiler.log 2>&1
./ocltst -m ocldebugger.so -A ocldebugger.exclude >> ~/Desktop/logs/1ocldebugger.log 2>&1
./ocltst -m oclfrontend.so -A oclfrontend.exclude >> ~/Desktop/logs/1oclfrontend.log 2>&1
./ocltst -m oclmediafunc.so -A oclmediafunc.exclude >> ~/Desktop/logs/1oclmediafunc.log 2>&1
./ocltst -m oclperf.so -A oclperf.exclude >> ~/Desktop/logs/1oclperf.log 2>&1




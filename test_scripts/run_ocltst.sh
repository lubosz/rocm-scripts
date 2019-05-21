chmod -R 777 ~/dockerx/
LOGDIR=~/dockerx/

cd ~/Desktop/
mkdir BUILD


build=10534
cd ~/Desktop/BUILD/$build/bin/ocltst

export LD_LIBRARY_PATH=.

./ocltst -m oclregression.so -A oclregression.exclude 2>&1 | tee -a $LOGDIR/oclregression_$build.log
./ocltst -m oclmediafunc.so -A oclmediafunc.exclude 2>&1 | tee -a $LOGDIR/oclmediafunc_$build.log
./ocltst -m oclprofiler.so -A oclprofiler.exclude 2>&1 | tee -a $LOGDIR/oclprofiler_$build.log
./ocltst -m oclcompiler.so -A oclcompiler.exclude 2>&1 | tee -a $LOGDIR/oclcompiler_$build.log
./ocltst -m oclperf.so -A oclperf.exclude 2>&1 | tee -a $LOGDIR/oclperf_$build.log
./ocltst -m oclruntime.so -A oclruntime.exclude 2>&1 | tee -a $LOGDIR/oclruntime_$build.log


cd $LOGDIR/ 

grep -nir "Total Passed Tests:" ocl*.log

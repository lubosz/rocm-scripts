## Created by    : Sushant Kumar
## Creation Date : 13/05/2019
## Description   : Script is for building rccl

#!/bin/sh
cwd=`pwd`
STEPS_COUNT=36
LIBPATH="/opt/rocm/rccl/"
TEST=/root/driver/RCCL/build/rccl-tests
nGPU="$(/opt/rocm/bin/rocminfo | grep GPU | wc -l)"
OP=( sum prod min max )
DATA=( int8 uint8 int32 uint32 int64 uint64 half float double )
cd $TEST

echo "[STEPS]" > Results.ini
echo "Number=$STEPS_COUNT" >> Results.ini
echo " " >> Results.ini

declare -i var=1

for i in ${OP[@]}
do
for j in ${DATA[@]}
do
echo "******** $i with $j *********" > tmp.log
HSA_FORCE_FINE_GRAIN_PCIE=1 NCCL_DEBUG=INFO ./build/all_reduce_perf -b 64 -e 128M -f 4 -g $nGPU -o $i -d $j >> tmp.log 2>&1
grep "bandwidth" tmp.log >> tmp1.log
cat tmp.log >> all_reduce_perf.log
while read line
do [ -z "$line" ] && continue ;
bandwidth=${line##* }
done < tmp1.log

echo " " >> Results.ini
echo "[STEP_00$var]" >> Results.ini
if [ $bandwidth != 0 ]; then
    echo "Description= $i with $j bandwidth is $bandwidth" >> Results.ini
    echo "Status=Passed" >> Results.ini
else
    echo "Description= Test failed.Refer RCCL-build.log" >> Results.ini
    echo "Status=Failed" >> Results.ini
fi
var=var+1
done
done

mv Results.ini all_reduce_perf.log $cwd
cd $cwd

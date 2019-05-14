## Created by :  
## Creation Date: 
## Description: Script is for make and run of bwtest test
## Modifications: 

#!/bin/sh

current=`pwd`

if [ -e "$current/bwtest" ] ; then
	make clean
	echo "=========================[Building hipbwtest Test]=========================" | tee bwtest.log
	make | tee -a bwtest.log
else
	echo "=========================[Building hipbwtest Test]=========================" | tee bwtest.log
	make | tee -a bwtest.log
fi

if [ -e "$current/bwtest" ] ; then
   echo "[STEPS]" > Results.ini
   echo "Number=2" >> Results.ini
   echo " " >> Results.ini
   echo "[STEP_001]" >> Results.ini
   echo "Description=bwtest built successfully" >> Results.ini
   echo "Status=Passed" >> Results.ini
else
   echo "[STEPS]" > Results.ini
   echo "Number=1" >> Results.ini
   echo " " >> Results.ini
   echo "[STEP_001]" >> Results.ini
   echo "Description=bwtest building Failed" >> Results.ini
   echo "Status=Failed" >> Results.ini
   exit 1
fi

echo " " | tee -a bwtest.log
echo "=========================[Running hipbwtest Test]=========================" | tee -a bwtest.log
./bwtest | tee -a bwtest.log


RUN_PATT1='Aborted'
RUN_PATT2='Segmentation'
RUN_PATT3='FAILED'


RUN_LOG='bwtest.log'

if [ -s $RUN_LOG ] ; then
 if grep -qiE "$RUN_PATT1|$RUN_PATT2|$RUN_PATT3" $RUN_LOG;
then
   echo " " >> Results.ini
   echo "[STEP_002]" >> Results.ini
   echo "Description=bwtest Failed" >> Results.ini
   echo "Status=Failed" >> Results.ini
 else
   echo " " >> Results.ini
   echo "[STEP_002]" >> Results.ini
   echo "Description=bwtest passed" >> Results.ini
   echo "Status=Passed" >> Results.ini
   
 fi
fi



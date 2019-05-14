##Created by :  
## Creation Date: 
## Description: Script is for make and run of fullduplex test
## Modifications: 

#!/bin/sh

current=`pwd`

if [ -e "$current/fullduplex" ] ; then
	make clean
	echo "=========================[Building hipFullDuplex Test]=========================" | tee fullduplex.log
	make | tee -a fullduplex.log
else
	echo "=========================[Building hipFullDuplex Test]=========================" | tee fullduplex.log
	make | tee -a fullduplex.log
fi

if [ -e "$current/fullduplex" ] ; then
   echo "[STEPS]" > Results.ini
   echo "Number=2" >> Results.ini
   echo " " >> Results.ini
   echo "[STEP_001]" >> Results.ini
   echo "Description=fullduplex built successfully" >> Results.ini
   echo "Status=Passed" >> Results.ini
else
   echo "[STEPS]" > Results.ini
   echo "Number=1" >> Results.ini
   echo " " >> Results.ini
   echo "[STEP_001]" >> Results.ini
   echo "Description=fullduplex building Failed" >> Results.ini
   echo "Status=Failed" >> Results.ini
   exit 1
fi

echo " " | tee -a fullduplex.log
echo "=========================[Running hipFullDuplex Test]=========================" | tee -a fullduplex.log
./fullduplex | tee -a fullduplex.log


RUN_PATT1='Aborted'
RUN_PATT2='Segmentation'
RUN_PATT3='FAILED'


RUN_LOG='fullduplex.log'

if [ -s $RUN_LOG ] ; then
 if grep -qiE "$RUN_PATT1|$RUN_PATT2|$RUN_PATT3" $RUN_LOG;
then
   echo " " >> Results.ini
   echo "[STEP_002]" >> Results.ini
   echo "Description=fullduplex Failed" >> Results.ini
   echo "Status=Failed" >> Results.ini
 else
   echo " " >> Results.ini
   echo "[STEP_002]" >> Results.ini
   echo "Description=fullduplex passed" >> Results.ini
   echo "Status=Passed" >> Results.ini
   
 fi
fi



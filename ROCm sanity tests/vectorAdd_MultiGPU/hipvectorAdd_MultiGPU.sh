## Created by :  
## Creation Date: 
## Description: Script is for make and run of vectorAdd_MultiGPU test
## Modifications: 

#!/bin/sh

current=`pwd`

if [ -e "$current/vectorAdd_MultiGPU" ] ; then
	make clean
	echo "=========================[Building hipvectorAdd_MultiGPU Test]=========================" | tee vectorAdd_MultiGPU.log
	make | tee -a vectorAdd_MultiGPU.log
else
	echo "=========================[Building hipvectorAdd_MultiGPU Test]=========================" | tee vectorAdd_MultiGPU.log
	make | tee -a vectorAdd_MultiGPU.log
fi

if [ -e "$current/vectorAdd_MultiGPU" ] ; then
   echo "[STEPS]" > Results.ini
   echo "Number=2" >> Results.ini
   echo " " >> Results.ini
   echo "[STEP_001]" >> Results.ini
   echo "Description=vectorAdd_MultiGPU built successfully" >> Results.ini
   echo "Status=Passed" >> Results.ini
else
   echo "[STEPS]" > Results.ini
   echo "Number=1" >> Results.ini
   echo " " >> Results.ini
   echo "[STEP_001]" >> Results.ini
   echo "Description=vectorAdd_MultiGPU building Failed" >> Results.ini
   echo "Status=Failed" >> Results.ini
   exit 1
fi

echo " " | tee -a vectorAdd_MultiGPU.log
echo "=========================[Running hipvectorAdd_MultiGPU Test]=========================" | tee -a vectorAdd_MultiGPU.log
./vectorAdd_MultiGPU | tee -a vectorAdd_MultiGPU.log


RUN_PATT1='Aborted'
RUN_PATT2='Segmentation'
#RUN_PATT3='FAILED'


RUN_LOG='vectorAdd_MultiGPU.log'

if [ -s $RUN_LOG ] ; then
 if grep -qiE "$RUN_PATT1|$RUN_PATT2" $RUN_LOG;
then
   echo " " >> Results.ini
   echo "[STEP_002]" >> Results.ini
   echo "Description=vectorAdd_MultiGPU Failed" >> Results.ini
   echo "Status=Failed" >> Results.ini
 else
   echo " " >> Results.ini
   echo "[STEP_002]" >> Results.ini
   echo "Description=vectorAdd_MultiGPU passed" >> Results.ini
   echo "Status=Passed" >> Results.ini
   
 fi
fi



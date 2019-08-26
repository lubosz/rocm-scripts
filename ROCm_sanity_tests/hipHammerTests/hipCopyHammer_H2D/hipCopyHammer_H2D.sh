##Created by :  
## Creation Date: 
## Description: Script is for make and run of hipCopyHammer_d0hD1 test
## Modifications: 

#!/bin/sh

current=`pwd`

if [ -e "$current/hipCopyHammer_H2D" ] ; then
	make clean
	make | tee hipCopyHammer_H2D_build.log
else
	make | tee hipCopyHammer_H2D_build.log
fi

if [ -e "$current/hipCopyHammer_H2D" ] ; then
   echo "[STEPS]" > Results.ini
   echo "Number=2" >> Results.ini
   echo " " >> Results.ini
   echo "[STEP_001]" >> Results.ini
   echo "Description=hipCopyHammer_H2D built successfully" >> Results.ini
   echo "Status=Passed" >> Results.ini
else
   echo "[STEPS]" > Results.ini
   echo "Number=1" >> Results.ini
   echo " " >> Results.ini
   echo "[STEP_001]" >> Results.ini
   echo "Description=hipCopyHammer_H2D building Failed" >> Results.ini
   echo "Status=Failed" >> Results.ini
   exit 1
fi

./hipCopyHammer_H2D | tee -a /dockerx/hipCopyHammer_H2D_run.log


RUN_PATT1='Aborted'
RUN_PATT2='Segmentation'
RUN_PATT3='FAILED'

RUN_LOG='hipCopyHammer_H2D_run.log'

if [ -s $RUN_LOG ] ; then
 if grep -qiE "$RUN_PATT1|$RUN_PATT2|$RUN_PATT3" $RUN_LOG;
then
   echo " " >> Results.ini
   echo "[STEP_002]" >> Results.ini
   echo "Description=hipCopyHammer_H2D Failed" >> Results.ini
   echo "Status=Failed" >> Results.ini
 else
   echo " " >> Results.ini
   echo "[STEP_002]" >> Results.ini
   echo "Description=hipCopyHammer_H2D passed" >> Results.ini
   echo "Status=Passed" >> Results.ini
   
 fi
fi


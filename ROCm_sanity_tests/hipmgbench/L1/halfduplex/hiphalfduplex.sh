##Created by :  
## Creation Date: 
## Description: Script is for make and run of halfduplex test
## Modifications: 

#!/bin/sh

current=`pwd`

if [ -e "$current/halfduplex" ] ; then
	make clean
	echo "=========================[Building hiphalfDuplex Test]=========================" | tee halfduplex.log
	make | tee -a halfduplex.log
else
	echo "=========================[Building hiphalfDuplex Test]=========================" | tee halfduplex.log
	make | tee -a halfduplex.log
fi

if [ -e "$current/halfduplex" ] ; then
   echo "[STEPS]" > Results.ini
   echo "Number=2" >> Results.ini
   echo " " >> Results.ini
   echo "[STEP_001]" >> Results.ini
   echo "Description=halfduplex built successfully" >> Results.ini
   echo "Status=Passed" >> Results.ini
else
   echo "[STEPS]" > Results.ini
   echo "Number=1" >> Results.ini
   echo " " >> Results.ini
   echo "[STEP_001]" >> Results.ini
   echo "Description=halfduplex building Failed" >> Results.ini
   echo "Status=Failed" >> Results.ini
   exit 1
fi

echo " " | tee -a halfduplex.log
echo "=========================[Running hiphalfDuplex Test]=========================" | tee -a halfduplex.log
./halfduplex | tee -a /dockerx/halfduplex.log


RUN_PATT1='Aborted'
RUN_PATT2='Segmentation'
RUN_PATT3='FAILED'


RUN_LOG='halfduplex.log'

if [ -s $RUN_LOG ] ; then
 if grep -qiE "$RUN_PATT1|$RUN_PATT2|$RUN_PATT3" $RUN_LOG;
then
   echo " " >> Results.ini
   echo "[STEP_002]" >> Results.ini
   echo "Description=halfduplex Failed" >> Results.ini
   echo "Status=Failed" >> Results.ini
 else
   echo " " >> Results.ini
   echo "[STEP_002]" >> Results.ini
   echo "Description=halfduplex passed" >> Results.ini
   echo "Status=Passed" >> Results.ini
   
 fi
fi



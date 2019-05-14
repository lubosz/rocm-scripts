#Created by :  
## Creation Date: 
## Description: Script is for make and run of uva test
## Modifications: 

#!/bin/sh

current=`pwd`

if [ -e "$current/uva" ] ; then
	make clean
	echo "=========================[Building hipuva Test]=========================" | tee uva.log
	make | tee -a uva.log
else
	echo "=========================[Building hipuva Test]=========================" | tee uva.log
	make | tee -a uva.log
fi

if [ -e "$current/uva" ] ; then
   echo "[STEPS]" > Results.ini
   echo "Number=2" >> Results.ini
   echo " " >> Results.ini
   echo "[STEP_001]" >> Results.ini
   echo "Description=uva built successfully" >> Results.ini
   echo "Status=Passed" >> Results.ini
else
   echo "[STEPS]" > Results.ini
   echo "Number=1" >> Results.ini
   echo " " >> Results.ini
   echo "[STEP_001]" >> Results.ini
   echo "Description=uva building Failed" >> Results.ini
   echo "Status=Failed" >> Results.ini
   exit 1
fi

echo " " | tee -a uva.log
echo "=========================[Running Half-duplex DMA Read]=========================" | tee -a uva.log
./uva | tee -a uva.log

echo " " >> uva.log
echo "=========================[Running full-duplex DMA Read]=========================" | tee -a uva.log
./uva --fullduplex | tee -a uva.log

echo " " | tee -a uva.log
echo "=========================[Running Half-duplex DMA Write]=========================" | tee -a uva.log
./uva --write | tee -a uva.log

echo " " | tee -a uva.log
echo "=========================[Running full-duplex DMA Write]=========================" | tee -a uva.log
./uva --write --fullduplex | tee -a uva.log


RUN_PATT1='Aborted'
RUN_PATT2='Segmentation'
RUN_PATT3='FAILED'


RUN_LOG='uva.log'

if [ -s $RUN_LOG ] ; then
 if grep -qiE "$RUN_PATT1|$RUN_PATT2|$RUN_PATT3" $RUN_LOG;
then
   echo " " >> Results.ini
   echo "[STEP_002]" >> Results.ini
   echo "Description=uva Failed" >> Results.ini
   echo "Status=Failed" >> Results.ini
 else
   echo " " >> Results.ini
   echo "[STEP_002]" >> Results.ini
   echo "Description=uva passed" >> Results.ini
   echo "Status=Passed" >> Results.ini
   
 fi
fi



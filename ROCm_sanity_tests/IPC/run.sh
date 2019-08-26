#!/bin/sh

##Created by :  Sushant Kumar
## Creation Date: 29/12/2016
## Description: to test IPC test, Test is applicable for mGPUs only.
## Modifications: None

current=`pwd`
./ipc_test.sh > out.log 2>&1

rm -rf Results.ini

echo "[STEPS]" > Results.ini
echo "Number=1" >> Results.ini 

PATTERN1='Passed.'
FILE='out.log'

echo " " >> Results.ini
echo "[STEP_001]" >> Results.ini
echo "Description= IPC tests run completed" >> Results.ini

if [ -s $FILE ] ; then
 if grep -qiE "$PATTERN1" $FILE;
 then 
   echo "Status=Passed" >> Results.ini
 else
   echo "Status=Failed" >> Results.ini
 fi
fi

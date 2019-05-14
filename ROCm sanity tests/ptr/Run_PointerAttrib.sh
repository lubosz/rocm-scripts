#!/bin/sh

# This test is only for dGPUs.

current=`pwd`

echo fpadmin | sudo -S chmod 777 * -R

./PtrInfo | tee ptrinfo.txt


rm -rf Results.ini

echo "[STEPS]" > Results.ini
echo "Number=1" >> Results.ini 

PATTERN1='Aborted'
PATTERN2='Segmentation'
PATTERN3='FAILED'
FILE='ptrinfo.txt'

echo " " >> Results.ini
echo "[STEP_001]" >> Results.ini
echo "Description= Pointer Attributes tests run completed" >> Results.ini

if [ -s $FILE ] ; then
 if grep -qiE "$PATTERN1|$PATTERN2|$PATTERN3" $FILE;
 then 
   echo "Status=Failed" >> Results.ini
 else
   echo "Status=Passed" >> Results.ini
 fi
fi


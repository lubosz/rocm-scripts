#!/bin/bash

./alexnet-flower_ngpu.sh $ngpu

./tf-fp16-ngpu.sh $ngpu

./tf_tests-ngpu.sh $ngpu


#!/bin/bash

./basic-check.sh

./run_hip-docker.sh

./alexnet-flower_1gpu.sh

./tf_tests-1gpu.sh

./tf-fp16-1gpu.sh

./run_mathlibs-docker.sh

./run_frameworks-docker.sh
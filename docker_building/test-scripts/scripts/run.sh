#!/bin/bash
./run_hip-docker.sh
./run_mathlibs-docker.sh
./run_frameworks-docker.sh
./tf_tests-python3.sh
./alexnet-flower.sh

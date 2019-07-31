#!/bin/bash

cd /dockerx/

timeout 1s tail -f *.log 2>&1 | tee -a /dockerx/full_summary.log
cd ~/Desktop/Tests/OCL/Luxmark
echo "Simple scene" >> ~/Desktop/logs/luxmark.log 2>&1
./luxmark --scene=LUXBALL_HDR --mode=BENCHMARK_OCL_GPU --single-run --ext-info >> ~/Desktop/logs/luxmark.log 2>&1
echo "Medium scene" >> ~/Desktop/logs/luxmark.log 2>&1
./luxmark --scene=MICROPHONE --mode=BENCHMARK_OCL_GPU --single-run --ext-info >> ~/Desktop/logs/luxmark.log 2>&1
echo "Complex scene" >> ~/Desktop/logs/luxmark.log 2>&1
./luxmark --scene=HOTEL --mode=BENCHMARK_OCL_GPU --single-run --ext-info >> ~/Desktop/logs/luxmark.log 2>&1

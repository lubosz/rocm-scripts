cd ~/Desktop/Tests/OCL/KFFT
./kfftbench -v 1 -t gpu -i 10000 -a  > ~/Desktop/logs/kfft.log 2>&1
./kfftbench -v 2 -t gpu -i 10000 -a  > ~/Desktop/logs/kfft.log 2>&1
./kfftbench -v 3 -t gpu -i 10000 -a  > ~/Desktop/logs/kfft.log 2>&1

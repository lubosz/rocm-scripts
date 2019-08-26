cd ~/Desktop/DTB/bin/rocrtst_samples/gfx906
export LD_LIBRARY_PATH=/home/taccuser/Desktop/DTB/lib
./async_mem_copy 2>&1 | tee ~/Desktop/logs/3rocr_samples.log
./binary_search 2>&1 | tee ~/Desktop/logs/3rocr_samples.log
./ipc 2>&1 | tee ~/Desktop/logs/3rocr_samples.log
./rocrinfo 2>&1 | tee ~/Desktop/logs/3rocr_samples.log

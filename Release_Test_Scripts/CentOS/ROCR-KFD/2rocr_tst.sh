cd ~/Desktop/DTB/bin/rocrtst_tests/gfx906
export LD_LIBRARY_PATH=/home/taccuser/Desktop/DTB/lib
./rocrtst64 2>&1 | tee ~/Desktop/logs/2rocrtst.log

cd ~/Desktop/rocm/workloads/mathlibs/rocfft

echo AH64_uh1 | sudo -S apt-get -y --force-yes install cmake cmake-qt-gui cmake-curses-gui python-yaml libblas-dev liblapack-dev libboost-all-dev

echo AH64_uh1 | sudo -S rm -rf build
echo AH64_uh1 | sudo -S ./install.sh -cd >> ~/Desktop/logs/6rocfft_build.log 2>&1
export LD_LIBRARY_PATH=/opt/rocm/rocfft/lib:$LD_LIBRARY_PATH

cd build/release/clients/staging
#./rocfft-rider  >> ~/Desktop/logs/6rocfft_rocfft-rider.log 2>&1
./rocfft-test  >> ~/Desktop/logs/6rocfft_unittest.log 2>&1

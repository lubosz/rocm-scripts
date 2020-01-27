cd ~/Desktop/rocm/workloads/mathlibs/rocsparse

echo AH64_uh1 | sudo -S apt-get -y --force-yes install cmake cmake-qt-gui cmake-curses-gui python-yaml libblas-dev liblapack-dev libboost-all-dev

echo AH64_uh1 | sudo -S rm -rf build
echo AH64_uh1 | sudo -S ./install.sh -cd >> ~/Desktop/logs/8rocsparse_build.log 2>&1

cd build/release/clients/staging
./rocsparse-test >> ~/Desktop/logs/8rocsparse_unittest.log 2>&1



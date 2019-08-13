cd ~/Desktop/rocm/workloads/mathlibs/rocalution

echo AH64_uh1 | sudo -S apt-get -y --force-yes install cmake cmake-qt-gui cmake-curses-gui python-yaml libblas-dev liblapack-dev libboost-all-dev

echo AH64_uh1 | sudo -S rm -rf build
echo AH64_uh1 | sudo -S ./install.sh -cd | tee -a ~/dockerx/10rocalution_build.log 2>&1

cd build/release/clients/staging
./rocalution-test | tee -a ~/dockerx/10rocalution_unittest.log 2>&1



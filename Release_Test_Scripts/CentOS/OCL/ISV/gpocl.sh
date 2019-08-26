echo AH64_uh1 | sudo -S rm -rf /tmp/*
cd ~/Desktop/Tests/OCL/GPOCL
chmod +x * -R

echo "===========Test Started=========="
cd build

./gpocl -v ../datasets/3-* -gpu ppcu > ~/Desktop/logs/gpocl.log 2>&1

echo "===========Test ended=========="


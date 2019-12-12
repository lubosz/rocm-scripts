cd ~/Desktop/Tests/OCL/Blender/blender-2.78c-linux-glibc219-x86_64
export CYCLES_OPENCL_TEST=0
echo AH64_uh1 | sudo -S rm -rf /tmp/* ~/.config/blender/2.78/cache/*
./blender >> ~/Desktop/logs/blender.log 2>&1

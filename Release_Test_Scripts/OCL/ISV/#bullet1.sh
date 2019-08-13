cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/Bullet/bullet3-15042016/bin
echo AH64_uh1 | sudo -S rm -rf /tmp/* 
echo AH64_uh1 | sudo -S rm -rf cache
./App_BulletExampleBrowser_gmake_x64_release --enable_experimental_opencl --start_demo_name=Box-Box

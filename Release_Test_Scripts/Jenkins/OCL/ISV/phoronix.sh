cd ~/Desktop/OpenCL_LC/opencl/lib/x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD

cd ~/Desktop/Tests/OCL/ISV/Phoronix/JuliaGPU
./install.sh
cd JuliaGPU-v1.2pts
./juliaGPU 0 1 rendering_kernel.cl 1920 1080 >> ~/Desktop/logs/Phoronix_JuliaGPU.log 2>&1

cd ~/Desktop/Tests/OCL/ISV/Phoronix/MandelbulbGPU
./install.sh
cd mandelbulbGPU-v1.0pts
./mandelbulbGPU 0 1 rendering_kernel.cl 1920 1080 >> ~/Desktop/logs/Phoronix_MandelbulbGPU.log 2>&1


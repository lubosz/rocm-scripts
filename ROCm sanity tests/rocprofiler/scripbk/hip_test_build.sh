cd  /opt/rocm/hip/samples/0_Intro/bit_extract 
sudo make 
if [ ! -d "/mnt/ROCm-TestApps/rocprofiler" ]; then
    mount  -t cifs -o username=taccuser,password="AH64_uh1" //hydinstreamcqe1/hsa /mnt
fi
sudo cp -rf /mnt/ROCm-TestApps/rocprofiler/input.xml ~/Desktop/rocprofiler/


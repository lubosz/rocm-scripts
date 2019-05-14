#Dependencies : [MYHIP]/bin must be in user's path.

HIP_PATH?= $(wildcard /opt/rocm/hip)
ifeq (,$(HIP_PATH))
	HIP_PATH=../../..
endif
HIP_PLATFORM=$(shell $(HIP_PATH)/bin/hipconfig --platform)
HIPCC=$(HIP_PATH)/bin/hipcc

# Show how to use PLATFORM to specify different options for each compiler:
ifeq (${HIP_PLATFORM}, nvcc)
	HIPCC_FLAGS = -gencode=arch=compute_20,code=sm_20 
endif

EXE = fullduplex

$(EXE): fullduplex.cpp
	$(HIPCC) -I/opt/rocm/hip/include/hip -I/usr/include/gflags -I/home/fpadmin/Documents/testWriting/profX/mgbench/deps/maps/include/ $(HIPCC_FLAGS) -g fullduplex.cpp -o $@ -lgflags
clean:
	rm -f *.o $(EXE)
	

PROJECT := bwtest
OBJECTS	:= main.o bench.o buffer.o stream.o timer.o device.o
DEPS	:= buffer.h stream.h timer.h bench.h device.h
CFLAGS  := -Wall -Wextra 
NVCC    := /usr/local/cuda/bin/nvcc
HIPCC    := /opt/rocm/bin/hipcc

ifeq ($(shell uname -s),Darwin)
CCDIR	:= /Library/Developer/CommandLineTools/usr/bin/
CFLAGS  += -Wno-gnu-designator 
else
CCDIR   := /usr/bin/g++
endif

INCLUDE	:= /opt/rocm/hip/include/hip/ 

.PHONY: all clean $(PROJECT)

all: $(PROJECT)

clean:
	-$(RM) $(PROJECT) $(OBJECTS)

$(PROJECT): $(OBJECTS)
	$(HIPCC) -o $@ $^ 

%.o: %.cu $(DEPS)
	$(HIPCC) -std=c++11 $(addprefix -I,$(INCLUDE)) -o $@ $< -c 

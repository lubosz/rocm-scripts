#ifndef __DEVICE_H__
#define __DEVICE_H__

#include <hip_runtime.h>

// Get number of CUDA devices on the system
int countDevices();

// Check if device is not prohibited
bool isDeviceValid(int device);

// Get device properties for a device
void loadDeviceProperties(int device, hipDeviceProp_t& properties);

#endif

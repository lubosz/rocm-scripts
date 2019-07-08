#include <hip_runtime.h>
#include <exception>
#include <stdexcept>
#include <vector>
#include "device.h"

using std::runtime_error;
using std::vector;


// Cache number of devices
static int deviceCount = -1;


// Cache device properties
static vector<hipDeviceProp_t> deviceProperties;


static void loadDeviceData()
{
    hipError_t  err;

    err = hipGetDeviceCount(&deviceCount);
    if (err != hipSuccess)
    {
        throw runtime_error(hipGetErrorString(err));
    }

    deviceProperties.reserve(deviceCount);
    for (int device = 0; device < deviceCount; ++device)
    {
        hipDeviceProp_t prop;

        err = hipGetDeviceProperties(&prop, device);
        if (err != hipSuccess)
        {
            throw runtime_error(hipGetErrorString(err));
        }

        deviceProperties.push_back(prop);
    }
}


bool isDeviceValid(int device)
{
    if (deviceCount < 0)
    {
        loadDeviceData();
    }

    if (device < 0 || device >= deviceCount)
    {
        return false;
    }


    return true;
}


int countDevices()
{
    if (deviceCount < 0)
    {
        loadDeviceData();
    }

    return deviceCount;
}


void loadDeviceProperties(int device, hipDeviceProp_t& prop)
{
    if (deviceCount < 0)
    {
        loadDeviceData();
    }

    prop = deviceProperties[device];
}

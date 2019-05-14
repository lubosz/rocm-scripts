#include <hip_runtime.h>
#include <memory>
#include <exception>
#include <stdexcept>
#include "buffer.h"


static void deleteHostBuffer(void* buffer)
{
    hipHostFree(buffer);
}


static void deleteDeviceBuffer(void* buffer)
{
    hipHostFree(buffer);
}


BufferPtr createHostBuffer(size_t length, unsigned int flags)
{
    void* buffer;

    hipError_t err = hipHostAlloc(&buffer, length, flags);
    if (err != hipSuccess)
    {
        throw std::runtime_error(hipGetErrorString(err));
    }

    return BufferPtr(buffer, &deleteHostBuffer);
}


BufferPtr createDeviceBuffer(int device, size_t length)
{
    hipError_t err;
    void* buffer;

    err = hipSetDevice(device);
    if (err != hipSuccess)
    {
        throw std::runtime_error(hipGetErrorString(err));
    }

    err = hipMalloc(&buffer, length);
    if (err != hipSuccess)
    {
        throw std::runtime_error(hipGetErrorString(err));
    }

    return BufferPtr(buffer, &deleteDeviceBuffer);
}

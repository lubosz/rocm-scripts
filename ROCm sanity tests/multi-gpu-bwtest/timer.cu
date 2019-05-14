#include <hip_runtime.h>
#include <memory>
#include <exception>
#include <stdexcept>
#include "timer.h"


static void deleteTimer(Timer* timer)
{
    hipEventDestroy(timer->started);
    hipEventDestroy(timer->stopped);
    delete timer;
}


TimerPtr createTimer()
{
    hipError_t err;

    Timer* timer = new Timer;

    err = hipEventCreate(&timer->started);
    if (err != hipSuccess)
    {
        delete timer;
        throw std::runtime_error(hipGetErrorString(err));
    }

    err = hipEventCreate(&timer->stopped);
    if (err != hipSuccess)
    {
        hipEventDestroy(timer->started);
        delete timer;
        throw std::runtime_error(hipGetErrorString(err));
    }

    return TimerPtr(timer, &deleteTimer);
}


double Timer::usecs() const
{
    float milliseconds = .0f;

    hipError_t err = hipEventElapsedTime(&milliseconds, started, stopped);
    if (err != hipSuccess)
    {
        throw std::runtime_error(hipGetErrorString(err));
    }

    return (double) milliseconds * 1000;
}


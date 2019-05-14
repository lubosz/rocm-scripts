#ifndef __TIMER_H__
#define __TIMER_H__

#include <hip_runtime.h>
#include <memory>


// Timer instance
struct Timer
{
    hipEvent_t started;
    hipEvent_t stopped;

    // Calculate the elapsed time between started and stopped
    double usecs() const;
};


// Timer instance pointer
typedef std::shared_ptr<Timer> TimerPtr;


// Helper function for creating a Timer instance
TimerPtr createTimer();

#endif

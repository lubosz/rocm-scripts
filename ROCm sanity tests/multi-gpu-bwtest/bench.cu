#include <hip_runtime.h>
#include <vector>
#include <exception>
#include <stdexcept>
#include <string>
#include <cstring>
#include <cstdio>
#include "bench.h"
#include "buffer.h"
#include "stream.h"
#include "timer.h"

using std::vector;
using std::runtime_error;
using std::string;


// Helper function to "round up" units
// Example 1024 B becomes 1 KiB
static string bytesToUnit(size_t size)
{
    char buffer[1024];
    const char* units[] = { "B  ", "KiB", "MiB", "GiB", "TiB" };
    size_t i = 0, n = sizeof(units) / sizeof(units[0]);

    double csize = (double) size;

    while (i < (n - 1) && csize >= 1024.0)
    {
        csize /= 1024.0;
        ++i;
    }

    snprintf(buffer, sizeof(buffer), "%.2f %s", csize, units[i]);
    return string(buffer);
}


// Helper function to get a string representation of a transfer direction
static string transferDirectionToString(hipMemcpyKind direction)
{
    if (direction == hipMemcpyHostToDevice)
    {
        return string("HtoD");
    }
    if (direction == hipMemcpyDeviceToHost)
    {
        return string("DtoH");
    }

    return string("unknown");
}


// Execute transfers and time them
static void timeTransfers(const vector<TransferSpec>& transferSpecs)
{
    hipError_t err;

    for (const TransferSpec& spec : transferSpecs)
    {
        hipStream_t stream = *spec.stream;

        const void* src = spec.direction == hipMemcpyDeviceToHost ? spec.deviceBuffer.get() : spec.hostBuffer.get();
        void* dst = spec.direction == hipMemcpyDeviceToHost ? spec.hostBuffer.get() : spec.deviceBuffer.get();

        err = hipEventRecord(spec.timer->started, stream);
        if (err != hipSuccess)
        {
            throw runtime_error(hipGetErrorString(err));
        }

        err = hipMemcpyAsync(dst, src, spec.length, spec.direction, stream);
        if (err != hipSuccess)
        {
            throw runtime_error(hipGetErrorString(err));
        }

        err = hipEventRecord(spec.timer->stopped, stream);
        if (err != hipSuccess)
        {
            throw runtime_error(hipGetErrorString(err));
        }
    }
}


// Wait for all streams to complete
static void syncStreams(const vector<TransferSpec>& transferSpecs)
{
    hipError_t err;

    for (const TransferSpec& spec : transferSpecs)
    {
        err = hipStreamSynchronize(*spec.stream);
        if (err != hipSuccess)
        {
            throw runtime_error(hipGetErrorString(err));
        }
    }
}


void runBandwidthTest(const vector<TransferSpec>& transferSpecs)
{
    hipError_t err;

    // Create timing events on the null stream
    TimerPtr globalTimer = createTimer();
    err = hipEventRecord(globalTimer->started);
    if (err != hipSuccess)
    {
        throw runtime_error(hipGetErrorString(err));
    }

    // Execute transfers
    try
    {
        fprintf(stdout, "Executing transfers..........");
        fflush(stdout);
        timeTransfers(transferSpecs);
        fprintf(stdout, "DONE\n");
        fflush(stdout);
    }
    catch (const runtime_error& e)
    {
        fprintf(stdout, "FAIL\n");
        fflush(stdout);
        throw e;
    }

    // Synchronize all streams
    try
    {
        fprintf(stdout, "Synchronizing streams........");
        fflush(stdout);

        syncStreams(transferSpecs);

        err = hipEventRecord(globalTimer->stopped);
        if (err != hipSuccess)
        {
            throw runtime_error(hipGetErrorString(err));
        }

        err = hipEventSynchronize(globalTimer->stopped);
        if (err != hipSuccess)
        {
            throw runtime_error(hipGetErrorString(err));
        }

        fprintf(stdout, "DONE\n");
        fflush(stdout);
    } 
    catch (const runtime_error& e)
    {
        fprintf(stdout, "FAIL\n");
        fflush(stdout);
        throw e;
    }


    // FIXME: Warn about low compute-capability here instead?

    // Print results
    fprintf(stdout, "\n");
    fprintf(stdout, "=====================================================================================\n");
    fprintf(stdout, " %2s   %-15s   %13s   %-8s   %-12s   %-10s\n",
            "ID", "Device name", "Transfer size", "Direction", "Time elapsed", "Bandwidth");
    fprintf(stdout, "-------------------------------------------------------------------------------------\n");
    fflush(stdout);

    size_t totalSize = 0;
    double aggrElapsed = .0;
    double timedElapsed = globalTimer->usecs();

    for (const TransferSpec& res : transferSpecs)
    {
        double elapsed = res.timer->usecs();
        double bandwidth = (double) res.length / elapsed;

        totalSize += res.length;
        aggrElapsed += elapsed;

        hipDeviceProp_t prop;
        err = hipGetDeviceProperties(&prop, res.device);
        if (err != hipSuccess)
        {
            prop.name[0] = 'E';
            prop.name[1] = 'R';
            prop.name[2] = 'R';
            prop.name[3] = '!';
            prop.name[4] = '\0';
        }

        fprintf(stdout, " %2d   %-15s   %13s    %8s   %9.0f µs    %10.2f MiB/s \n",
                res.device, 
                prop.name, 
                bytesToUnit(res.length).c_str(), 
                transferDirectionToString(res.direction).c_str(),
                elapsed,
                bandwidth
               );
        fflush(stdout);
    }
    fprintf(stdout, "=====================================================================================\n");

    fprintf(stdout, "\n");
    fprintf(stdout, "Aggregated total time      : %12.0f µs\n", aggrElapsed);
    fprintf(stdout, "Aggregated total bandwidth : %12.2f MiB/s\n", (double) totalSize / aggrElapsed);
    fprintf(stdout, "Estimated elapsed time     : %12.0f µs\n", timedElapsed);
    fprintf(stdout, "Timed total bandwidth      : %12.2f MiB/s\n", (double) totalSize / timedElapsed);
    fprintf(stdout, "\n");
    fflush(stdout);
}

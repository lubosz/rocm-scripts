#include <hip_runtime.h>
#include <map>
#include <memory>
#include <exception>
#include <stdexcept>
#include "stream.h"

using std::runtime_error;
typedef std::map<int, StreamPtr> StreamMap;


static void deleteStream(hipStream_t* stream)
{
    hipStreamSynchronize(*stream);
    hipStreamDestroy(*stream);
    delete stream;
}


static StreamPtr createStream()
{
    hipStream_t* stream = new hipStream_t;

    hipError_t err = hipStreamCreateWithFlags(stream, hipStreamNonBlocking);
    //hipError_t err = hipStreamCreateWithFlags(stream, hipStreamDefault);

    if (err != hipSuccess)
    {
        delete stream;
        throw runtime_error(hipGetErrorString(err));
    }

    return StreamPtr(stream, &deleteStream);
}


StreamPtr StreamManager::retrieveStream(int device)
{
    if (mode != perTransfer)
    {
        if (mode == singleStream)
        {
            device = -1;
        }

        // Try to find stream in map
        StreamMap::iterator lowerBound = streams.lower_bound(device);
        if (lowerBound != streams.end() && !(streams.key_comp()(device, lowerBound->first)))
        {
            return lowerBound->second;
        }

        // Stream was not found in map, create it and return it
        StreamPtr stream = createStream();
        streams.insert(lowerBound, StreamMap::value_type(device, stream));
        return stream;
    }

    // Create a new stream every time
    return createStream();
}


StreamManager::StreamManager(StreamSharingMode mode)
    : mode(mode)
{
}

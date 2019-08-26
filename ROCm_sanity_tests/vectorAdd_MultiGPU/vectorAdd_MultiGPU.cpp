/**
 * Copyright 1993-2012 NVIDIA Corporation.  All rights reserved.
 *
 * Please refer to the NVIDIA end user license agreement (EULA) associated
 * with this source code for terms and conditions that govern your use of
 * this software. Any use, reproduction, disclosure, or distribution of
 * this software and related documentation outside the terms of the EULA
 * is strictly prohibited.
 *
 */

/**
 * Vector addition: C = A + B.
 *
 * This sample is a very basic sample that implements element by element
 * vector addition. It is the same as the sample illustrating Chapter 2
 * of the programming guide with some additions like error checking.
 */

#include <stdio.h>

// For the HIP runtime routines (prefixed with "hip_")
#include <hip_runtime.h>

//#include <helper_functions.h>
/**
 * HIP Kernel Device code
 *
 * Computes the vector addition of A and B into C. The 3 vectors have the same
 * number of elements numElements.
 */
__global__ void
vectorAdd(const float *A, const float *B, float *C, int numElements)
{
    int i = hipBlockDim_x * hipBlockIdx_x + hipThreadIdx_x;

    if (i < numElements)
    {
        C[i] = A[i] + B[i];
    }
}

/**
 * Host main routine
 */
int
main(void)
{
    // Error code to check return values for HIP calls
    hipError_t err = hipSuccess;

    // Print the vector length to be used, and compute its size
    int numElements = 4900001;
    size_t size = numElements * sizeof(float);
    printf("[Vector addition of %d elements]\n", numElements);

    
    // Multi-GPU
    int numDevs = 0;
    hipGetDeviceCount(&numDevs);

    if (numDevs == 0)
    {
	fprintf(stderr, "There is no GPU device!");
        exit(EXIT_FAILURE);
    }
   
    // step size between device
    size_t step = numElements/numDevs*sizeof(float); // not size/numDevs
    
    // Allocate the host input vector A
    float *h_A = (float *)malloc(size);

    // Allocate the host input vector B
    float *h_B = (float *)malloc(size);

    // Allocate the host output vector C
    float *h_C = (float *)malloc(size);

    // Verify that allocations succeeded
    if (h_A == NULL || h_B == NULL || h_C == NULL)
    {
        fprintf(stderr, "Failed to allocate host vectors!\n");
        exit(EXIT_FAILURE);
    }

    // Initialize the host input vectors
    for (int i = 0; i < numElements; ++i)
    {
        h_A[i] = rand()/(float)RAND_MAX;
        h_B[i] = rand()/(float)RAND_MAX;
    }

    // Allocate arry of pointers to store the device input vectors
    float **d_As = (float **)malloc(numDevs);
    
    if(d_As == NULL)
    {
	fprintf(stderr, "Failed to allocate array d_As to store pointers of device vectors!\n");
        exit(EXIT_FAILURE);
    }

    for(int i = 0; i < numDevs; ++i)
    {
	d_As[i] = NULL;
    }

    for(int i = 0; i < numDevs; ++i)
    {
        hipSetDevice(i);
        if (i == numDevs-1)
        {
    	   err = hipMalloc((void **)&d_As[i], size-i*step);
	   //printf("The size is %d bytes and step is %d bytes.\n", size, step);
	   //printf("The last device should allocate %d bytes.\n", size-i*step);
        }
	else
	{
    	   err = hipMalloc((void **)&d_As[i], size/numDevs);
        }
    	if (err != hipSuccess)
    	{
        	fprintf(stderr, "Failed to allocate device vector A's part %d (error code %s)!\n", hipGetErrorString(err), i);
        	exit(EXIT_FAILURE);
    	}
	
    }
    // Allocate arry of pointers to store the device input vectors
    float **d_Bs = (float **)malloc(numDevs);
  
    if(d_Bs == NULL)
    {
	fprintf(stderr, "Failed to allocate array d_Bs to store pointers of device vectors!\n");
        exit(EXIT_FAILURE);
    }

    for(int i = 0; i < numDevs; ++i)
    {
	d_Bs[i] = NULL;
    }

    for(int i = 0; i < numDevs; ++i)
    {
        hipSetDevice(i);
        if (i == numDevs-1)
        {
    	   err = hipMalloc((void **)&d_Bs[i], size-i*step);
        }
	else
	{
    	   err = hipMalloc((void **)&d_Bs[i], size/numDevs);
        }
	
    	if (err != hipSuccess)
    	{
           fprintf(stderr, "Failed to allocate device vector B's part %d (error code %s)!\n", hipGetErrorString(err), i);
           exit(EXIT_FAILURE);
    	}

    }
    // Allocate arry of pointers to store the device input vectors
    float **d_Cs = (float **)malloc(numDevs);
    if(d_Cs == NULL)
    {
	fprintf(stderr, "Failed to allocate array d_Cs to store pointers of device vectors!\n");
        exit(EXIT_FAILURE);
    }

    for(int i = 0; i < numDevs; ++i)
    {
	d_Cs[i] = NULL;
    }

    for(int i = 0; i < numDevs; ++i)
    {
	//set device is very important
        hipSetDevice(i);
        if (i == numDevs-1)
        {
    	   err = hipMalloc((void **)&d_Cs[i], size-i*step);
        }
	else
	{
    	   err = hipMalloc((void **)&d_Cs[i], size/numDevs);
        }

    	if (err != hipSuccess)
    	{
        	fprintf(stderr, "Failed to allocate device vector C's part %d (error code %s)!\n", hipGetErrorString(err), i);
        	exit(EXIT_FAILURE);
    	}
    }

    // Copy the host input vectors A and B in host memory to the device input vectors in
    // device memory

    printf("Copy input data from the host memory to the HIP device\n");
    for(int i = 0; i < numDevs; ++i)
    {
	//set device is very important
        hipSetDevice(i);
        if (i == numDevs-1)
        {
    		err = hipMemcpy(d_As[i], h_A+(i*numElements/numDevs), size-i*step, hipMemcpyHostToDevice);
        }
	else
	{
    		err = hipMemcpy(d_As[i], h_A+(i*numElements/numDevs), step, hipMemcpyHostToDevice);
        }

    	if (err != hipSuccess)
    	{
        	fprintf(stderr, "Failed to copy vector A's part %d from host to device (error code %s)!\n", i, hipGetErrorString(err));
        	exit(EXIT_FAILURE);
    	}

    }
    for(int i = 0; i < numDevs; ++i)
    {
	//set device is very important
        hipSetDevice(i);
        if (i == numDevs-1)
        {
    		err = hipMemcpy(d_Bs[i], h_B+(i*numElements/numDevs), size-i*step, hipMemcpyHostToDevice);
	}
	else
	{
    		err = hipMemcpy(d_Bs[i], h_B+(i*numElements/numDevs), step, hipMemcpyHostToDevice);
	}

    	if (err != hipSuccess)
    	{
        	fprintf(stderr, "Failed to copy vector B's part %d from host to device (error code %s)!\n", i, hipGetErrorString(err));
        	exit(EXIT_FAILURE);
    	}
    }

    // hipEvent_t is used to caculate the running time of the program on the devices
    hipEvent_t start;
    err = hipEventCreate(&start);

    if (err != hipSuccess)
    {
	fprintf(stderr, "Failed to create start event (error code %s)!\n", hipGetErrorString(err));
	exit(EXIT_SUCCESS);
    }

    hipEvent_t stop;
    err = hipEventCreate(&stop);

    if (err != hipSuccess)
    {
	fprintf(stderr, "Failed to create start event (error code %s)!\n", hipGetErrorString(err));
	exit(EXIT_SUCCESS);
    }

    // Record the start event
    err = hipEventRecord(start, NULL);

    if (err != hipSuccess)
    {
        fprintf(stderr, "Failed to record start event (error code %s)!\n", hipGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    // Launch the Vector Add HIP Kernel
    int threadsPerBlock = 256;
    int blocksPerGrid =(numElements/numDevs + threadsPerBlock - 1) / threadsPerBlock;
    for (int i = 0; i < numDevs; ++i)
    {
    	printf("HIP kernel %d launch with %d blocks of %d threads\n", i, blocksPerGrid, threadsPerBlock);
        hipSetDevice(i);
	if (i == numDevs-1)
	{
    		hipLaunchKernelGGL(vectorAdd, blocksPerGrid, threadsPerBlock, 0, 0, d_As[i], d_Bs[i], d_Cs[i], numElements - i*numElements/numDevs);
	}
	else
	{
    		hipLaunchKernelGGL(vectorAdd, blocksPerGrid, threadsPerBlock, 0, 0, d_As[i], d_Bs[i], d_Cs[i], numElements/numDevs);
	}
    	err = hipGetLastError();

    	if (err != hipSuccess)
    	{
        	fprintf(stderr, "Failed to launch vectorAdd kernel %d (error code %s)!\n", i, hipGetErrorString(err));
        	exit(EXIT_FAILURE);
    	}
    }

    // Record the stop event
    err = hipEventRecord(stop, NULL);

    if (err != hipSuccess)
    {
        fprintf(stderr, "Failed to record stop event (error code %s)!\n", hipGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    // Wait for the stop event to complete
    err = hipEventSynchronize(stop);

    if (err != hipSuccess)
    {
        fprintf(stderr, "Failed to synchronize on the stop event (error code %s)!\n", hipGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    float msecTotal = 0.0f;
    err = hipEventElapsedTime(&msecTotal, start, stop);

    if (err != hipSuccess)
    {
        fprintf(stderr, "Failed to get time elapsed between events (error code %s)!\n", hipGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    printf("The total time is %f msec.\n", msecTotal);
    
    for (int i = 0; i < numDevs; ++i)
    {
	hipSetDevice(i);
	if (i == numDevs-1)
	{
    		err = hipMemcpy(h_C+(i*numElements/numDevs), d_Cs[i], size-i*step, hipMemcpyDeviceToHost);
	}
	else
	{
    		err = hipMemcpy(h_C+(i*numElements/numDevs), d_Cs[i], step, hipMemcpyDeviceToHost);
	}

    	if (err != hipSuccess)
    	{
        	fprintf(stderr, "Failed to copy vector C's part %d from device to host (error code %s)!\n", i, hipGetErrorString(err));
        	exit(EXIT_FAILURE);
    	}
    }
    
    // Verify that the result vector is correct
    for (int i = 0; i < numElements; ++i)
    {
        if (fabs(h_A[i] + h_B[i] - h_C[i]) > 1e-5)
        {
            fprintf(stderr, "Result verification failed at element %d!\n", i);
            exit(EXIT_FAILURE);
        }
    }

    // Free device global memory
    for(int i = 0; i < numDevs; ++i)
    {
    	err = hipFree(d_As[i]);

    	if (err != hipSuccess)
    	{
        	fprintf(stderr, "Failed to free device vector A's part %d (error code %s)!\n", i, hipGetErrorString(err));
        	exit(EXIT_FAILURE);
    	}
    }
    for(int i = 0; i < numDevs; ++i)
    {
    	err = hipFree(d_Bs[i]);

    	if (err != hipSuccess)
    	{
        	fprintf(stderr, "Failed to free device vector B's part %d (error code %s)!\n", i, hipGetErrorString(err));
        	exit(EXIT_FAILURE);
    	}
    }
    for(int i = 0; i < numDevs; ++i)
    {
    	err = hipFree(d_Cs[i]);

    	if (err != hipSuccess)
    	{
        	fprintf(stderr, "Failed to free device vector C's part %d (error code %s)!\n", i, hipGetErrorString(err));
        	exit(EXIT_FAILURE);
    	}
    }
    // Free host memory
    free(h_A);
    free(h_B);
    free(h_C);

    // Reset the device and exit
    err = hipDeviceReset();

    if (err != hipSuccess)
    {
        fprintf(stderr, "Failed to deinitialize the device! error=%s\n", hipGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    printf("Done\n");
    return 0;
}


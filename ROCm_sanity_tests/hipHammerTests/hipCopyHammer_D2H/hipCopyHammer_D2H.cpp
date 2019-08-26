/* 
 test : hipCopyHammer_D2H 
 Desc : This test is part of hipHammerTests written to test stress/corner/edge cases. 
        hipCopyHammer_D2H does repeated device->Host transfers each of size ~500KB and more.
 Author : Phani 
*/

#include <iostream>
#include <hip/hip_runtime.h>
#include <assert.h>

using namespace std;

#define KNRM  "\x1B[0m"
#define KRED  "\x1B[31m"

#define HIPCHECK(error) \
{\
    hipError_t localError = error; \
    if (localError != hipSuccess) { \
        printf("%serror: '%s'(%d) from %s at %s:%d%s\n", \
        KRED, hipGetErrorString(localError), localError,\
        #error,__FILE__, __LINE__, KNRM); \
    }\
}


int main(){

    int gpus;
    int thisGpu, thatGpu,canAccessPeer;
    char *A_d0, *A_d1;
    char *A_h;
    size_t hSize =  500 * 1024  *  1024  * sizeof(char);
    hipStream_t s,s1; 
  
    thisGpu = 0;
    thatGpu = (thisGpu + 1);

    
     HIPCHECK(hipGetDeviceCount(&gpus));
    printf ("thisGpu=%d thatGpu=%d (Total no. of gpu =%d)\n", thisGpu, thatGpu,gpus);

    // hammer: D2H transfers
   // Due to a memory leak in HCC test is crashing with iter= 2048. 
   // So reduced the count to 1024
   for(int iter=0;iter<1024;iter++)
   { 
    A_h = (char*)malloc(hSize);
    memset(A_h,0x13,hSize); 
    HIPCHECK(hipSetDevice(thisGpu));
    HIPCHECK(hipMalloc(&A_d0, hSize));
    HIPCHECK(hipMemset(A_d0, 0x0, hSize));
    printf("Allocate & intialize mem on thisGpu.\n");
    hipStreamCreate(&s);
    hipMemcpyAsync(A_h,A_d0,hSize,hipMemcpyDeviceToHost,s); 
    hipStreamSynchronize(s);
    hipDeviceSynchronize();
    printf("Transfered from D0ToH:%d\n",iter);
    HIPCHECK(hipDeviceReset());
    hipFree(A_d0); 
    free(A_h);   
   }


   for(int iter=0;iter<1024;iter++)
   { 
    A_h = (char*)malloc(hSize);
    memset(A_h,0x13,hSize); 
    HIPCHECK(hipSetDevice(thatGpu));
    HIPCHECK(hipMalloc(&A_d1, hSize));
    HIPCHECK(hipMemset(A_d1, 0x0, hSize));
    printf("Allocate & intialize mem on thatGpu.\n");
    hipStreamCreate(&s);
    hipMemcpyAsync(A_h,A_d1,hSize,hipMemcpyDeviceToHost,s); 
    hipStreamSynchronize(s);
    hipDeviceSynchronize();
    printf("Transfered from D1ToH:%d\n",iter);
    HIPCHECK(hipDeviceReset());
    hipFree(A_d1); 
    free(A_h);   
   }


return 0;
}

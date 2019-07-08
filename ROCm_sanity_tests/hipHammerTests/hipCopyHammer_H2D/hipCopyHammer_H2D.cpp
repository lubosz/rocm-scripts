/* 
 test : hipCopyHammer_H2D 
 Desc : This test is part of hipHammerTests written to test stress/corner/edge cases.
        host buffer used is un-pinned.  
        hipCopyHammer_H2D does repeated Host->device transfers each of size ~500KB and more.
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
    size_t hSize =  500 *  1024 * 1024  * sizeof(char);
    hipStream_t s,s1; 
  
    A_h = (char*)malloc(hSize);
    memset(A_h,0x13,hSize); 
    
    thisGpu = 0;
    thatGpu = (thisGpu + 1);

    HIPCHECK(hipGetDeviceCount(&gpus));
    printf ("thisGpu=%d thatGpu=%d (Total no. of gpu =%d)\n", thisGpu, thatGpu,gpus);
    
    // allocate and intialize mem on thisGpu
   for(int iter=0;iter<1024;iter++){
    HIPCHECK(hipSetDevice(thisGpu));
    HIPCHECK(hipMalloc(&A_d0, hSize));
    HIPCHECK(hipMemset(A_d0, 0x0, hSize));
    printf("Allocate & intialize mem on thisGpu, iter:%d\n",iter);
    hipStreamCreate(&s);
    hipMemcpyAsync(A_d0,A_h,hSize,hipMemcpyHostToDevice,s); 
    hipStreamSynchronize(s);    
    hipDeviceSynchronize();
    HIPCHECK(hipDeviceReset());
    hipFree(A_d0);
   }   

   for(int iter=0;iter<1024;iter++){
    HIPCHECK(hipSetDevice(thatGpu));
    HIPCHECK(hipMalloc(&A_d1, hSize));
    HIPCHECK(hipMemset(A_d1, 0x0, hSize));
    printf("Allocate & intialize mem on thatGpu, iter:%d.\n",iter);
    hipStreamCreate(&s1);
    hipMemcpyAsync(A_d1,A_h,hSize,hipMemcpyHostToDevice,s1); 
    hipStreamSynchronize(s1);
    hipDeviceSynchronize();
    HIPCHECK(hipDeviceReset());
    hipFree(A_d0);
   } 

  free(A_h);
  return 0;
}

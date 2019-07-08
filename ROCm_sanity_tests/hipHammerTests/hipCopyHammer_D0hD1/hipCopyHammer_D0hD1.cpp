/* 
 test : hipCopyHammer_D0hD1 
 Desc : This test is part of hipHammerTests written to test stress/corner/edge cases.
        host buffer used is un-pinned.  
        hipCopyHammer_D0hD1 does repeated deviceX->host->deviceY transfers each of size ~500KB and more.
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
  
    thisGpu = 0;
    thatGpu = (thisGpu + 1);

    HIPCHECK(hipGetDeviceCount(&gpus));
    printf ("thisGpu=%d thatGpu=%d (Total no. of gpu =%d)\n", thisGpu, thatGpu,gpus);
    

printf("///////////////////////////\n");
printf("To Test d0->host and host->d0\n");   
    // allocate and intialize mem on thisGpu
    HIPCHECK(hipSetDevice(thisGpu));
    HIPCHECK(hipMalloc(&A_d0, hSize));
    HIPCHECK(hipMemset(A_d0, 0x0, hSize));
    printf("Allocate & intialize mem on thisGpu.\n");
    hipStreamCreate(&s);
   // try HostToDevice & DeviceToHost from thisGpu
    A_h = (char*)malloc(hSize);
    memset(A_h,0x13,hSize); 
    hipMemcpyAsync(A_d0,A_h,hSize,hipMemcpyHostToDevice,s); 
    hipDeviceSynchronize();
//ToDo:Compare the results
    printf("Transfered from HostToDevice.\n");
    hipMemcpyAsync(A_h,A_d0,hSize,hipMemcpyDeviceToHost,s); 
    hipStreamSynchronize(s);
    hipDeviceSynchronize();
    printf("Transfered from DeviceToHost.\n");
    HIPCHECK(hipDeviceReset());
//ToDo : Compare the results
    free(A_h);   

printf("\n");
printf("///////////////////////////\n");
printf("To Test d1->host and host->d1\n");   
    // allocate and intialize mem on thatGpu
    HIPCHECK(hipSetDevice(thatGpu));
    HIPCHECK(hipMalloc(&A_d1, hSize));
    HIPCHECK(hipMemset(A_d1, 0x0, hSize));
    printf("Allocate & intialize mem on thatGpu.\n");
    hipStreamCreate(&s1);
   // try HostToDevice & DeviceToHost from thisGpu
    A_h = (char*)malloc(hSize);
    memset(A_h,0x13,hSize); 
    hipMemcpyAsync(A_d1,A_h,hSize,hipMemcpyHostToDevice,s1); 
    hipStreamSynchronize(s1);
    hipDeviceSynchronize();
//ToDo: Compare the results
    printf("Transfered from HostToDevice.\n");
    hipMemcpyAsync(A_h,A_d1,hSize,hipMemcpyDeviceToHost,s1); 
    hipStreamSynchronize(s1);
    hipDeviceSynchronize();
    printf("Transfered from DeviceToHost.\n");
    HIPCHECK(hipDeviceReset());
//ToDo: Compare the results
   free(A_h);
 
 //Ben said: Gpu0->stg, stg->Gpu1. So be it
printf("\n");
printf("///////////////////////////\n");
printf("To Test d0->host->d1\n");   
    HIPCHECK(hipSetDevice(thisGpu));
    HIPCHECK(hipMalloc(&A_d0, hSize));
    HIPCHECK(hipMemset(A_d0, 0x13, hSize));
    hipStreamCreate(&s);
    A_h = (char*)malloc(hSize);
    memset(A_h,0x0,hSize); 
    hipMemcpyAsync(A_h,A_d0,hSize,hipMemcpyDeviceToHost,s); 
    hipStreamSynchronize(s);
    hipDeviceSynchronize();
    HIPCHECK(hipDeviceReset());
    printf("Transfered from DeviceToHost A_d0->A_h\n");
    HIPCHECK(hipSetDevice(thatGpu));
    HIPCHECK(hipMalloc(&A_d1, hSize));
    HIPCHECK(hipMemset(A_d1, 0x0, hSize));
    hipStreamCreate(&s1);
    hipMemcpyAsync(A_d1,A_h,hSize,hipMemcpyHostToDevice,s1); 
    hipStreamSynchronize(s1);
    hipDeviceSynchronize();
    printf("Transfered from HostToDevice A_h->A_d1\n");
    HIPCHECK(hipDeviceReset());
 //ToDo: Compare the results.
   free(A_h);


 //Ben said: Gpu1->stg,stg->Gpu0. So be it. 
printf("\n");
printf("///////////////////////////\n");
printf("To Test d1->host->d0\n");   
    HIPCHECK(hipSetDevice(thatGpu));
    HIPCHECK(hipMalloc(&A_d1, hSize));
    HIPCHECK(hipMemset(A_d1, 0x13, hSize));
    hipStreamCreate(&s1);
    A_h = (char*)malloc(hSize);
    memset(A_h,0x0,hSize); 
    hipMemcpyAsync(A_h,A_d1,hSize,hipMemcpyDeviceToHost,s1); 
    hipStreamSynchronize(s1);
    hipDeviceSynchronize();
    HIPCHECK(hipDeviceReset());
    printf("Transfered from DeviceToHost A_d1->A_h\n");
    HIPCHECK(hipSetDevice(thisGpu)); 
    HIPCHECK(hipMalloc(&A_d0, hSize));
    HIPCHECK(hipMemset(A_d0, 0x13, hSize));
    hipStreamCreate(&s);
    hipMemcpyAsync(A_d0,A_h,hSize,hipMemcpyHostToDevice,s); 
    hipStreamSynchronize(s);
    hipDeviceSynchronize();
    printf("Transfered from HostToDevice A_h->A_d0\n");
    HIPCHECK(hipDeviceReset());
 //ToDo: Compare the results.
    free(A_h);
  return 0;
}

#include <NvInfer.h>
#include <iostream>
#include "cuda_utils.h"

namespace Process
{
    __global__ void add_device(int* a, int* b)
    {
        int index = threadIdx.x + blockIdx.x * blockDim.x;
        b[index] = a[index] + 3;
    }

    void add(int* a, int* b)
    {
        int* a_d;
        int* b_d;
        CUDA_CHECK(cudaMalloc(&a_d, 4 * sizeof(int)));
        CUDA_CHECK(cudaMalloc(&b_d, 4 * sizeof(int)));
        CUDA_CHECK(cudaMemcpy(a_d, a, 4 * sizeof(int), cudaMemcpyHostToDevice));
        CUDA_CHECK(cudaMemcpy(b_d, b, 4 * sizeof(int), cudaMemcpyHostToDevice));
        add_device <<< 2, 2 >>> (a_d, b_d);
        CUDA_CHECK(cudaMemcpy(a, a_d, 4 * sizeof(int), cudaMemcpyDeviceToHost));
        CUDA_CHECK(cudaMemcpy(b, b_d, 4 * sizeof(int), cudaMemcpyDeviceToHost));
    }
}

extern "C"
{
    void add_c(int* a, int* b)
    {
        Process::add(a, b);
    }
}
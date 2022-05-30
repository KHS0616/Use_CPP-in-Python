#include <iostream>

int add(int a, int b)
{
    return a + b;
}

extern "C"
{
    int add_c(int a, int b){return add(a, b);};
}
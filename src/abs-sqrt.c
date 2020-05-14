#include "abs-sqrt.h"

float fabsf(float x);
double fabs(double x);
#pragma intrinsic (fabsf)
#pragma intrinsic (fabs)

#ifndef MIPS1_FIX
float sqrtf(float x);
double sqrt(double x);
#pragma intrinsic (sqrtf)
#pragma intrinsic (sqrt)
#else
#define sqrtf(x) (x)
#define sqrt(x) (x)
#endif

float abs_sqrt_test(float a) {
    double r = (double)sqrtf(fabsf(a));
    return (float)sqrt(fabs(r));
}

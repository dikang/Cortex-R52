#include <stdbool.h>

#include "printf.h"

#include "float.h"
void _out_char(char character, void* buffer, size_t idx, size_t maxlen);

static float calculate( float a, float b )
{
    float temp1, temp2;

    temp1 = a + b;
    temp2 = a * b;
    return temp2 / temp1;
}

bool float_test()
{
    /* Perform a float calculation to demonstrate floating point (using the FPU, if compiled appropriately) */
#ifdef __ARM_FP
    printf("Floating point calculation using the FPU...\r\n");
#else
    printf("Floating point calculation using the software floating point library (no FPU)...\r\n");
#endif
    float ref = 0.937500;
    printf("Float result should be: %f <--- should be 0.937500 if printf works\r\n", FLOAT_ARG(ref));
    float r = calculate(1.5f, 2.5f);
    printf("Float result is        %f\r\n", FLOAT_ARG(r));
    if (r == ref) printf("Equal\r\n");
    else printf("Not Equal\r\n");
}

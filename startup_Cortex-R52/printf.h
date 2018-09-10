#ifndef PRINTF_H
#define PRINTF_H

#include <stdarg.h>
#include <stdlib.h>

// Workaround for GCC bug with variadic arguments for ARMv8 Aarch32
// Wrap float arguments to printf with this macro like so:
//    float f = 4.2;
//    printf("a floating value: %f\n", FLOAT_ARG(f));
// The implementation of the workaround is to pass float arguments as unsigned,
// and cast them back to float on the printf side.
#define FLOAT_ARG(v) (*(unsigned *)&v)

int printf(const char* format, ...);
int sprintf(char* buffer, const char* format, ...);
int snprintf(char* buffer, size_t count, const char* format, ...);
int vsnprintf(char* buffer, size_t count, const char* format, va_list va);
int fctprintf(void (*out)(char character, void* arg), void* arg, const char* format, ...);

#endif // PRINTF_H

#include <stdio.h>

#include "target1/target.h"
#include "target2/target.h"

int main(void)
{
    int a = target1_func(10);
    int b = target2_func(a);
    printf("a=%d, b=%d\n", a, b);
    return 0;
}

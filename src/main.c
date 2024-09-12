#include <stdio.h>

#include "target1/target.h"
#include "target2/target.h"

int dummy_calc(int a, int b)
{
    int a1 = target1_func(a);
    int a2 = target2_func(b);
    return a1 * a2;
}

#ifndef TEST_BUILD
int main(void)
{
    int a = target1_func(10);
    int b = target2_func(a);
    int c = dummy_calc(a, b);
    printf("a=%d, b=%d, c=%d\n", a, b, c);
    return 0;
}
#endif // TEST_BUILD

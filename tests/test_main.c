#include "unity_fixture.h"

static void RunAllTests(void)
{
    RUN_TEST_GROUP(target1);
    RUN_TEST_GROUP(target2);
}

int main(int argc, const char *argv[])
{
    return UnityMain(argc, argv, RunAllTests);
}

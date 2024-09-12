#include <stdio.h>

#include "unity_fixture.h"

#include "../mocks/target1/Target1target.h"
#include "../mocks/target2/Target2target.h"

// main.c
int dummy_calc(int a, int b);


TEST_GROUP(main);

TEST_SETUP(main)
{
    // set stuff up here
    printf("\nsetUp: main\n");
}

TEST_TEAR_DOWN(main)
{
    // clean stuff up here
    printf("\ntearDown: main\n");
}

TEST(main, test_dummy_func)
{
    //test stuff
    printf("テスト1: main\n");

    target1_func_ExpectAndReturn(20, 2);
    target2_func_ExpectAndReturn(50, 3);
    TEST_ASSERT_EQUAL_INT(6, dummy_calc(20, 50));
}

TEST_GROUP_RUNNER(main)
{
    RUN_TEST_CASE(main, test_dummy_func);
}

static void RunAllTests(void)
{
    RUN_TEST_GROUP(main);
}

int main(int argc, const char *argv[])
{
    return UnityMain(argc, argv, RunAllTests);
}

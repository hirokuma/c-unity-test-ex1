#include <stdio.h>

#include "unity_fixture.h"

#include "target1/target.h"

TEST_GROUP(target1);

TEST_SETUP(target1)
{
    // set stuff up here
    printf("setUp: target1\n");
}

TEST_TEAR_DOWN(target1)
{
    // clean stuff up here
    printf("tearDown: target1\n");
}

TEST(target1, test_function_should_doBlahAndBlah)
{
    //test stuff
    printf("テスト1: target1\n");
}

TEST(target1, test_function_should_doAlsoDoBlah)
{
    //more test stuff
    printf("テスト2: target1\n");
}

TEST_GROUP_RUNNER(target1)
{
    RUN_TEST_CASE(target1, test_function_should_doBlahAndBlah);
    RUN_TEST_CASE(target1, test_function_should_doAlsoDoBlah);
}

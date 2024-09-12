#include <stdio.h>

#include "unity_fixture.h"

#include "target2/target.h"

TEST_GROUP(target2);

TEST_SETUP(target2)
{
    // set stuff up here
    printf("setUp: target2\n");
}

TEST_TEAR_DOWN(target2)
{
    // clean stuff up here
    printf("tearDown: target2\n");
}

TEST(target2, test_function_should_doBlahAndBlah)
{
    //test stuff
    printf("テスト1: target2\n");
}

TEST(target2, test_function_should_doAlsoDoBlah)
{
    //more test stuff
    printf("テスト2: target2\n");
}

TEST_GROUP_RUNNER(target2)
{
    RUN_TEST_CASE(target2, test_function_should_doBlahAndBlah);
    RUN_TEST_CASE(target2, test_function_should_doAlsoDoBlah);
}

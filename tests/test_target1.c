#include <stdio.h>

#include "unity_fixture.h"

#include "target1/target1.h"

TEST_GROUP(target1);

TEST_SETUP(target1)
{
    // set stuff up here
    printf("\nsetUp: target1\n");
}

TEST_TEAR_DOWN(target1)
{
    // clean stuff up here
    printf("\ntearDown: target1\n");
}

TEST(target1, test_function_should_doBlahAndBlah)
{
    //test stuff
    printf("テスト1: target1\n");

    TEST_ASSERT_EQUAL_INT(0, target1_func(0));
}

TEST(target1, test_function_should_doAlsoDoBlah)
{
    //more test stuff
    printf("テスト2: target1\n");

    TEST_ASSERT_EQUAL_INT(21, target1_func(10));
}

TEST_GROUP_RUNNER(target1)
{
    RUN_TEST_CASE(target1, test_function_should_doBlahAndBlah);
    RUN_TEST_CASE(target1, test_function_should_doAlsoDoBlah);
}

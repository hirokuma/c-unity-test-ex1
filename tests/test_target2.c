#include <stdio.h>

#include "unity_fixture.h"

#include "target2/target.h"

TEST_GROUP(target2);

TEST_SETUP(target2)
{
    // set stuff up here
    printf("\nsetUp: target2\n");
}

TEST_TEAR_DOWN(target2)
{
    // clean stuff up here
    printf("\ntearDown: target2\n");
}

TEST(target2, test_function_should_doBlahAndBlah)
{
    //test stuff
    printf("テスト1: target2\n");

    TEST_ASSERT_EQUAL_INT(20, target2_func(0));
}

TEST(target2, test_function_should_doAlsoDoBlah)
{
    //more test stuff
    printf("テスト2: target2\n");

    TEST_ASSERT_EQUAL_INT(40, target2_func(10));
}

TEST_GROUP_RUNNER(target2)
{
    RUN_TEST_CASE(target2, test_function_should_doBlahAndBlah);
    RUN_TEST_CASE(target2, test_function_should_doAlsoDoBlah);
}

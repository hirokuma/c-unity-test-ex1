# c-unity-test-ex1

C言語のテストフレームワーク[Unity](https://www.throwtheswitch.org/unity)のサンプル。

```console
$ git clone https://github.com/hirokuma/c-unity-test-ex1.git
$ git clone https://github.com/ThrowTheSwitch/Unity.git
$ cd c-unity-test-ex1
$ make
$ make run
$ make clean
```

```console
$ make tests
[TESTS]CFLAGS=--std=gnu99 -Wall -Werror -DDEBUG -I../Unity/src -I../Unity/extras/fixture/src -I../Unity/extras/memory/src -I./src -ggdb3 -O0
Run Tests
./tests/out/unity_test
Unity test run 1 of 1
.
setUp: target1
テスト1: target1

tearDown: target1
.
setUp: target1
テスト2: target1
./tests/test_target1.c:34:TEST(target1, test_function_should_doAlsoDoBlah):FAIL: Expected 21 Was 20
tearDown: target1

.
setUp: target2
テスト1: target2
./tests/test_target2.c:26:TEST(target2, test_function_should_doBlahAndBlah):FAIL: Expected 20 Was 30
tearDown: target2

.
setUp: target2
テスト2: target2

tearDown: target2


-----------------------
4 Tests 2 Failures 0 Ignored
FAIL
make: *** [Makefile:186: tests] Error 2
```

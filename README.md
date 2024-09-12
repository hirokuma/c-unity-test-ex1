# c-unity-test-ex1

C言語のテストフレームワーク[Unity](https://www.throwtheswitch.org/unity)のサンプル。

```console
$ git clone --recursive https://github.com/throwtheswitch/cmock.git
$ cd cmock
$ bundle install
$ cd ..
$ git clone https://github.com/hirokuma/c-unity-test-ex1.git
$ cd c-unity-test-ex1
$ make
$ make run
$ make clean
```

### mock作成

```console
$ make mock
ruby ../cmock/lib/cmock.rb -otests/cmock-target1.yaml ./src/target1/target.h
Creating mock for target...
ruby ../cmock/lib/cmock.rb -otests/cmock-target2.yaml ./src/target2/target.h
Creating mock for target...
```

### test

```console
$ make tests
[TESTS]CFLAGS=--std=gnu99 -Wall -Werror -DDEBUG -I../cmock/vendor/unity/src -I../cmock/vendor/unity/extras/fixture/src -I../cmock/vendor/unity/extras/memory/src -I./src -I../cmock/src -I./mocks -ggdb3 -O0 -DTEST_BUILD
Run Tests1
./tests/out/unity_test1
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
make: [Makefile:193: tests] Error 2 (ignored)
Run Tests2
./tests/out/unity_test2
Unity test run 1 of 1
.
setUp: main
テスト1: main

tearDown: main


-----------------------
1 Tests 0 Failures 0 Ignored 
OK
```

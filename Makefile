.PHONY: debug release run tests help
default: debug

###########################################

OUTPUT_FILENAME = tst
OUTPUT_BINARY_DIRECTORY = out

# source files
C_DIRECTORY = ./src
C_FILES = \
	target1/target.c \
	target2/target.c \
	main.c

# includes
C_INCLUDE_PATHS =

# object files
OBJECT_DIRECTORY = _build

# unity test sources
TESTS_DIRECTORY = ./tests
TESTS_FILES += \
	test_target1.c \
	test_target2.c \
	test_unity.c
UNITY_DIRECTORY = ../cmock/vendor/unity

CMOCK_DIRECTORY = ../cmock
CMOCK_FILES = \
	./mocks/target1/Target1target.c \
	./mocks/target2/Target2target.c

# Link Library
LIBS =

# Options
CFLAGS =
LDFLAGS =


#GNU_PREFIX := arm-none-eabi-

mock:
	ruby ../cmock/lib/cmock.rb -otests/cmock-target1.yaml $(C_DIRECTORY)/target1/target.h
	ruby ../cmock/lib/cmock.rb -otests/cmock-target2.yaml $(C_DIRECTORY)/target2/target.h

###########################################

export OUTPUT_FILENAME
MAKEFILE_NAME := $(MAKEFILE_LIST)
MAKEFILE_DIR := $(dir $(MAKEFILE_NAME) )

MK := mkdir
RM := rm -rf

#echo suspend
ifeq ("$(VERBOSE)","1")
	NO_ECHO :=
else
	NO_ECHO := @
endif

# Toolchain commands
CC       		:= "$(GNU_PREFIX)gcc"
AS       		:= "$(GNU_PREFIX)as"
AR       		:= "$(GNU_PREFIX)ar" -r
LD       		:= "$(GNU_PREFIX)ld"
NM       		:= "$(GNU_PREFIX)nm"
OBJDUMP  		:= "$(GNU_PREFIX)objdump"
OBJCOPY  		:= "$(GNU_PREFIX)objcopy"
SIZE    		:= "$(GNU_PREFIX)size"

# function for removing duplicates in a list
# https://github.com/br101/pingcheck/blob/master/Makefile.default
rmdup = $(strip $(if $1,$(firstword $1) $(call rmdup,$(filter-out $(firstword $1),$1))))

######################################
# CFLAGS
######################################
# cpu
#CFLAGS += -mcpu=cortex-m0
#CFLAGS += -mthumb -mabi=aapcs
#CFLAGS += -mfloat-abi=soft

CFLAGS += --std=gnu99
CFLAGS += -Wall -Werror

# keep every function in separate section. This will allow linker to dump unused functions
#CFLAGS += -ffunction-sections -fdata-sections -fno-strict-aliasing
#CFLAGS += -flto -fno-builtin

# others


######################################
# LDFLAGS
######################################
# cpu
#LDFLAGS += -mcpu=cortex-m0

# keep every function in separate section. This will allow linker to dump unused functions
#LDFLAGS += -Xlinker -Map=$(OBJECT_DIRECTORY)/$(OUTPUT_FILENAME).map

# let linker to dump unused sections
#LDFLAGS += -Wl,--gc-sections

# use newlib in nano version
#LDFLAGS += --specs=nano.specs -lc -lnosys


#building all targets
all:
	$(NO_ECHO)$(MAKE) -f $(MAKEFILE_NAME) -C $(MAKEFILE_DIR) -e cleanobj
	$(NO_ECHO)$(MAKE) -f $(MAKEFILE_NAME) -C $(MAKEFILE_DIR) -e debug

#target for printing all targets
help:
	@echo "following targets are available:"
	@echo "    debug:   build for debug"
	@echo "    release: build for release"
	@echo "    run:     run built object"
	@echo "    tests:   run tests"


C_SOURCE_FILES = $(addprefix $(C_DIRECTORY)/, $(C_FILES))
C_SOURCE_FILE_NAMES = $(notdir $(C_SOURCE_FILES))
C_PATHS = $(call rmdup, $(dir $(C_SOURCE_FILES)))
INC_DIRECTORIES := $(addprefix -I, $(C_INCLUDE_PATHS))

C_OBJECTS = $(addprefix $(OBJECT_DIRECTORY)/, $(C_FILES:.c=.o) $(C_MAIN_FILE:.c=.o))
OBJECTS = $(C_OBJECTS)
OBJECTS_DIRECTORIES = $(call rmdup, $(dir $(OBJECTS)))

# Sorting removes duplicates
BUILD_DIRECTORIES := $(sort $(OBJECTS_DIRECTORIES) $(OUTPUT_BINARY_DIRECTORY))


##### Targets

vpath %.c $(C_PATHS)

debug: CFLAGS += -DDEBUG
debug: CFLAGS += -ggdb3 -O0
debug: LDFLAGS += -ggdb3 -O0
debug: $(BUILD_DIRECTORIES) $(OBJECTS)
	@echo [DEBUG]Linking target: $(OUTPUT_FILENAME)
	@echo [DEBUG]CFLAGS=$(CFLAGS)
	$(NO_ECHO)$(CC) $(LDFLAGS) $(OBJECTS) $(LIBS) -o $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME)

release: CFLAGS += -DNDEBUG -O3
release: LDFLAGS += -O3
release: $(BUILD_DIRECTORIES) $(OBJECTS)
	@echo [RELEASE]Linking target: $(OUTPUT_FILENAME)
	$(NO_ECHO)$(CC) $(LDFLAGS) $(OBJECTS) $(LIBS) -o $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME)

## Create build directories
$(BUILD_DIRECTORIES):
	@$(MK) -p $@

# Create objects from C SRC files
$(OBJECT_DIRECTORY)/%.o: %.c
	@echo Compiling C file: $(notdir $<): $(CFLAGS)
	$(NO_ECHO)$(CC) $(CFLAGS) $(INC_DIRECTORIES) -c -o $@ $<

# Link
$(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME): $(BUILD_DIRECTORIES) $(OBJECTS)
	@echo Linking target: $(OUTPUT_FILENAME)
	$(NO_ECHO)$(CC) $(LDFLAGS) $(OBJECTS) $(LIBS) -o $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME)

# Run
run:
	@$(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME)

# tests
UNITY_MAIN_DIRECTORY = $(UNITY_DIRECTORY)/src
UNITY_FIXTURE_DIRECTORY = $(UNITY_DIRECTORY)/extras/fixture/src
UNITY_MEMORY_DIRECTORY = $(UNITY_DIRECTORY)/extras/memory/src
TESTS_SOURCE_FILES = $(addprefix $(TESTS_DIRECTORY)/, $(TESTS_FILES))
TEST_OBJECT_DIRECTORY = $(TESTS_DIRECTORY)/$(OUTPUT_BINARY_DIRECTORY)
TEST_BINARY1 = unity_test1
TEST_BINARY2 = unity_test2
tests: CFLAGS += -DDEBUG -I$(UNITY_MAIN_DIRECTORY) -I$(UNITY_FIXTURE_DIRECTORY) -I$(UNITY_MEMORY_DIRECTORY) -I$(C_DIRECTORY) $(INC_DIRECTORIES) -I$(CMOCK_DIRECTORY)/src -I./mocks
tests: CFLAGS += -ggdb3 -O0
tests: CFLAGS += -DTEST_BUILD
tests: LDFLAGS += -ggdb3 -O0
tests: $(TESTS_OBJECTS)
	@$(MK) -p $(TEST_OBJECT_DIRECTORY)
	@echo [TESTS]CFLAGS=$(CFLAGS)
	$(NO_ECHO)$(CC) $(CFLAGS) $(LDFLAGS) $(LIBS) -o $(TEST_OBJECT_DIRECTORY)/$(TEST_BINARY1) $(UNITY_FIXTURE_DIRECTORY)/unity_fixture.c $(UNITY_MAIN_DIRECTORY)/unity.c $(TESTS_SOURCE_FILES)  $(CMOCK_DIRECTORY)/src/cmock.c $(C_SOURCE_FILES)
	@echo Run Tests1
	-$(TEST_OBJECT_DIRECTORY)/$(TEST_BINARY1)
	$(NO_ECHO)$(CC) $(CFLAGS) $(LDFLAGS) $(LIBS) -o $(TEST_OBJECT_DIRECTORY)/$(TEST_BINARY2) $(UNITY_FIXTURE_DIRECTORY)/unity_fixture.c $(UNITY_MAIN_DIRECTORY)/unity.c $(TESTS_DIRECTORY)/test_main.c $(CMOCK_DIRECTORY)/src/cmock.c $(CMOCK_FILES) $(C_DIRECTORY)/main.c
	@echo Run Tests2
	-$(TEST_OBJECT_DIRECTORY)/$(TEST_BINARY2)

clean:
	$(RM) $(OBJECT_DIRECTORY) $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME) $(TEST_OBJECT_DIRECTORY) mocks

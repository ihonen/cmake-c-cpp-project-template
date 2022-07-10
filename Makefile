CC  ?= clang
CXX ?= clang++

BUILD_DIR := ./.build
SRC_DIR   := .
BIN_DIR   := $(BUILD_DIR)/bin

# ------------------------------------------------------------------------------

all: run

# ------------------------------------------------------------------------------

configure:
	cmake -B $(BUILD_DIR) -S $(SRC_DIR)

build: configure
	cmake --build $(BUILD_DIR) --parallel `nproc`

run: build
	$(BIN_DIR)/myproject

clean:
	rm -f `find $(BUILD_DIR) -name *.o`
	rm -rf $(BUILD_DIR)/bin/*
	rm -rf $(BUILD_DIR)/lib/*

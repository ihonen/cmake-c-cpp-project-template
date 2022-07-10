CC  ?= gcc
CXX ?= g++

SRC_DIR   := .
BUILD_DIR := .build
BIN_DIR   := $(BUILD_DIR)/bin
LIB_DIR   := $(BUILD_DIR)/lib

# ------------------------------------------------------------------------------

.PHONY: all
all: run

# ------------------------------------------------------------------------------

.PHONY: configure
configure:
	cmake -B $(BUILD_DIR) -S $(SRC_DIR)

.PHONY: build
build: configure
	cmake --build $(BUILD_DIR) --parallel `nproc`

.PHONY: run
run: build
	$(BIN_DIR)/myproject

.PHONY: clean
clean:
	rm -f `find $(BUILD_DIR) -name *.o`
	rm -rf $(BIN_DIR)/*
	rm -rf $(LIB_DIR)/*

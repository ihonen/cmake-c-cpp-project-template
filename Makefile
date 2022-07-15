CC        ?= clang
CXX       ?= clang++

SRC_DIR   := .
BUILD_DIR := .build
BIN_DIR   := $(BUILD_DIR)/bin
LIB_DIR   := $(BUILD_DIR)/lib

CMAKE_GEN ?= "Ninja"

# ------------------------------------------------------------------------------

all: run
.PHONY: all

# ------------------------------------------------------------------------------

configure:
	CC=$(CC) CXX=$(CXX) cmake -B $(BUILD_DIR) -S $(SRC_DIR) -G $(CMAKE_GEN)
.PHONY: configure

build: configure
	cmake --build $(BUILD_DIR) --parallel `nproc`
.PHONY: build

run: build
	$(BIN_DIR)/myproject
.PHONY: run

clean:
	rm -f `find $(BUILD_DIR) -name *.o`
	rm -rf $(BIN_DIR)/*
	rm -rf $(LIB_DIR)/*
.PHONY: clean

hard-clean:
	rm -rf $(BUILD_DIR)

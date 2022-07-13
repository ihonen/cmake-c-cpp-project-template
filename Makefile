CC        ?= clang
CXX       ?= clang++

SRC_DIR   := .
BUILD_DIR := .build
BIN_DIR   := $(BUILD_DIR)/bin
LIB_DIR   := $(BUILD_DIR)/lib

CMAKE_GEN ?= "Ninja"

# ------------------------------------------------------------------------------

.PHONY: all
all: run

# ------------------------------------------------------------------------------

.PHONY: configure
configure:
	cmake -B $(BUILD_DIR) -S $(SRC_DIR) -G $(CMAKE_GEN)

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

project(myproject)

cmake_minimum_required(VERSION 3.18.0)

# ------------------------------------------------------------------------------

# Assume we are using a rather new compiler.
set(CMAKE_C_STANDARD   17)
set(CMAKE_CXX_STANDARD 20)

set(CMAKE_CONFIGURATION_TYPES "Debug" "Profile" "Release" "MinSizeRel")

if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    string(STRIP "-O0 -g $ENV{CFLAGS}" CMAKE_C_FLAGS_DEBUG)
    string(STRIP "-O2 -g -p $ENV{CFLAGS}" CMAKE_C_FLAGS_PROFILE)
    string(STRIP "-O2 -Wall -Wextra -Werror $ENV{CFLAGS}" CMAKE_C_FLAGS_RELEASE)
    string(STRIP "-Os -Wall -Wextra -Werror $ENV{CFLAGS}" CMAKE_C_FLAGS_MINSIZEREL)
    string(STRIP "-O0 -g $ENV{CXXFLAGS}" CMAKE_CXX_FLAGS_DEBUG)
    string(STRIP "-O2 -g -p $ENV{CXXFLAGS}" CMAKE_CXX_FLAGS_PROFILE)
    string(STRIP "-O2 -Wall -Wextra -Werror $ENV{CXXFLAGS}" CMAKE_CXX_FLAGS_RELEASE)
    string(STRIP "-Os -Wall -Wextra -Werror $ENV{CXXFLAGS}" CMAKE_CXX_FLAGS_MINSIZEREL)
else ()
    message("WARNING: This project doesn't fully support compiler '${CMAKE_CXX_COMPILER_ID}'")
endif ()

set(MYPROJECT_DEFAULT_BUILD_TYPE "Debug")
if (CMAKE_BUILD_TYPE STREQUAL "")
    message(STATUS "myproject: CMAKE_BUILD_TYPE unspecified, defaulting to ${MYPROJECT_DEFAULT_BUILD_TYPE}")
    set(CMAKE_BUILD_TYPE ${MYPROJECT_DEFAULT_BUILD_TYPE})
endif ()

string(TOUPPER ${CMAKE_BUILD_TYPE} CMAKE_BUILD_TYPE_UPPERCASE)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(MYPROJECT_EXEC_PATH ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/myproject)

include(cmake/Cppcheck.cmake)

# ------------------------------------------------------------------------------

message(STATUS "")

# -----

message(STATUS "myproject: Build type:             ${CMAKE_BUILD_TYPE}")

# -----

message(STATUS "myproject: C compiler:             ${CMAKE_CXX_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION}")
message(STATUS "myproject: C standard:             ${CMAKE_C_STANDARD}")
message(STATUS "myproject: C compiler options:     ${CMAKE_C_FLAGS_${CMAKE_BUILD_TYPE_UPPERCASE}}")

if (CMAKE_C_CPPCHECK)
    message(STATUS "myproject: C Cppcheck enabled:     yes")
else ()
    message(STATUS "myproject: C Cppcheck enabled:     no")
endif ()

# -----

message(STATUS "myproject: C++ compiler:           ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "myproject: C++ standard:           ${CMAKE_CXX_STANDARD}")
message(STATUS "myproject: C++ compiler options:   ${CMAKE_CXX_FLAGS_${CMAKE_BUILD_TYPE_UPPERCASE}}")

if (CMAKE_CXX_CPPCHECK)
    message(STATUS "myproject: C++ Cppcheck enabled:   yes")
else ()
    message(STATUS "myproject: C++ Cppcheck enabled:   no")
endif ()

# -----

message(STATUS "myproject: Output executable path: ${MYPROJECT_EXEC_PATH}")

# -----

message(STATUS "")

# ------------------------------------------------------------------------------

add_subdirectory(src)

# ------------------------------------------------------------------------------

include(CTest)
enable_testing()
add_subdirectory(test)

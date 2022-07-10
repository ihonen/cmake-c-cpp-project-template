cmake_minimum_required(VERSION 3.18.0)

# ------------------------------------------------------------------------------

project(myproject)

# ------------------------------------------------------------------------------

include(cmake/CompileOptions.cmake)
include(cmake/Cppcheck.cmake)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(MYPROJECT_EXEC_PATH ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/myproject)

# ------------------------------------------------------------------------------

print_msg("")

# -----

print_msg("Build type:             ${CMAKE_BUILD_TYPE}")

# -----

print_msg("")

# -----

print_msg("C compiler:             ${CMAKE_CXX_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION}")
print_msg("C standard:             C${CMAKE_C_STANDARD}")
print_msg("C compiler options:     ${CMAKE_C_FLAGS_${CMAKE_BUILD_TYPE_UPPERCASE}}")

if (CMAKE_C_CPPCHECK)
    print_msg("C Cppcheck enabled:     yes")
else ()
    print_msg("C Cppcheck enabled:     no")
endif ()

# -----

print_msg("")

# -----

print_msg("C++ compiler:           ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
print_msg("C++ standard:           C++${CMAKE_CXX_STANDARD}")
print_msg("C++ compiler options:   ${CMAKE_CXX_FLAGS_${CMAKE_BUILD_TYPE_UPPERCASE}}")

if (CMAKE_CXX_CPPCHECK)
    print_msg("C++ Cppcheck enabled:   yes")
else ()
    print_msg("C++ Cppcheck enabled:   no")
endif ()

# -----

print_msg("")
print_msg("Output executable path: ${MYPROJECT_EXEC_PATH}")

# -----

print_msg("")

# ------------------------------------------------------------------------------

add_subdirectory(src)

# ------------------------------------------------------------------------------

include(CTest)
enable_testing()
add_subdirectory(test)

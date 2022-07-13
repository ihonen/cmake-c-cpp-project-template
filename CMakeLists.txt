cmake_minimum_required(VERSION 3.18.0)

# ------------------------------------------------------------------------------

project(myproject)

# ------------------------------------------------------------------------------

include(${CMAKE_SOURCE_DIR}/cmake/Ansi.cmake)

# ------------------------------------------------------------------------------
# Build directory
# ------------------------------------------------------------------------------

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(MYPROJECT_EXEC_PATH ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/myproject)

# ------------------------------------------------------------------------------
# Build types
# ------------------------------------------------------------------------------

set(CMAKE_C_STANDARD          17)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS        OFF)

set(CMAKE_CXX_STANDARD          20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS        OFF)

set(CMAKE_CONFIGURATION_TYPES
    Debug
    Profile
    Release
    MinSizeRel
)

set(MYPROJECT_DEFAULT_BUILD_TYPE Debug)

if (CMAKE_BUILD_TYPE STREQUAL "")
    msg("CMAKE_BUILD_TYPE unspecified, defaulting to ${MYPROJECT_DEFAULT_BUILD_TYPE}")
    set(CMAKE_BUILD_TYPE ${MYPROJECT_DEFAULT_BUILD_TYPE})
endif ()

string(TOUPPER ${CMAKE_BUILD_TYPE} CMAKE_BUILD_TYPE_UPPERCASE)

# ------------------------------------------------------------------------------
# Compiler options
# ------------------------------------------------------------------------------

if (CMAKE_C_COMPILER_ID STREQUAL "GNU"
    OR CMAKE_C_COMPILER_ID STREQUAL "Clang")

    set(C_FLAGS_COMMON
        -pedantic
        -Wall
        -Wextra
        -Werror
    )

    set(CMAKE_C_FLAGS_DEBUG
        -Og
        -g
        ${C_FLAGS_COMMON}
        -Wno-error=unused-function
        -Wno-error=unused-parameter
        -Wno-error=unused-variable
    )

    set(CMAKE_C_FLAGS_PROFILE
        -O2
        -p
        -g
        ${C_FLAGS_COMMON}
        -Wno-error=unused-function
        -Wno-error=unused-parameter
        -Wno-error=unused-variable
    )

    set(CMAKE_C_FLAGS_RELEASE
        -O2
        ${C_FLAGS_COMMON}
    )

    set(CMAKE_C_FLAGS_MINSIZEREL
        -Os
        ${C_FLAGS_COMMON}
    )

    # Convert list -> string.
    string(REPLACE ";" " " CMAKE_C_FLAGS_DEBUG      "${CMAKE_C_FLAGS_DEBUG}")
    string(REPLACE ";" " " CMAKE_C_FLAGS_PROFILE    "${CMAKE_C_FLAGS_PROFILE}")
    string(REPLACE ";" " " CMAKE_C_FLAGS_RELEASE    "${CMAKE_C_FLAGS_RELEASE}")
    string(REPLACE ";" " " CMAKE_C_FLAGS_MINSIZEREL "${CMAKE_C_FLAGS_MINSIZEREL}")

else ()

    msg("C compiler '${CMAKE_C_COMPILER_ID}' is not fully supported")

endif()

if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU"
    OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")

    set(CXX_FLAGS_COMMON
        -pedantic
        -Wall
        -Wextra
        -Werror
    )

    set(CMAKE_CXX_FLAGS_DEBUG
        -Og
        -g
        ${CXX_FLAGS_COMMON}
        -Wno-error=unused-function
        -Wno-error=unused-parameter
        -Wno-error=unused-variable
    )

    set(CMAKE_CXX_FLAGS_PROFILE
        -O2
        -p
        -g
        ${CXX_FLAGS_COMMON}
        -Wno-error=unused-function
        -Wno-error=unused-parameter
        -Wno-error=unused-variable
    )

    set(CMAKE_CXX_FLAGS_RELEASE
        -O2
        ${CXX_FLAGS_COMMON}
    )

    set(CMAKE_CXX_FLAGS_MINSIZEREL
        -Os
        ${CXX_FLAGS_COMMON}
    )

    # Convert list -> string.
    string(REPLACE ";" " " CMAKE_CXX_FLAGS_DEBUG      "${CMAKE_CXX_FLAGS_DEBUG}")
    string(REPLACE ";" " " CMAKE_CXX_FLAGS_PROFILE    "${CMAKE_CXX_FLAGS_PROFILE}")
    string(REPLACE ";" " " CMAKE_CXX_FLAGS_RELEASE    "${CMAKE_CXX_FLAGS_RELEASE}")
    string(REPLACE ";" " " CMAKE_CXX_FLAGS_MINSIZEREL "${CMAKE_CXX_FLAGS_MINSIZEREL}")

else ()

    msg("C++ compiler '${CMAKE_CXX_COMPILER_ID}' is not fully supported")

endif ()

# ------------------------------------------------------------------------------
# Cppcheck
# ------------------------------------------------------------------------------

find_program(CMAKE_CXX_CPPCHECK NAMES "cppcheck")
set(CMAKE_C_CPPCHECK ${CMAKE_CXX_CPPCHECK})

# -----

set(CPPCHECK_FLAGS_COMMON
    -I${CMAKE_SOURCE_DIR}/include
    --platform=native
    --enable=style,performance,portability
    --suppress=missingIncludeSystem
    --inline-suppr
    --inconclusive
    --force
)

# Stricter options for release builds.
if ("${CMAKE_BUILD_TYPE}" STREQUAL "Release"
    OR "${CMAKE_BUILD_TYPE}" STREQUAL "MinSizeRel")

    list(APPEND CPPCHECK_FLAGS_COMMON
        --error-exitcode=1
    )

endif ()

file(GLOB_RECURSE CPPCHECK_CXX_FILES
    "${CMAKE_SOURCE_DIR}/src/*.cc"
    "${CMAKE_SOURCE_DIR}/src/*.cpp"
    "${CMAKE_SOURCE_DIR}/src/*.cxx"
    "${CMAKE_SOURCE_DIR}/src/*.c++"
    "${CMAKE_SOURCE_DIR}/src/*.tcc"
    "${CMAKE_SOURCE_DIR}/src/*.tpp"
    "${CMAKE_SOURCE_DIR}/src/*.txx"
)

file(GLOB_RECURSE CPPCHECK_C_FILES
    "${CMAKE_SOURCE_DIR}/src/*.c"
)

# -----

if (CMAKE_CXX_CPPCHECK)

    list(APPEND CMAKE_CXX_CPPCHECK
        ${CPPCHECK_CXX_FILES}
        ${CPPCHECK_FLAGS_COMMON}
        --std=c++${CMAKE_CXX_STANDARD}
        --cppcheck-build-dir=${CMAKE_BINARY_DIR}/cppcheck/cxx
    )

endif ()

# -----

if (CMAKE_C_CPPCHECK)

    list(APPEND CMAKE_C_CPPCHECK
        ${CPPCHECK_C_FILES}
        ${CPPCHECK_FLAGS_COMMON}
        --std=c${CMAKE_C_STANDARD}
        --cppcheck-build-dir=${CMAKE_BINARY_DIR}/cppcheck/c
    )

endif ()

# ------------------------------------------------------------------------------
# Print configuration
# ------------------------------------------------------------------------------

msg("")

# -----

msg("Build type:             ${CMAKE_BUILD_TYPE}")

# -----

msg("")

# -----

msg("C compiler:             ${CMAKE_CXX_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION}")
msg("C standard:             C${CMAKE_C_STANDARD}")
msg("C compiler options:     ${CMAKE_C_FLAGS_${CMAKE_BUILD_TYPE_UPPERCASE}}")

if (CMAKE_C_CPPCHECK)
    msg("C Cppcheck enabled:     yes")
else ()
    msg("C Cppcheck enabled:     no")
endif ()

# -----

msg("")

# -----

msg("C++ compiler:           ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
msg("C++ standard:           C++${CMAKE_CXX_STANDARD}")
msg("C++ compiler options:   ${CMAKE_CXX_FLAGS_${CMAKE_BUILD_TYPE_UPPERCASE}}")

if (CMAKE_CXX_CPPCHECK)
    msg("C++ Cppcheck enabled:   yes")
else ()
    msg("C++ Cppcheck enabled:   no")
endif ()

# -----

msg("")
msg("Output executable path: ${MYPROJECT_EXEC_PATH}")

# -----

msg("")

# ------------------------------------------------------------------------------
# Project structure
# ------------------------------------------------------------------------------

add_subdirectory(src)
add_subdirectory(test)

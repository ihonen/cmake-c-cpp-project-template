find_program(CMAKE_CXX_CPPCHECK NAMES "cppcheck")
set(CMAKE_C_CPPCHECK ${CMAKE_CXX_CPPCHECK})

# ------------------------------------------------------------------------------

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

# ------------------------------------------------------------------------------

if (CMAKE_CXX_CPPCHECK)

    list(APPEND CMAKE_CXX_CPPCHECK
        ${CPPCHECK_CXX_FILES}
        ${CPPCHECK_FLAGS_COMMON}
        --std=c++${CMAKE_CXX_STANDARD}
        --cppcheck-build-dir=${CMAKE_BINARY_DIR}/cppcheck/cxx
    )

endif()

# ------------------------------------------------------------------------------

if (CMAKE_C_CPPCHECK)

    list(APPEND CMAKE_C_CPPCHECK
        ${CPPCHECK_C_FILES}
        ${CPPCHECK_FLAGS_COMMON}
        --std=c${CMAKE_C_STANDARD}
        --cppcheck-build-dir=${CMAKE_BINARY_DIR}/cppcheck/c
    )

endif ()

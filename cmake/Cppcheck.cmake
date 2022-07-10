find_program(CMAKE_CXX_CPPCHECK NAMES "cppcheck")
set(CMAKE_C_CPPCHECK ${CMAKE_CXX_CPPCHECK})

# ------------------------------------------------------------------------------

if (CMAKE_CXX_CPPCHECK)
    file(GLOB_RECURSE MYPROJECT_CPPCHECK_CXX_FILES
        "${CMAKE_SOURCE_DIR}/src/*.cc"
        "${CMAKE_SOURCE_DIR}/src/*.cpp"
        "${CMAKE_SOURCE_DIR}/src/*.cxx"
        "${CMAKE_SOURCE_DIR}/src/*.c++"
        "${CMAKE_SOURCE_DIR}/src/*.tcc"
        "${CMAKE_SOURCE_DIR}/src/*.tpp"
        "${CMAKE_SOURCE_DIR}/src/*.txx"
    )
    list(
        APPEND CMAKE_CXX_CPPCHECK
            "${MYPROJECT_CPPCHECK_CXX_FILES}"
            "--cppcheck-build-dir=${CMAKE_BINARY_DIR}/cppcheck/cxx"
            "--error-exitcode=1"
            "--enable=style,performance,portability"
            "--std=c++${CMAKE_CXX_STANDARD}"
            "--inconclusive"
            "--force"
            "--inline-suppr"
            "--platform=native"
            "--suppress=missingIncludeSystem"
            "-I${CMAKE_SOURCE_DIR}/include"
    )
endif()

# ------------------------------------------------------------------------------

if (CMAKE_C_CPPCHECK)
    file(GLOB_RECURSE MYPROJECT_CPPCHECK_C_FILES
        "${CMAKE_SOURCE_DIR}/src/*.c"
    )
    list(
        APPEND CMAKE_C_CPPCHECK
            "${MYPROJECT_CPPCHECK_C_FILES}"
            "--cppcheck-build-dir=${CMAKE_BINARY_DIR}/cppcheck/c"
            "--error-exitcode=1"
            "--enable=style,performance,portability"
            "--std=c${CMAKE_C_STANDARD}"
            "--inconclusive"
            "--force"
            "--inline-suppr"
            "--platform=native"
            "--suppress=missingIncludeSystem"
            "-I${CMAKE_SOURCE_DIR}/include"
    )
endif ()

include(${CMAKE_SOURCE_DIR}/cmake/Print.cmake)

# ------------------------------------------------------------------------------

set(CMAKE_C_STANDARD   17)
set(CMAKE_CXX_STANDARD 20)

set(CMAKE_CONFIGURATION_TYPES
    Debug
    Profile
    Release
    MinSizeRel
)

set(MYPROJECT_DEFAULT_BUILD_TYPE Debug)

if (CMAKE_BUILD_TYPE STREQUAL "")
    print_msg("CMAKE_BUILD_TYPE unspecified, defaulting to ${MYPROJECT_DEFAULT_BUILD_TYPE}")
    set(CMAKE_BUILD_TYPE ${MYPROJECT_DEFAULT_BUILD_TYPE})
endif ()

string(TOUPPER ${CMAKE_BUILD_TYPE} CMAKE_BUILD_TYPE_UPPERCASE)

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

    print_msg("C compiler '${CMAKE_C_COMPILER_ID}' is not fully supported")

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

    print_msg("C++ compiler '${CMAKE_CXX_COMPILER_ID}' is not fully supported")

endif ()

include(${CMAKE_SOURCE_DIR}/cmake/Print.cmake)

# ------------------------------------------------------------------------------

set(CMAKE_C_STANDARD   17)
set(CMAKE_CXX_STANDARD 20)

set(CMAKE_CONFIGURATION_TYPES
    Debug Profile
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

    string(STRIP "-Og -g -Wall -Wextra -pedantic $ENV{CFLAGS}" CMAKE_C_FLAGS_DEBUG)
    string(STRIP "-O2 -g -p -Wall -Wextra -pedantic $ENV{CFLAGS}" CMAKE_C_FLAGS_PROFILE)
    string(STRIP "-O2 -Wall -Wextra -Werror -pedantic $ENV{CFLAGS}" CMAKE_C_FLAGS_RELEASE)
    string(STRIP "-Os -Wall -Wextra -Werror -pedantic $ENV{CFLAGS}" CMAKE_C_FLAGS_MINSIZEREL)

else ()

    print_msg("C compiler '${CMAKE_C_COMPILER_ID}' is not fully supported")

endif()

if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU"
    OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")

    string(STRIP "-Og -g -Wall -Wextra -pedantic $ENV{CXXFLAGS}" CMAKE_CXX_FLAGS_DEBUG)
    string(STRIP "-O2 -g -p -Wall -Wextra -pedantic $ENV{CXXFLAGS}" CMAKE_CXX_FLAGS_PROFILE)
    string(STRIP "-O2 -Wall -Wextra -Werror -pedantic $ENV{CXXFLAGS}" CMAKE_CXX_FLAGS_RELEASE)
    string(STRIP "-Os -Wall -Wextra -Werror -pedantic $ENV{CXXFLAGS}" CMAKE_CXX_FLAGS_MINSIZEREL)

else ()

    print_msg("C++ compiler '${CMAKE_CXX_COMPILER_ID}' is not fully supported")

endif ()

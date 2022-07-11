if (NOT WIN32)

    string(ASCII 27 ANSI_ESC)

    set(ANSI_RESET         "${ANSI_ESC}[m")
    set(ANSI_BOLD          "${ANSI_ESC}[1m")
    set(ANSI_RED           "${ANSI_ESC}[31m")
    set(ANSI_GREEN         "${ANSI_ESC}[32m")
    set(ANSI_YELLWO        "${ANSI_ESC}[33m")
    set(ANSI_BLUE          "${ANSI_ESC}[34m")
    set(ANSI_MAGENTA       "${ANSI_ESC}[35m")
    set(ANSI_CYAN          "${ANSI_ESC}[36m")
    set(ANSI_WHITE         "${ANSI_ESC}[37m")
    set(ANSI_BOLD_RED      "${ANSI_ESC}[1;31m")
    set(ANSI_BOLD_GREEN    "${ANSI_ESC}[1;32m")
    set(ANSI_BOLD_YELLOW   "${ANSI_ESC}[1;33m")
    set(ANSI_BOLD_BLUE     "${ANSI_ESC}[1;34m")
    set(ANSI_BOLD_MAGENTA  "${ANSI_ESC}[1;35m")
    set(ANSI_BOLD_CYAN     "${ANSI_ESC}[1;36m")
    set(ANSI_BOLD_WHITE    "${ANSI_ESC}[1;37m")

endif ()

# ------------------------------------------------------------------------------

function(print_msg MESSAGE)

    if ("${MESSAGE}" STREQUAL "")
        message(STATUS "")
    else ()
        message(STATUS "<myproject> ${ANSI_BOLD}${MESSAGE}${ANSI_RESET}")
    endif ()

endfunction ()

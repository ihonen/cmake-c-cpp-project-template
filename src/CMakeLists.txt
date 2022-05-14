add_executable(myproject
    app/main.cc
)
target_include_directories(myproject
    PRIVATE ${CMAKE_SOURCE_DIR}/include/myproject
    PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
)
target_link_libraries(myproject
)

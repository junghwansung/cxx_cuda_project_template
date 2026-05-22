function(set_project_warnings target)
    set(WARNINGS
        -Wall
        -Wextra
        -Wpedantic
        -Wshadow
        -Wcast-align
        -Wunused
        -Wconversion
        -Wsign-conversion
        -Wnull-dereference
        -Wdouble-promotion
        -Wformat=2
    )

    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        list(APPEND WARNINGS
            -Wmisleading-indentation
            -Wduplicated-cond
            -Wlogical-op
        )
    endif()

    target_compile_options(${target} INTERFACE ${WARNINGS})
endfunction()

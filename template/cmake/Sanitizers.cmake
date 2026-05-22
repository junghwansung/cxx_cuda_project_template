function(enable_sanitizers target)
    if(NOT (CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU"))
        return()
    endif()

    option(ENABLE_ASAN  "Enable AddressSanitizer"           OFF)
    option(ENABLE_UBSAN "Enable UndefinedBehaviorSanitizer" OFF)
    option(ENABLE_TSAN  "Enable ThreadSanitizer"            OFF)

    if(ENABLE_ASAN AND ENABLE_TSAN)
        message(FATAL_ERROR "ASan과 TSan은 동시에 사용할 수 없습니다.")
    endif()

    set(SANITIZERS "")
    if(ENABLE_ASAN)
        list(APPEND SANITIZERS "address")
    endif()
    if(ENABLE_UBSAN)
        list(APPEND SANITIZERS "undefined")
    endif()
    if(ENABLE_TSAN)
        list(APPEND SANITIZERS "thread")
    endif()

    if(NOT SANITIZERS)
        return()
    endif()

    list(JOIN SANITIZERS "," SANITIZERS_STR)
    target_compile_options(${target} INTERFACE
        -fsanitize=${SANITIZERS_STR}
        -fno-omit-frame-pointer
    )
    target_link_options(${target} INTERFACE
        -fsanitize=${SANITIZERS_STR}
    )
endfunction()

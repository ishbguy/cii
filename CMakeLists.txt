# project informations
cmake_minimum_required(VERSION 3.2)
project(cii
    VERSION 2.0.0
    DESCRIPTION
    "C Interfaces and Implementations: Techniques for Creating Reusable Software
    (Addison-Wesley Professional Computing Series, 1997, ISBN 0-201-49841-3)"
    HOMEPAGE_URL "https://github.com/ishbguy/cii"
    LANGUAGES C
    )

# variables
set(cii_sources
    src/ap.c
    src/arena.c
    src/arith.c
    src/array.c
    src/assert.c
    src/atom.c
    src/bit.c
    src/chan.c
    src/except.c
    src/fmt.c
    src/list.c
    src/memcmp.c
    src/memmove.c
    src/mp.c
    src/ring.c
    src/seq.c
    src/set.c
    src/stack.c
    src/str.c
    src/strerror.c
    src/strncmp.c
    src/swtch.s
    src/table.c
    src/text.c
    src/xp.c
    )
set(cii_headers
    include/ap.h
    include/arena.h
    include/arith.h
    include/array.h
    include/arrayrep.h
    include/assert.h
    include/atom.h
    include/bit.h
    include/chan.h
    include/except.h
    include/fmt.h
    include/list.h
    include/mem.h
    include/mp.h
    include/ring.h
    include/sem.h
    include/seq.h
    include/set.h
    include/stack.h
    include/str.h
    include/table.h
    include/text.h
    include/xp.h
    )
if(MAKE_THREAD)
    if(WIN32)
        list(APPEND cii_sources src/thread-nt.c)
    else()
        list(APPEND cii_sources src/thread.c)
    endif()
    list(APPEND cii_headers include/thread.h)
endif()

if(MAKE_MEMCHK)
    list(APPEND cii_sources src/memchk.c)
else()
    list(APPEND cii_sources src/mem.c)
endif()

# compile flags
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall")
include_directories(include)
set(CMAKE_INSTALL_PREFIX /usr)
set(cii_install_lib_dir ${CMAKE_INSTALL_PREFIX}/lib)
set(cii_install_include_dir ${CMAKE_INSTALL_PREFIX}/include/${PROJECT_NAME})

# targets and outputs
add_library(${PROJECT_NAME} SHARED ${cii_sources})
set_target_properties(${PROJECT_NAME} PROPERTIES
    INTERFACE_POSITION_INDEPENDENT_CODE ON
    PUBLIC_HEADER "${cii_headers}"
    )
configure_file(${PROJECT_NAME}.pc.in ${PROJECT_NAME}.pc @ONLY)

# installations
install(TARGETS ${PROJECT_NAME}
    LIBRARY DESTINATION lib
    PUBLIC_HEADER DESTINATION include/${PROJECT_NAME}
    )
install(FILES ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.pc
    DESTINATION lib/pkgconfig
    )

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

# options
option(WITH_THREAD "Build cii with thread support." OFF)
option(USE_MEMCHK "Build cii use memchk instead of mem." OFF)
option(BUILD_SHARED_LIBS "Build cii as a shared library." ON)

# variables
file(GLOB_RECURSE ${PROJECT_NAME}_sources CONFIGURE_DEPENDS src/*.c src/*.s)
list(FILTER ${PROJECT_NAME}_sources EXCLUDE REGEX src/thread.*)
list(FILTER ${PROJECT_NAME}_sources EXCLUDE REGEX "src/mem(chk)?\.c")
list(APPEND ${PROJECT_NAME}_sources $<IF:$<BOOL:${USE_MEMCHK}>,src/memchk.c,src/mem.c>)
file(GLOB_RECURSE ${PROJECT_NAME}_headers CONFIGURE_DEPENDS include/*.h)
list(FILTER ${PROJECT_NAME}_headers EXCLUDE REGEX include/thread.*)
if(WITH_THREAD)
    list(APPEND ${PROJECT_NAME}_sources $<IF:$<BOOL:${WIN32}>,src/thread-nt.c,src/thread.c>)
    list(APPEND ${PROJECT_NAME}_headers include/thread.h)
endif()

# compile flags
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wno-discarded-qualifiers")
include_directories(include)
set(CMAKE_INSTALL_PREFIX /usr)
set(${PROJECT_NAME}_install_lib_dir ${CMAKE_INSTALL_PREFIX}/lib)
set(${PROJECT_NAME}_install_include_dir ${CMAKE_INSTALL_PREFIX}/include/${PROJECT_NAME})

# targets and outputs
add_library(${PROJECT_NAME}
    ${${PROJECT_NAME}_sources}
    ${${PROJECT_NAME}_headers}
    )
set_target_properties(${PROJECT_NAME} PROPERTIES
    INTERFACE_POSITION_INDEPENDENT_CODE ON
    SOVERSION ${PROJECT_VERSION}
    PUBLIC_HEADER "${${PROJECT_NAME}_headers}"
    )
configure_file(${PROJECT_NAME}.pc.in ${PROJECT_NAME}.pc @ONLY)

# installations
install(TARGETS ${PROJECT_NAME}
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    PUBLIC_HEADER DESTINATION include/${PROJECT_NAME}
    )
install(FILES ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.pc
    DESTINATION lib/pkgconfig
    )

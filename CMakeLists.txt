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
option(BUILD_SHARED_LIBS "Build ${PROJECT_NAME} as a shared library." ON)
option(WITH_THREAD "Build ${PROJECT_NAME} with thread support." OFF)
option(USE_MEMCHK "Build ${PROJECT_NAME} use memchk instead of mem." OFF)
option(MAKE_EXAMPLE "Build ${PROJECT_NAME} examples." OFF)
option(MAKE_MISC "Build ${PROJECT_NAME} misc executable." OFF)
option(MAKE_TEST "Build ${PROJECT_NAME} tests" OFF)

# variables
# set(CMAKE_BUILD_TYPE "Release")
set(CMAKE_INSTALL_PREFIX /usr)
set(${PROJECT_NAME}_install_library_dir ${CMAKE_INSTALL_PREFIX}/lib)
set(${PROJECT_NAME}_install_include_dir ${CMAKE_INSTALL_PREFIX}/include/${PROJECT_NAME})

# compile flags
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wno-discarded-qualifiers")
include_directories(include)

add_subdirectory(src)

if(${MAKE_TEST})
    enable_testing()
    add_subdirectory(test)
endif()
if(${MAKE_EXAMPLE})
    add_subdirectory(examples)
endif()
if(${MAKE_MISC})
    add_subdirectory(misc)
endif()

# installations
configure_file(${PROJECT_NAME}.pc.in ${PROJECT_NAME}.pc)
install(FILES ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.pc
    DESTINATION lib/pkgconfig
    )

# custom targets
set(manifest ${CMAKE_BINARY_DIR}/install_manifest.txt)
if(EXISTS ${manifest})
    file(STRINGS ${manifest} install_files)
else()
    set(install_files "")
endif()
add_custom_target(uninstall
    COMMAND "${CMAKE_COMMAND}" -E remove ${install_files}
    OUTPUT_VARIABLE stdout
    )

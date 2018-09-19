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

# variables
set(CMAKE_INSTALL_PREFIX /usr)
set(${PROJECT_NAME}_install_library_dir ${CMAKE_INSTALL_PREFIX}/lib)
set(${PROJECT_NAME}_install_include_dir ${CMAKE_INSTALL_PREFIX}/include/${PROJECT_NAME})

# compile flags
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wno-discarded-qualifiers")
include_directories(include)

add_subdirectory(src)

# installations
configure_file(${PROJECT_NAME}.pc.in ${PROJECT_NAME}.pc)
install(FILES ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.pc
    DESTINATION lib/pkgconfig
    )

add_custom_target(uninstall
    COMMAND xargs rm <${CMAKE_BINARY_DIR}/install_manifest.txt
    )

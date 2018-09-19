# variables
file(GLOB_RECURSE ${PROJECT_NAME}_sources CONFIGURE_DEPENDS *.c *.s)
list(FILTER ${PROJECT_NAME}_sources EXCLUDE REGEX thread.*)
list(FILTER ${PROJECT_NAME}_sources EXCLUDE REGEX "mem(chk)?\.c")
list(APPEND ${PROJECT_NAME}_sources $<IF:$<BOOL:${USE_MEMCHK}>,memchk.c,mem.c>)

file(GLOB_RECURSE ${PROJECT_NAME}_headers CONFIGURE_DEPENDS ${CMAKE_SOURCE_DIR}/include/*.h)
list(FILTER ${PROJECT_NAME}_headers EXCLUDE REGEX thread.*)

if(WITH_THREAD)
    list(APPEND ${PROJECT_NAME}_sources $<IF:$<BOOL:${WIN32}>,thread-nt.c,thread.c>)
    list(APPEND ${PROJECT_NAME}_headers ${CMAKE_SOURCE_DIR}/include/thread.h)
endif()

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

# installations
install(TARGETS ${PROJECT_NAME}
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    PUBLIC_HEADER DESTINATION include/${PROJECT_NAME}
    )

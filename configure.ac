#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([cii], [2.0], [ishbguy@hotmail.com])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([foreign -Wall])
#AC_CONFIG_SRCDIR([include/table.h])
AC_CONFIG_HEADERS([config.h])

# Checks for programs.
AC_PROG_CC
AM_PROG_AR
AC_PROG_RANLIB

# Checks for libraries.
# AC_CHECK_LIB([LIB], [FUNC], [IF_FOUND_ACT], [IF_NOT_FOUND_ACT])

# Checks for header files.
AC_CHECK_HEADERS([float.h limits.h stddef.h stdlib.h string.h sys/time.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_SIZE_T

# Checks for library functions.
AC_FUNC_MALLOC
AC_FUNC_REALLOC
AC_CHECK_FUNCS([memchr memmove memset strchr strerror])

AC_CONFIG_FILES([Makefile src/Makefile])
AC_OUTPUT

dnl a macro to check for ability to create python extensions
dnl  AM_CHECK_PYTHON_HEADERS([ACTION-IF-POSSIBLE], [ACTION-IF-NOT-POSSIBLE])
dnl function also defines PYTHON_INCLUDES
AC_DEFUN([AM_CHECK_PYTHON_HEADERS],
[AC_REQUIRE([AM_PATH_PYTHON])
dnl deduce PYTHON_INCLUDES

AC_MSG_CHECKING(for Python headers)
if test "x${am_cv_python_includes}" = x ; then
PYTHON_INCLUDES="`$PYTHON -c "import sys, sysconfig; sys.stdout.write(sysconfig.get_path('include'))"`"
else
PYTHON_INCLUDES="${am_cv_python_includes}"
fi
AC_MSG_RESULT($PYTHON_INCLUDES)

AC_MSG_CHECKING(whether those headers are sufficient)
AC_SUBST(PYTHON_INCLUDES)
dnl check if the headers exist:
save_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="$CPPFLAGS -I$PYTHON_INCLUDES"
AC_TRY_CPP([#include <Python.h>],dnl
[AC_MSG_RESULT(yes)
$1],dnl
[AC_MSG_RESULT(no)
$2])
CPPFLAGS="$save_CPPFLAGS"
])

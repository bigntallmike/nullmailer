dnl TRY_CXX_FLAG(FLAG,[ACTION-IF-FOUND[,ACTION-IF-NOT-FOUND]])
AC_DEFUN(TRY_CXX_FLAG,
[echo >conftest.cc
if ${CXX-g++} ${CXXFLAGS} -c [$1] conftest.cc >/dev/null 2>&1; then
  ifelse([$2], , :, [rm -f conftest*
  $2])
else
  ifelse([$3], , :, [rm -f conftest*
  $3])
fi
rm -f conftest*])

AC_DEFUN(CXX_NO_RTTI,
[AC_CACHE_CHECK(whether ${CXX-g++} accepts -fno-rtti,
	local_cv_flag_NO_RTTI,
	TRY_CXX_FLAG(-fno-rtti,
		local_cv_flag_NO_RTTI=yes,
		local_cv_flag_NO_RTTI=no))
test "$local_cv_flag_NO_RTTI" = yes && CXXFLAGS="$CXXFLAGS -fno-rtti"
])

AC_DEFUN(CXX_NO_EXCEPTIONS,
[AC_CACHE_CHECK(whether ${CXX-g++} accepts -fno-exceptions,
	local_cv_flag_NO_EXCEPTIONS,
	TRY_CXX_FLAG(-fno-exceptions,
		local_cv_flag_NO_EXCEPTIONS=yes,
		local_cv_flag_NO_EXCEPTIONS=no))
test "$local_cv_flag_NO_EXCEPTIONS" = yes && CXXFLAGS="$CXXFLAGS -fno-exceptions"
])

dnl TRY_STRUCT_TM_MEMBER(MEMBER,FLAGNAME)
AC_DEFUN(TRY_STRUCT_TM_MEMBER,
[ AC_CACHE_CHECK(whether struct tm contains [$1],
	[$2],
	cat >conftest.c <<EOF
#if TIME_WITH_SYS_TIME
# include <sys/time.h>
# include <time.h>
#else
# if HAVE_SYS_TIME_H
#  include <sys/time.h>
# else
#  include <time.h>
# endif
#endif
int main() { struct tm* foo; foo->[$1]; }
EOF
	if ${CC} ${CFLAGS} -c conftest.c >/dev/null 2>&1; then
		[$2]=yes
	else
		[$2]=no
	fi
	rm -f conftest*)
])

AC_DEFUN(TEST_STRUCT_TM,
	TRY_STRUCT_TM_MEMBER(tm_isdst, local_cv_flag_TM_HAS_ISDST)
	TRY_STRUCT_TM_MEMBER(__tm_isdst, local_cv_flag_TM_HAS___ISDST)
	if test "$local_cv_flag_TM_HAS_ISDST" = yes
	then AC_DEFINE(TM_HAS_ISDST,tm_isdst)
	elif test "$local_cv_flag_TM_HAS___ISDST" = yes
	then AC_DEFINE(TM_HAS_ISDST,__tm_isdst)
	fi
	TRY_STRUCT_TM_MEMBER(tm_gmtoff, local_cv_flag_TM_HAS_GMTOFF)
	TRY_STRUCT_TM_MEMBER(__tm_gmtoff, local_cv_flag_TM_HAS___GMTOFF)
	if test "$local_cv_flag_TM_HAS_GMTOFF" = yes
	then AC_DEFINE(TM_HAS_GMTOFF,tm_gmtoff)
	elif test "$local_cv_flag_TM_HAS___GMTOFF" = yes
	then AC_DEFINE(TM_HAS_GMTOFF,__tm_gmtoff)
	fi
)
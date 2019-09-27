#ifndef _DEBUG_HPP
#define _DEBUG_HPP

#include <stdio.h>

namespace Debug
{
	#define DBG_VERBOSE 1
	#define DBG_TERSE   2
	#define DBG_WARNING 3
	#define DBG_ERROR   4

    bool DbgPrint(const wchar_t * lpszFormatString, ...);
    bool DbgPrintEx(int level,  const wchar_t * prefix, const wchar_t * lpszFormatString, ...);
    bool vDbgPrint(const wchar_t *  lpszFormatString, va_list args);
    bool vDbgPrintEx(int level,  const wchar_t * prefix, const wchar_t * lpszFormatString, va_list args);

}

#endif // _DEBUG_HPP

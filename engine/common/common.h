/**
 * Common.h - Contains Common header
 *
 * (C) bSoft Groups LLC, 2013
 */

#pragma once

#include <math.h>

#include <string>

namespace Common
{

std::wstring utf8_to_wstring(const std::string& str);
std::string wstring_to_utf8(const std::wstring& str);

// C helpers
#define stringify( name ) L#name

void toString(const size_t input, wchar_t* output, size_t *size); // size_t to char *
void toString(const int input, wchar_t* output, size_t *size); // int to char *
void toString(const unsigned int input, wchar_t* output, size_t *size); // int to char *
void toString(const unsigned long input, wchar_t* output, size_t *size);
void toString(const double input, wchar_t* output, size_t *size); // float to char *

// C++ helper for all helpers
template <typename T, int buf_size> std::wstring toString(const T & input)
{
	wchar_t buf[buf_size] = {0};
	size_t size = sizeof(buf);
	toString(input, buf, &size);
	std::wstring out;
	out.assign(buf, size);
	return out;
}

// Converting between unicode / ANSI
std::string toMultiByte(const std::wstring &input);

// Converting between ANSI / unicode
std::wstring toWideChar(const std::string & input, int codePage = 65001);

std::wstring toCodePage(const std::wstring & input, const char * fromCodePage, const char * toCodePage);

std::wstring wsformat(const wchar_t * format, ...);
std::string sformat(const char * format, ...);

void split(const std::string& , std::vector<std::string>& , const std::string& );
void replaceAll(std::string& source, const std::string& from, const std::string& to);
inline std::string trim_right_copy(
  const std::string& s,
  const std::string& delimiters = " \f\n\r\t\v" )
{
  return s.substr( 0, s.find_last_not_of( delimiters ) + 1 );
}

inline std::string trim_left_copy(
  const std::string& s,
  const std::string& delimiters = " \f\n\r\t\v" )
{
  return s.substr( s.find_first_not_of( delimiters ) );
}

inline std::string trim_copy(
  const std::string& s,
  const std::string& delimiters = " \f\n\r\t\v" )
{
  return trim_left_copy( trim_right_copy( s, delimiters ), delimiters );
}

int * decode_hex(std::string );

}

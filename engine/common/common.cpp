/**
 * Common.cpp - Contains Common impl
 *
 * (C) bSoft Groups LLC, 2013
 */


#include "stdafx.h"

#include <utf8.h>

#include <iconv.h>


namespace Common
{

// old

void toString(const size_t input, wchar_t* output, size_t *size)
{
	assert(output != NULL && size != NULL);
	*size = swprintf(output, *size, L"%d", input);
}

void toString(const int input, wchar_t* output, size_t *size)
{
	assert(output != NULL && size != NULL);
	*size = swprintf(output, *size, L"%d", input);
}

void toString(const unsigned long input, wchar_t* output, size_t *size)
{
	assert(output != NULL && size != NULL);
	*size = swprintf(output, *size, L"%d", input);
}

void toString(const double input, wchar_t* output, size_t *size)
{
	assert(output != NULL && size != NULL);
	*size = swprintf(output, *size, (input - floor(input) == 0) ? L"%0.f" : L"%4.3f", input);
}

std::string toMultiByte(const std::wstring &input)
{
	std::string out;
	size_t src_len = input.size();
	if(src_len<=0)
		return out;

	utf8::utf16to8(input.begin(), input.end(), back_inserter(out));
	return out;


  const int codePage = 1251; // CP_UTF8
  // int multiByteLen = WideCharToMultiByte(codePage, 0, input.c_str(), input.size(), NULL, 0, NULL, NULL);
  int multiByteLen = 1000;
  char * multiByteBuf = new char[multiByteLen+1];
  memset(multiByteBuf, 0, multiByteLen+1);
  // WideCharToMultiByte(codePage, 0, input.c_str(), input.size(), multiByteBuf, multiByteLen, NULL, NULL );

  size_t numConverted = 0;
  errno_t error = wcstombs_s(&numConverted, multiByteBuf, multiByteLen, input.c_str(), input.length());

  out = multiByteBuf;
  delete [] multiByteBuf;
  return out;
}

std::wstring toWideChar(const std::string &input, int codePage)
{
	std::wstring out;
  
	// if(codePage == 65001)
	{
		utf8::utf8to16(input.begin(), input.end(), std::back_inserter(out));
		// std::copy(input.begin(), input.end(), out.begin());
		return out;
	}

	int wideCharLen = (input.length()+1)*sizeof(wchar_t);

	size_t src_len = input.size();
	if(src_len<=0)
		return out;
	
	const char * src_ptr = input.c_str();

	size_t dst_len = src_len*2;
  char * dst_ptr = new char[dst_len];
  memset(dst_ptr, 0, dst_len * sizeof(char));

  if(codePage == 1251)
  {
	  //size_t old_len = dst_len;
	  //iconv_t conv = iconv_open("CP1251","UTF-8");
	  //size_t res = iconv(conv, &src_ptr, &src_len, &dst_ptr, &dst_len);
	  //iconv_close(conv);
	  //dst_ptr -= (old_len - dst_len);
  }

  wchar_t * wideCharBuf = new wchar_t[wideCharLen];
  memset(wideCharBuf, 0, wideCharLen * sizeof(wchar_t));

  //utf8::utf8to16(input.begin(), input.end(), back_inserter(out));
  //return out;

  // const int codePage = 65001; // CP_UTF8

  // out = input.length();
  size_t numConverted = 0;
  int outLen = mbstowcs_s(&numConverted, wideCharBuf, wideCharLen, dst_ptr, dst_len);

  // MultiByteToWideChar(codePage, 0, input.c_str(), input.length(), wideCharBuf, wideCharLen );
  out = wideCharBuf;
  delete[] dst_ptr;
  delete[] wideCharBuf;
  return out;


  // mbstowcs_s(&numConverted, wideCharBuf, 1000, input.c_str(), input.length());
  // return std::wstring(wideCharBuf);
}

std::wstring toCodePage(const std::wstring & input, const char * fromCodePage, const char * toCodePage)
{
  const wchar_t * src_ptr = input.c_str();
	size_t src_len = input.size();

	size_t dst_len = src_len;
	wchar_t * dst_ptr = new wchar_t[dst_len];
	memset(dst_ptr, 0, dst_len * sizeof(wchar_t));

	size_t old_len = dst_len;
	iconv_t conv = iconv_open(toCodePage,fromCodePage);
    size_t res = iconv(conv, (char **)&src_ptr, &src_len, (char **)&dst_ptr, &dst_len);
	iconv_close(conv);
	dst_ptr -= (old_len - dst_len);

	std::wstring out(dst_ptr);
	return out;
}

std::wstring wsformat(const wchar_t * format, ...)
{
  va_list args;
    va_start(args, format);
  size_t len = _vscwprintf( format, args )+1;
    wchar_t * buffer = (wchar_t*)malloc( len * sizeof(wchar_t) );
    vswprintf(buffer, len, format, args);
  std::wstring result(buffer);
  free(buffer);
  return result;
}

std::string sformat(const char * format, ...) {
    va_list args;
    va_start(args, format);
    size_t len = _vscprintf( format, args )+1;
    char * buffer = new char[len]; /* Wrap the plain char array into the unique_ptr */
    vsnprintf_s(buffer, len, len, format, args);
    std::string result(buffer);
    va_end(args);
    return result;
}


void split(const std::string& str, std::vector<std::string>& tokens, const std::string& delimiters = " ")
{
    // Skip delimiters at beginning.
    //std::string::size_type lastPos = str.find_first_not_of(delimiters, 0);
	std::string::size_type lastPos = 0;
    // Find first "non-delimiter".
    std::string::size_type pos     = str.find_first_of(delimiters, lastPos);

    while (std::string::npos != pos || std::string::npos != lastPos)
    {
        // Found a token, add it to the vector.
        tokens.push_back(str.substr(lastPos, pos - lastPos));
        // Skip delimiters.  Note the "not_of"
        lastPos = str.find_first_not_of(delimiters, pos);
        // Find next "non-delimiter"
        pos = str.find_first_of(delimiters, lastPos);
    }
}

void replaceAll(std::string& source, const std::string& from, const std::string& to)
{
    std::string newString;
    newString.reserve(source.length());  // avoids a few memory allocations

    std::string::size_type lastPos = 0;
    std::string::size_type findPos;

    while(std::string::npos != (findPos = source.find(from, lastPos)))
    {
        newString.append(source, lastPos, findPos - lastPos);
        newString += to;
        lastPos = findPos + from.length();
    }

    // Care for the rest after last occurrence
    newString += source.substr(lastPos);

    source.swap(newString);
}

int * decode_hex(std::string str)
{
	int * result = new int[str.length() / 2];
    for(size_t i=0; i< str.length(); i+=2)
	{
		std::string byte = str.substr(i,2);
		char chr = (char) (int)strtol(byte.c_str(), NULL, 16);
		result[i/2];
	}
	return result;
}

}

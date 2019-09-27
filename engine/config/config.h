/**
 * Config.h - Contain the registry configuration
 *
 * (C) bSoft Groups LLC, 2013
 */


#pragma once


namespace Config
{


// implement this function in projects-specific code
const std::wstring getConfigFileName();
const std::wstring getProductName();
const std::string getProductPrivateKey();

int getIntValue(const std::wstring &section, const std::wstring &entry, const int default_);
void setIntValue(const std::wstring &section, const std::wstring &entry, const int value);
std::wstring getWStringValue(const std::wstring &section, const std::wstring &entry, const std::wstring &default_);
void setWStringValue(const std::wstring &section, const std::wstring &entry, const std::wstring value);

std::string getStringValue(const std::wstring &section, const std::wstring &entry, const std::string &default_);
void setStringValue(const std::wstring &section, const std::wstring &entry, const std::string value);

}

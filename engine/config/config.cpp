/**
 * Config.h - Contain the registry configuration
 *
 * (C) bSoft Groups LLC, 2013
 */


#include "stdafx.h"

#include <SimpleIni.h>

namespace Config
{


int getIntValue(const std::wstring &section, const std::wstring &entry, const int default_)
{
    int res = default_;
	try
	{
        CSimpleIniA ini;
        ini.SetUnicode();

        if(ini.LoadFile(getConfigFileName().c_str())>=0)
		{
            res = ini.GetLongValue(Common::toMultiByte(section).c_str(), Common::toMultiByte(entry).c_str(), default_ );
		}
	}
	catch(std::exception & e)
	{
        Debug::DbgPrint(L"Error - parse int %s\\%s : %s\n", section.c_str(), entry.c_str(), Common::toWideChar(e.what()).c_str() );
	}
	return res;
}

void setIntValue(const std::wstring &section, const std::wstring &entry, const int value)
{
	try
	{
        CSimpleIniA ini;
        ini.SetUnicode();

        SI_Error err = ini.LoadFile(getConfigFileName().c_str());
        if(err>=0)
        // if(ini.LoadFile(getConfigFileName().c_str())>=0)
        {
            ini.SetLongValue(Common::toMultiByte(section).c_str(), Common::toMultiByte(entry).c_str(), value);
            ini.SaveFile(getConfigFileName().c_str());
		}
	}
	catch(std::exception & e)
	{
        Debug::DbgPrint(L"Error - set int %s\\%s : %s\n", section.c_str(), entry.c_str(), Common::toWideChar(e.what()).c_str() );
    }
}

std::wstring getWStringValue(const std::wstring &section, const std::wstring &entry, const std::wstring &default_)
{
    return Common::toWideChar(getStringValue(section, entry, Common::toMultiByte(default_)), 65001);
}

void setWStringValue(const std::wstring &section, const std::wstring &entry, const std::wstring value)
{
    setStringValue(section, entry, Common::toMultiByte(value));
}

std::string getStringValue(const std::wstring &section, const std::wstring &entry, const std::string &default_)
{
    std::string res = default_;
	try
	{
        CSimpleIniA ini;
        ini.SetUnicode();

        // std::ifstream ini(getConfigFileName, std::ifstream::binary);
        if(ini.LoadFile(getConfigFileName().c_str())>=0)
        {
            res = ini.GetValue(Common::toMultiByte(section).c_str(), Common::toMultiByte(entry).c_str(), default_.c_str() );
            if(res.length()==0)
              res = default_;
            // res = reader.GetInteger(Common::toMultiByte(section), Common::toMultiByte(entry), default_ );
            // res = (int)jsroot[Common::toMultiByte(BASE_APP_KEY)][].get(Common::toMultiByte(entry), default_).asInt();
        }
	}
	catch(std::exception & e)
	{
        Debug::DbgPrint(L"Error - parse string %s\\%s : %s\n", section.c_str(), entry.c_str(), Common::toWideChar(e.what()).c_str() );
	}
	return res;
}

void setStringValue(const std::wstring &section, const std::wstring &entry, const std::string value)
{
	try
	{
        CSimpleIniA ini;
        ini.SetUnicode();

        ini.LoadFile(getConfigFileName().c_str());
        ini.SetValue(Common::toMultiByte(section).c_str(), Common::toMultiByte(entry).c_str(), value.c_str());
        SI_Error err = ini.SaveFile(getConfigFileName().c_str());
        if(err>=0)
        {
        }
    }
	catch(std::exception & e)
	{
        Debug::DbgPrint(L"Error - set string %s\\%s : %s\n", section.c_str(), entry.c_str(), Common::toWideChar(e.what()).c_str() );
	}
}

}

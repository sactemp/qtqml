#include "stdafx.h"

#include <QtDebug>
#include <QString>
#include <QFile>

namespace Debug
{


bool DbgPrint(const wchar_t * lpszFormatString, ...)
{
    va_list VAList;
    va_start(VAList, lpszFormatString);
    bool res = vDbgPrintEx(DBG_VERBOSE, L"", lpszFormatString, VAList);
    va_end(VAList);
    return res;
}


bool DbgPrintEx(int level, const wchar_t * prefix, const wchar_t * lpszFormatString,...)
{
    va_list VAList;
    va_start(VAList, lpszFormatString);
    bool res = vDbgPrintEx(level, prefix, lpszFormatString, VAList);
    va_end(VAList);
    return res;
}

bool vDbgPrintEx(int level, const wchar_t * prefix, const wchar_t * lpszFormatString, va_list VAList)
{
    QString pref = QString::fromWCharArray(prefix);
    QString fmt = QString::fromWCharArray(lpszFormatString);
    QString fullString = pref + " - " + QString::vasprintf(fmt.toStdString().c_str(), VAList);
    qDebug() << level << fullString;
    QFile file("debug.log");
    if (!file.open(QIODevice::Append | QIODevice::Text))
      return false;
    QTextStream out(&file);
    out << fullString;
    file.close();
    return true;
}

}

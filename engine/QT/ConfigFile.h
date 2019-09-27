#ifndef CONFIG_H
#define CONFIG_H

#include <QObject>
#include <QString>
#include <QDateTime>
#include "../config/config.h"

class ConfigFile: public QObject
{
    Q_OBJECT
public:

    ConfigFile(QObject * parent = nullptr) : QObject(parent) {}

public slots:
    QString getBuildTime() {
      //return  QString(__DATE__) + QString(__TIME__);
      QString ss = QString(__DATE__) + " " + QString(__TIME__);
      QDateTime dt(QDateTime::fromString(ss, "MMMM d yyyy hh:mm:ss"));
      QString ss2 = dt.toString("dd-MM-yyyy");
      return ss2;
    }
    int getIntValue(const QString & section, const QString & entry, const int default_)
    {
        return Config::getIntValue(section.toStdWString(), entry.toStdWString(), default_);
    }
    void setIntValue(const QString & section, const QString & entry, const int value)
    {
        Config::setIntValue(section.toStdWString(), entry.toStdWString(), value);
    }
    QString getStringValue(const QString & section, const QString & entry, const QString & default_)
    {
        return QString::fromStdWString(Config::getWStringValue(section.toStdWString(), entry.toStdWString(), default_.toStdWString()));
    }
    void setStringValue(const QString &section, const QString & entry, const QString & value)
    {
        Config::setWStringValue(section.toStdWString(), entry.toStdWString(), value.toStdWString());
    }

};

#endif // CONFIG_H

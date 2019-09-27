#include <QApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <QtQml>

#include <QT/ConfigFile.h>

#include "src/models.h"

namespace Config
{
const std::wstring getConfigFileName()
{
  return L"./driller-test.ini";
}
const std::wstring getProductName(){
  return L"driller-test";
}
const std::string getProductPrivateKey()
{
  return "EYPGrPAlf4lbbhceFnKtkvvXHAguFdHv";
}
}


int main(int argc, char *argv[])
{
  const char * appUri = "com.application";
  QApplication app(argc, argv);

  qmlRegisterType<ConfigFile>("com.components", 1, 0, "ConfigFile");
  qmlRegisterType<Calculator>("com.components", 1, 0, "Calculator");


  QQmlApplicationEngine engine;

  engine.addImportPath("qrc:///");

  engine.rootContext()->setContextProperty("applicationDirPath", app.applicationDirPath());
  QObject::connect(&engine, &QQmlApplicationEngine::quit, &QGuiApplication::quit);

  engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
  if (engine.rootObjects().isEmpty())
    return -1;
  return app.exec();
}

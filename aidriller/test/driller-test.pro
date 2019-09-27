TEMPLATE = app
TARGET = driller-test


QT += qml quick widgets multimedia sql

CONFIG += c++11

PRECOMPILED_HEADER = stdafx.h

#RC_ICONS += ../../assets/images/w16h161349012893pointminus.ico
RC_ICONS += ../../assets/images/icon_d.ico
# // Blackvariant-Button-Ui-App-Pack-One-Lite-Icon.ico

SOURCES += \
  ../../engine/common/common.cpp \
  ../../engine/common/debug-qt.cpp \
  ../../engine/config/config.cpp \
#  ../../lib/jsoncpp/jsoncpp.cpp \
#  ../../engine/time/HPETMeter.cpp \
#  ../../engine/common/md5.cpp \
#  ../../engine/common/base64.cpp \
#  ../../engine/security/Security.cpp \
#  ../../engine/QT/pagination.cpp \
#  ../../engine/QT/FactoryBase.cpp \
#  ../../engine/QT/DSDatabase.cpp \
#  ../../engine/QT/DSSingleFile.cpp \
#  ../../engine/QT/RepositoryBase.cpp \
  main.cpp

HEADERS += \
  ../../engine/QT/ConfigFile.h \
#  ../../engine/QT/BaseObject.h \
#  ../../engine/QT/Error.h \
#  ../../engine/QT/DataSourceBase.h \
#  ../../engine/QT/DSDatabase.h \
#  ../../engine/QT/DSSingleFile.h \
#  ../../engine/QT/pagination.h \
#  ../../engine/QT/QueryParams.h \
#  ../../engine/QT/Registration.h \
#  ../../engine/QT/RepositoryBase.h \
#  ../../engine/Security/Security.h \
#  src/models.h \
  src/models.h \
  stdafx.h \


RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
  ../../engine/QML/BaseItem.qml \
  ../../engine/QML/Button.qml \
  ../../engine/QML/ButtonGroup.qml \
  ../../engine/QML/lib.js \
  ../../engine/QML/qmldir \
  ../../engine/QML/Style.qml \
  ../../engine/QML/TextEdit.qml \
  qml/DataSources.qml \
  qml/View2D.qml \
  qml/main.qml


INCLUDEPATH += "../../engine"
INCLUDEPATH += "../../lib/"
#INCLUDEPATH += "../../lib/jsoncpp"
INCLUDEPATH += "../../lib/simpleini"
INCLUDEPATH += "../../lib/utf8"


#iconv
INCLUDEPATH += "../../lib/libiconv/1.14.3/include"
#LIBS += -L"../../lib/libiconv/1.14.3/lib"
#INCLUDEPATH += "../../lib/libiconv/include"
LIBS *= -L"../../lib/libiconv/lib"
LIBS += -llibiconv

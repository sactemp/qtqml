pragma Singleton

import QtQuick 2.5

import com.components 1.0
// import com.application 1.0

Item {
  property var configFile: ConfigFile {
  }

  property var applicationSettings: QtObject {
    property string path: configFile.getStringValue("common","path", "../InclData.csv")
    onPathChanged: {
      configFile.setStringValue("common","path", path)
    }
  }
  Component.onCompleted: {
  }
}

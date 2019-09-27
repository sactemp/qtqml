import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2

//import "../engine/QML" as MC
import "." // import DataSources.qml as singleton

FileDialog {
  id: wnd
  //width: 500
  //height: 250
  title: "Выберете " + (selectFolder ?  "папку": "файл")
  folder: shortcuts.documents
  // selectFolder: true
  // visible: false

  // color: MC.Style.defaultBackgroundColor
  property var selected: null

  // Component.onCompleted: visible = false

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 20

    ColumnLayout {
      Layout.alignment: Qt.AlignTop
      Layout.fillWidth: true
      Layout.fillHeight: true

      Label {
        Layout.row: 3
        Layout.column: 1
        //text: wnd.auth.status
        color: "#FF0000"
      }
    }
    RowLayout {
      Layout.alignment: Qt.AlignHCenter
    }
  }

  onAccepted: {
    var cleanPath = wnd.fileUrl.toString().replace(/^(file:\/{3})/,"");
    selected(cleanPath)
  }
}

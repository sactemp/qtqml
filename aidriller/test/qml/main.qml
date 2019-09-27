import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0

import com.components 1.0

// import com.application 1.0

import "../engine/QML" as MC
import "../engine/QML/lib.js" as Libs
import "." // import Data.qml as singleton

ApplicationWindow {
  id: mainAppWnd
  property var currentItem

  visible: true
  width: 700
  height: 600
  title: "Расчет траектории, 1.0"

  color: MC.Style.background.defaultColor

  property double koef: 10

  property var calculator: Calculator {
    path: DataSources.applicationSettings.path
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 10

    GroupBox {
      title: "Расчет траектории"
      Layout.fillWidth: true
      Layout.fillHeight: true

      ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5

        MC.TextEdit {
          label.text: qsTr("Файл с данными")
          readOnly: true
          text: DataSources.applicationSettings.path
          inputGroup: MC.Button {
            Layout.minimumWidth: height
            text: "..."
            onClick: {
              var dialog = Libs.createObjectFromComponent(mainAppWnd, "SelectFileFolderDialog.qml", {
                // selectFolder: true,
                nameFilters: ['*.csv'],
                folder: "file:/" + applicationDirPath,
                selected: function(path){
                  DataSources.applicationSettings.path = path
                }
              })
              dialog.open()
            }
          }
        }
        RowLayout {
          MC.Button {
            label.text: "-"
            onClick: mainAppWnd.koef--
          }
          Label {
            text: "koef: " + mainAppWnd.koef
          }

          MC.Button {
            label.text: "+"
            onClick: mainAppWnd.koef++
          }
        }

        GridLayout {
          columns: 2

          View2D {
            Layout.fillWidth: true
            Layout.fillHeight: true

            koef: mainAppWnd.koef
            projectionType: 0
            points: calculator.points
          }
          View2D {
            Layout.fillWidth: true
            Layout.fillHeight: true

            koef: mainAppWnd.koef
            projectionType: 1
            points: calculator.points
          }
          View2D {
            Layout.fillWidth: true
            Layout.fillHeight: true

            koef: mainAppWnd.koef
            projectionType: 2
            points: calculator.points
          }
          View2D {
            Layout.fillWidth: true
            Layout.fillHeight: true

            koef: mainAppWnd.koef
            projectionType: 3
            points: calculator.points
          }
        }
      }
    }
  }
}

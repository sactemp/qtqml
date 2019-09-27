import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.2

import "." // import Style.qml
import "./lib.js" as Libs

ColumnLayout {
  id: root
  property alias label: label
  property alias sourceColor: baseItem.sourceColor
  property alias baseItem: baseItem
  property alias toolTip: baseItem.toolTip
  property alias editText: editText
  //property alias cursorVisible: editText.cursorVisible
  focus: true

  property alias readOnly: editText.readOnly
  property alias text: editText.text
  property alias echoMode: editText.echoMode
  property alias targetObject: baseItem.targetObject
  property alias targetProperty: baseItem.targetProperty
  signal targetPropertyValueChanged(var value)
  property alias validate: baseItem.validate
  property alias validator: editText.validator
  property alias inputGroup: loader.data

  Label {
    font.family: Style.font.name
    font.pixelSize: Style.font.labelSize
    id: label
  }

  RowLayout {
    spacing: 0

    BaseItem {
      id: baseItem
      mouseArea.enabled: false
      Layout.fillWidth: true
      focus: true
      onTargetPropertyValueChanged: root.targetPropertyValueChanged(value)

      TextField {
        id: editText
        anchors.fill: parent

        verticalAlignment: Qt.AlignVCenter
        font.family: Style.font.name
        font.pixelSize: Style.font.h4
        text: targetObject[targetProperty]
        focus: true
        style: TextFieldStyle {
          background: Rectangle {
              color: "transparent"
          }
        }
        Keys.onPressed: editText.forceActiveFocus()
        onTextChanged: {
          baseItem.update(text)
          //console.log(JSON.stringify(validate))
        }

        // backgroundVisible: false

        // textMargin: Style.margins
        // wrapMode: TextEdit.Wrap
      }
    }
    RowLayout {
      id: loader
    }
  }
  //Binding {  target: targetObject; property: targetProperty; value: editText.text }
  //Binding {  target: validate; property: targetProperty; value: editText.text }
  //Component.onCompleted: {
  //    var bindObj = Libs.createBindObject(root, target, propertyName, editText, "text")
  //}
}

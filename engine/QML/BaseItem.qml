import QtQuick 2.0
import QtQuick.Layouts 1.2

import "." as MC // import Style.qml

Rectangle {
  id: root
  Layout.fillWidth: true
  // Layout.fillHeight: true
  Layout.minimumWidth: MC.Style.minimumWidth
  Layout.preferredHeight: MC.Style.preferredHeight
  radius: MC.Style.radius
  clip: false

  property alias toolTip: toolTipText
  property bool showToolTip: false
  // property var enabled: true
  property var targetObject
  property var targetProperty
  signal targetPropertyValueChanged(var value)

  property alias mouseArea: mouseArea
  property alias cursorShape: mouseArea.cursorShape

  property real ttmx: 0
  property real ttmy: 0

  property var sourceColor: (enabled ? MC.Style.background.colorEnabled : MC.Style.background.colorDisabled)
  color: sourceColor

  property var validate: null

  property var validateState: (targetObject && targetProperty && validate) ? validate.validate(targetProperty, targetObject[targetProperty]): true
  border {
    color: validateState ? MC.Style.border.color : "red"
    width: validateState ? MC.Style.border.width : "2"
  }


  function update(v) {
    if(validate && validate.validate) {
      // console.log(555, validate.validate)
      validateState = validate.validate(targetProperty, v)
    }
    if(targetObject && targetProperty && v)
    {
      //console.log(JSON.stringify(targetObject), targetProperty, v)
      targetObject[targetProperty] = v
      root.targetPropertyValueChanged(v)
    }
    //console.log(1111111111111111, JSON.stringify(validate), targetProperty, v)
    //return validate[targetProperty] ? validate[targetProperty].state: false
  }
  Item {
    id: toolTip
    anchors.fill: parent
  }
  Rectangle {
    // anchors.fill: parent
    id: toolTipRectangle
    // anchors.horizontalCenter: parent.horizontalCenter
    // anchors.top: parent.bottom
    x: ttmx
    y: ttmy
    width: toolTipText.width + 20
    height: toolTipText.height + 10
    z: root.z + 1
    color: "#ffffaa"
    // border.width: 2
    // border.color: "#0a0a0a"
    visible: toolTipText.text !== "" && showToolTip
    Text {
      anchors.centerIn: parent
      anchors.margins: 10
      id: toolTipText
      color: "black"
    }
    Behavior on visible { NumberAnimation { duration: 200 }}
  }
  MouseArea{
    id: mouseArea
    anchors.fill: parent
    onClicked: parent.click && parent.click()
    hoverEnabled: true
    enabled: true

    onPressed: { parent.color = MC.Style.darker(sourceColor, MC.Style.koefPressed) }
    onReleased: { parent.color = MC.Style.darker(sourceColor, MC.Style.koefHover) }
    onEntered: {
      showTimer.start()
      parent.color = MC.Style.darker(sourceColor, MC.Style.koefHover)
    }
    onExited: {
      showToolTip = false; showTimer.stop();
      parent.color = sourceColor
    }
    onPositionChanged: {
      showTimer.stop()
      showTimer.start()
      // var obj = root.mapToItem()
      ttmx = mouseX
      ttmy = mouseY
    }
  }
//  ToolTip {
//      text: "fafafsda"
//      target: root
//      width: 150
//      id: tooltip1
//  }
  Timer {
    id: showTimer
    interval: 500
    onTriggered: {
      toolTipRectangle.x = ttmx - ((ttmx + toolTipText.width)>root.width? ttmx + toolTipText.width + 10 - root.width : toolTipText.width / 2)
      toolTipRectangle.y = ttmy - 18 // * ((ttmy + toolTipText.height)>root.height ? -1: 1)
      showToolTip = true;
    }
  }
}

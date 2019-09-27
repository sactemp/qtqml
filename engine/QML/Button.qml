import QtQuick 2.5
import QtQuick.Layouts 1.2

import "." as MC // import Style.qml

BaseItem {
  id: root

  Layout.fillWidth: false

  property alias label: buttonLabel
  property alias text: buttonLabel.text
  property alias source: idImage.source
  focus: true

  signal click

  RowLayout {
    anchors.margins: 5
    anchors.fill: parent
    spacing: 0

    Image {
      id: idImage
      smooth: true
      mipmap: true
      visible: source.toString().length>0

      Layout.preferredWidth: parent.height
      Layout.preferredHeight: parent.height
    }
    Text {
      Layout.fillWidth: true
      id: buttonLabel
      color: enabled ? MC.Style.font.defaultColor: MC.Style.font.colorDisabled
      font.pixelSize: MC.Style.font.h5
      wrapMode: Text.WordWrap
      horizontalAlignment: Text.AlignHCenter
      // Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    }

//    RowLayout {
//    }

    //ToolTip.visible: pressed
    //ToolTip.delay: Qt.styleHints.mousePressAndHoldInterval
  }
}

pragma Singleton
import QtQuick 2.0

QtObject {
  property int margins: 4
  property int radius: 4
  property int spacing: 20

  property int minimumWidth: 150
  property int minimumHeight: 32
  property int preferredWidth: 32
  property int preferredHeight: 32

  // property string defaultBackgroundColor: "#f0a0c0"
  property string baseColor: "#f7f7ff"      // gray
  property string baseColor1: "#FA6800" // yellow
  property string baseColor2: "#3CB371" // green
  property string baseColor3: "#AFEEEE" // aqua

  property string defaultBackgroundColor2: darker(baseColor, 1.1)

  property QtObject font: QtObject {
    property string name: "Arial"
    property int h1: 24
    property int h2: 20
    property int h3: 16
    property int h4: 14
    property int h5: 12
    property int labelSize: 13
    property string defaultColor: "#000000"
    property string colorDisabled: "#808080"
  }
  property string dimmedFontColor: "#BBBBBB"

  property QtObject border: QtObject {
    property string color: "#000000"
    property int width: 1
  }

  property real koefSelected: 1.5
  property real koefPressed: 1.5
  property real koefHover: 1.2

  function darker(color, koef) {
    return Qt.darker(color, koef)
  }
  function lighter(color, koef) {
    return Qt.lighter(color, koef)
  }

  property QtObject background: QtObject {
    property string defaultColor: baseColor // yellow
    property var colorEnabled: lighter(defaultColor, 1.1)
    property var colorDisabled: darker(defaultColor, 1.1)
    property var colorSelected: darker(defaultColor, 1.5)
    property var colorPressed: darker(defaultColor, koefPressed)
    property var colorHover: darker(defaultColor, koefHover)
  }

  property string listViewBackgroundItemColor: background.defaultColor //"skyblue"
  property int listViewItemSpacing: 1

  property string inputBoxBackground: "black"
  property string inputBoxBackgroundError: "#FFDDDD"
  property string inputBoxColor: "white"
  property string legacy_placeholderFontColor: "#BABABA"
  property string inputBorderColorActive: Qt.rgba(255, 255, 255, 0.38)
  property string inputBorderColorInActive: Qt.rgba(255, 255, 255, 0.32)
  property string inputBorderColorInvalid: Qt.rgba(255, 0, 0, 0.40)

  property QtObject toolButton: QtObject{
    property int width: 200
    property int height: 48
    property QtObject background: QtObject {
      property string color: "#FA6800"
      property string colorHover: "#E65E00"
      property string colorDisabled: "#707070"
      property string colorDisabledHover: "#808080"
    }
  }

  property string dividerColor: "white"
  property real dividerOpacity: 0.20
}

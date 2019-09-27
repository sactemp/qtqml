import QtQuick 2.0
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4

import "../engine/QML" as MC
import "." // import DataSources.qml as singleton

ColumnLayout {
  id: root

  //sourceColor: "white"
  // mouseArea.enabled: false
  Layout.preferredHeight: 150

  property var points: null
  property int offsetX: canvas.width / 2
  property int offsetY: canvas.height - 10 // canvas.height / 2

  property double koef: 1
  onKoefChanged: {
    canvas.requestPaint()
  }

  property int offsetXOld: offsetX
  property int offsetYOld: offsetY

  property int rangeMin: -10000
  property int rangeMax: 10000

  property int mouseClickX: 0
  property int mouseClickY: 0

  property int projectionType: 0
  property var projections: [
    {
      title: "XYO",
      m: Qt.matrix4x4(
           1, 0, 0, 0,
           0, 1, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 1)
    },
    {
      title: "XOZ",
      m: Qt.matrix4x4(
           1, 0, 0, 0,
           0, 0, 1, 0,
           0, 0, 0, 0,
           0, 0, 0, 1)
    },
    {
      title: "OYZ",
      m: Qt.matrix4x4(
           0, 1, 0, 0,
           0, 0, 1, 0,
           0, 0, 0, 0,
           0, 0, 0, 1)
    },
    {
      title: "isometric",
      m: Qt.matrix4x4(
           Math.sqrt(3), 0, -Math.sqrt(3), 0,
           1, 2, 1, 0,
           Math.sqrt(2), -Math.sqrt(2), Math.sqrt(2), 0,
           0, 0, 0, 1)
    }
  ]

  onPointsChanged: {
    canvas.requestPaint()
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 2

    Label {
      text: "plane: " + projections[projectionType].title
    }

    Canvas {
      id: canvas
      Layout.fillWidth: true
      Layout.fillHeight: true

      antialiasing: true

      onPaint: {

        // console.log("onPaint", points)
        var ctx = canvas.getContext('2d');
        ctx.save();
        ctx.fillStyle = "#efefef";
        ctx.fillRect(0, 0, canvas.width, canvas.height);

        var mscale = Qt.matrix4x4(
              1/root.koef, 0, 0, 0,
              0, 1/root.koef, 0, 0,
              0, 0, 1/root.koef, 0,
              0, 0, 0, 1)
        var m = projections[projectionType].m.times(mscale)

        ctx.strokeStyle = "#afаfff";
        //ctx.font = "15px sans-serif"
        ctx.lineWidth = 1;

        ctx.beginPath();
        ctx.strokeStyle = "red";
        var px1 = m.times(Qt.vector3d(rangeMin, 0, 0))
        var px2 = m.times(Qt.vector3d(rangeMax, 0, 0))
        ctx.moveTo(offsetX + px1.x, offsetY + px1.y);
        ctx.lineTo(offsetX + px2.x, offsetY + px2.y);
        ctx.stroke();

        ctx.beginPath();
        ctx.strokeStyle = "green";
        var py1 = m.times(Qt.vector3d(0, rangeMin, 0))
        var py2 = m.times(Qt.vector3d(0, rangeMax, 0))
        ctx.moveTo(offsetX + py1.x, offsetY + py1.y);
        ctx.lineTo(offsetX + py2.x, offsetY + py2.y);
        ctx.stroke();

        ctx.beginPath();
        ctx.strokeStyle = "blue";
        var pz1 = m.times(Qt.vector3d(0, 0, rangeMin))
        var pz2 = m.times(Qt.vector3d(0, 0, rangeMax))
        ctx.moveTo(offsetX + pz1.x, offsetY + pz1.y);
        ctx.lineTo(offsetX + pz2.x, offsetY + pz2.y);
        ctx.stroke();

        for(var index = rangeMin; index<=rangeMax; index+=(rangeMax-rangeMin)/20)
        {
          ctx.beginPath();
          ctx.strokeStyle = "red";
          var p1 = m.times(Qt.vector3d(index, 0, 0))
          var p2 = m.times(Qt.vector3d(index, 0, 0))
          ctx.moveTo(offsetX + p1.x, offsetY + p1.y);
          ctx.lineTo(offsetX + p2.x, offsetY + p2.y);
          ctx.strokeText(-index, offsetX + p1.x, offsetY + p1.y)
          ctx.stroke();

          ctx.beginPath();
          ctx.strokeStyle = "green";
          p1 = m.times(Qt.vector3d(0, index, 0))
          p2 = m.times(Qt.vector3d(0, index, 0))
          ctx.moveTo(offsetX + p1.x, offsetY + p1.y);
          ctx.lineTo(offsetX + p2.x, offsetY + p2.y);
          ctx.strokeText(-index, offsetX + p1.x, offsetY + p1.y)
          ctx.stroke();

          ctx.beginPath();
          ctx.strokeStyle = "blue";
          p1 = m.times(Qt.vector3d(0, 0, index))
          p2 = m.times(Qt.vector3d(0, 0, index))
          ctx.moveTo(offsetX + p1.x, offsetY + p1.y);
          ctx.lineTo(offsetX + p2.x, offsetY + p2.y);
          ctx.strokeText(-index, offsetX + p1.x, offsetY + p1.y)
          ctx.stroke();
        }
        var trpoints = points.map(function(u){
          return mscale.times(m.times(u));
        })
        ctx.strokeStyle = "black";
        ctx.lineWidth = 2;
        ctx.beginPath();
        var p = trpoints[0]
        ctx.moveTo(offsetX + p.x, offsetY + p.y)
        for(index = 1; index<points.length; index++)
        {
          var p = trpoints[index]
          ctx.lineTo(offsetX + p.x, offsetY + p.y)
        }
        //ctx.closePath();
        ctx.stroke();

        ctx.restore();
      }
    }
    MouseArea {
      id: ma
      // enabled: false
      anchors.fill: canvas
      onPressed: {
        offsetXOld = offsetX
        offsetYOld = offsetY
        mouseClickX = mouse.x
        mouseClickY = mouse.y
      }
      onReleased: {
        mouseClickX = 0
        mouseClickY = 0
      }

      onPositionChanged: {
        var dx = mouse.x - mouseClickX
        var dy = mouse.y - mouseClickY
        offsetX = offsetXOld + dx
        offsetY = offsetYOld + dy
        canvas.requestPaint()
      }
    }
  }
}

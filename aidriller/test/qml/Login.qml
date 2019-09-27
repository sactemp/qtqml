import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2

import "../engine/QML" as MC
import "." // import DataSources.qml as singleton

Window {
  id: wnd
  width: 500
  height: 250
  title: qsTr("Вход в систему...")
  modality: "ApplicationModal"
  visible: false
  // flags: Qt.Dialog

  property var accepted: null

  property var auth: QtObject{
    property string login: ""
    property string password: ""
    property string status: ""

    property QtObject user: null

    onLoginChanged: status = ""
    onPasswordChanged: status = ""
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 20

    ColumnLayout {
      Layout.alignment: Qt.AlignTop
      Layout.fillWidth: true
      Layout.fillHeight: true

      MC.TextEdit {
        //focus: true
        id: login

        label.text: qsTr("Логин")
        label.font.pixelSize: MC.Style.font.h3

        targetObject: wnd.auth
        targetProperty: "login"

        Keys.onReturnPressed: tryLogin()
      }
      MC.TextEdit {
        label.text: qsTr("Пароль")
        label.font.pixelSize: MC.Style.font.h3
        echoMode: TextInput.Password
        targetObject: wnd.auth
        targetProperty: "password"

        Keys.onReturnPressed: tryLogin()
      }
      Label {
        Layout.row: 3
        Layout.column: 1
        text: wnd.auth.status
        color: "#FF0000"
      }
    }
    RowLayout {
      Layout.alignment: Qt.AlignHCenter

      MC.Button {
        source: "/images/icon_a.png"
        // sourceColor: MC.Style.darker(MC.Style.background.color, 1.1)
        text: "Войти"
        onClick: tryLogin()
      }
      MC.Button {
        source: "/images/cross.png"
        // sourceColor: MC.Style.darker(MC.Style.background.color, 1.1)
        text: "Отмена"
        onClick: {
          wnd.close()
        }
      }
    }
  }

  function tryLogin(){
    var lst = DataSources.usersRepository.objects.
        filter(function(u){return wnd.auth.login === u.login && wnd.auth.password === u.password});
    if(lst.length>0) {
      wnd.auth.user = lst[0]
      wnd.close()
    } else {
      wnd.auth.status = "Неверный логин или пароль"
    }
  }

  onVisibleChanged: {
    if (visible) {
      login.editText.focus = true
    } else {
      accepted(wnd.auth.user)
    }
  }
}

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Rectangle {

  id: trayWrap

  width: 42
  height: tray.height + 16
  color: root.colBFBg
  radius: width / 2


  ColumnLayout {

    id: tray
    anchors.centerIn: parent

    OtherTrayBits {}
  }
}


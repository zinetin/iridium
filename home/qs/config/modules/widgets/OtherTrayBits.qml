import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

ColumnLayout {
  Rectangle {
      height: 30
      width: 30
      color: root.colBFBg
      radius: width / 2

      Battery {
        anchors.centerIn: parent
        Layout.alignment: Qt.AlignHCenter
      }
    }
}

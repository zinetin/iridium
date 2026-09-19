import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
  width: 30
  height: 30
  color: mouse.containsMouse ? root.colLightestGrey : root.colDarkestGrey
  border.width: 2
  border.color: mouse.containsMouse ? root.colLightestGrey : root.colLightGrey
  radius:  5

  Text {
    anchors.centerIn: parent
    text: "⏻"
    color: mouse.containsMouse ? root.colDarkestGrey : root.colLightestGrey
    font {
      family: root.fontFamily
      pixelSize: root.fontSize
      bold: true
    }
  }

  MouseArea {
    id: mouse
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: Quickshell.execDetached(["qs", "ipc", "call", "launcher", "toggle"])
  }
}

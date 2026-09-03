import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
  width: 30
  height: 30
  color: root.colGrey
  radius:  width/2

  Text {
    anchors.centerIn: parent
    text: "⏻"
    color: root.colBlue
    font {
      family: root.fontFamily
      pixelSize: root.fontSize
      bold: true
    }
  }
}

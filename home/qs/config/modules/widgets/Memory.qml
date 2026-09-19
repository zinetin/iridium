import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Io

Item {
  id: mem

  property real memUsage: 0


  width: 30
  height: 30

  ColumnLayout {
    anchors.fill: parent

    Text {
      anchors.centerIn: parent
      text: "Mem"
      color: root.colWhite
      font.pixelSize: root.fontSize
    }

    Item {
      Layout.alignment: Qt.AlignHCenter

      Rectangle {
        id: body

        anchors.centerIn: parent
        width: 30
        height: 15
        radius: 2
        color: "transparent"
        border.width: 2
        border.color: root.colLightGrey

        
      }

      Rectangle {
        id: fill

        anchors.left: body.left
        anchors.top: body.top
        anchors.bottom: body.bottom
        anchors.margins: 2
        width: Math.max(0, (body.width - 4) * (memUsage / 100))
        radius: 1
        color: memUsage > 90 ? root.colRed : memUsage > 75 ? root.colYellow : root.colPurple

        Behavior on width {
          NumberAnimation {
            duration: 400
            easing.type: Easing.OutCubic
          }
        }
      }
    }
  }

  Process {
    id: memProc
    command: ["sh", "-c", "free | awk '/^Mem:/{printf \"%.0f\", 100*$3/$2}'"]

    stdout: StdioCollector {
      onStreamFinished: {
        mem.memUsage = parseInt(text.trim()) 
      }
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: memProc.running = true
  }
}

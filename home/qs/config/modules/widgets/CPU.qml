import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Io

Item {
  id: cpu 

  property real cpuUsage: 0
  property real lastCpuTotal: 0
  property real lastCpuIdle: 0

  width: 30
  height: 30

  ColumnLayout {
    anchors.fill: parent

    Text {
      anchors.centerIn: parent
      text: "CPU"
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
        width: Math.max(0, (body.width - 4) * (cpuUsage / 100))
        radius: 1
        color: cpuUsage > 90 ? root.colRed : cpuUsage > 75 ? root.colYellow : root.colGreen

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
    id: cpuProc
    command: ["sh", "-c", "head -1 /proc/stat"]
    stdout: SplitParser {
      onRead: data => {
        if (!data) return
        var p = data.trim().split(/\s+/)
        var idle = parseInt(p[4]) + parseInt(p[5])
        var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
        if (lastCpuTotal > 0) {
          cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
        }
        lastCpuTotal = total
        lastCpuIdle = idle
      }
    }
    Component.onCompleted: running = true
  }
    
  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: cpuProc.running = true
  }
}

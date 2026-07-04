import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

RowLayout {
  spacing: 6

  property real cpuUsage: 0
  property real lastCpuTotal: 0
  property real lastCpuIdle: 0

  Text {
    text: "  "
    color: root.colBlue
    font {
      family: root.fontFamily
      pixelSize: root.fontSize
      bold: true
    }
  }

  Text {
    text: Math.round(parent.cpuUsage) + "%"
    color: parent.cpuUsage > 80 ? root.colYellow : root.colBlue
    font {
      family: root.fontFamily
      pixelSize: root.fontSize
      bold: true
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

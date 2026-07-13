import QtQuick
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

  Shape {
    anchors.fill: parent
    antialiasing: true
    smooth: true

    layer.enabled: true
    layer.smooth: true
    layer.samples: 4

    ShapePath {
      strokeWidth: root.lineWidth
      strokeColor: root.colFBg
      fillColor: "transparent"
      capStyle: ShapePath.RoundCap

      PathAngleArc {
        centerX: cpu.width / 2
        centerY: cpu.height / 2

        radiusX: (cpu.width - root.lineWidth) / 2
        radiusY: (cpu.height - root.lineWidth) / 2

        startAngle: 0
        sweepAngle: 360
      }
    }
  }

  Shape {
    anchors.fill: parent
    antialiasing: true
    smooth: true

    layer.enabled: true
    layer.smooth: true
    layer.samples: 4

    ShapePath {
      strokeWidth: root.lineWidth
      strokeColor: cpu.cpuUsage < 80 ? root.colMuted : root.colRed
      fillColor: "transparent"
      capStyle: ShapePath.RoundCap

      PathAngleArc {
        centerX: cpu.width / 2
        centerY: cpu.height / 2

        radiusX: (cpu.width - root.lineWidth) / 2
        radiusY: (cpu.height - root.lineWidth) / 2

        startAngle: -90
        sweepAngle: (cpu.cpuUsage / 100) * 360
      }
    }
  }

  Text {
    anchors.centerIn: parent
    text: " "
    color: root.colBlue
    font.pixelSize: root.fontSize
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

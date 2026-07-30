import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Io

Item {
  id: mem

  property real memUsage: 0


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
        centerX: mem.width / 2
        centerY: mem.height / 2

        radiusX: (mem.width - root.lineWidth) / 2
        radiusY: (mem.height - root.lineWidth) / 2

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
      strokeColor: mem.memUsage < 80 ? root.colMuted : root.colRed
      fillColor: "transparent"
      capStyle: ShapePath.RoundCap

      PathAngleArc {
        centerX: mem.width / 2
        centerY: mem.height / 2

        radiusX: (mem.width - root.lineWidth) / 2
        radiusY: (mem.height - root.lineWidth) / 2

        startAngle: -90
        sweepAngle: (mem.memUsage / 100) * 360
      }
    }
  }

  Text {
    anchors.centerIn: parent
    text: " "
    color: root.colPurple
    font.pixelSize: root.fontSize
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

import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Io

Item {
  id: gpu

  property real gpuUsage: 0


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
        centerX: gpu.width / 2
        centerY: gpu.height / 2

        radiusX: (gpu.width - root.lineWidth) / 2
        radiusY: (gpu.height - root.lineWidth) / 2

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
      strokeColor: gpu.gpuUsage < 80 ? root.colMuted : root.colRed
      fillColor: "transparent"
      capStyle: ShapePath.RoundCap

      PathAngleArc {
        centerX: gpu.width / 2
        centerY: gpu.height / 2

        radiusX: (gpu.width - root.lineWidth) / 2
        radiusY: (gpu.height - root.lineWidth) / 2

        startAngle: -90
        sweepAngle: (gpu.gpuUsage / 100) * 360
      }
    }
  }

  Text {
    anchors.centerIn: parent
    text: " "
    color: root.colGreen
    font.pixelSize: root.fontSize
  }

  Process {
    id: gpuProc
    command: ["sh", "-c", "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits -i 0"]

    stdout: StdioCollector {
      onStreamFinished: {
        gpu.gpuUsage = parseInt(text.trim()) 
      }
    }
  }

  Timer {
    interval: 4000
    running: true
    repeat: true
    onTriggered: gpuProc.running = true
  }
}

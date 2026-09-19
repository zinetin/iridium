import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Io

Item {
  id: gpu

  property real gpuUsage: 0


  width: 30
  height: 30

  ColumnLayout {
    anchors.fill: parent

    Text {
      anchors.centerIn: parent
      text: "GPU"
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
        border.color: root.colMuted

        
      }

      Rectangle {
        id: fill

        anchors.left: body.left
        anchors.top: body.top
        anchors.bottom: body.bottom
        anchors.margins: 2
        width: Math.max(0, (body.width - 4) * (gpuUsage / 100))
        radius: 1
        color: gpuUsage > 90 ? root.colRed : gpuUsage > 75 ? root.colYellow : root.colBlue

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

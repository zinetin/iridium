import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
  id: battery

  property real level: 0

  width: 30
  height: 30

  ColumnLayout {
    anchors.fill: parent

    Text {
      anchors.centerIn: parent
      text: "Bat"
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
        width: Math.max(0, (body.width - 4) * (battery.level / 100))
        radius: 1
        color: battery.level < 10 ? root.colRed : battery.level < 25 ? root.colYellow : root.colGreen

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
    id: batProc
    command: ["sh", "-c", "cat /sys/class/power_supply/BAT*/capacity"]
    stdout: StdioCollector {
      onStreamFinished: battery.level = parseInt(this.text.trim())
    }
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: batProc.running = true
  }
}



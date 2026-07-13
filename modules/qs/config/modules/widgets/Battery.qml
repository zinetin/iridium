import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

RowLayout {
  spacing: 6

  id: battery

  property real battery: 0

  Text {
    text: "B"
    color: root.colYellow
    font {
      family: root.fontFamily
      pixelSize: root.fontSize
      bold: true
    }
  }

  Text {
    text: Math.round(parent.battery) + ""
    color: parent.battery < 10 ? root.colRed : root.colYellow
    font {
      family: root.fontFamily
      pixelSize: root.fontSize
      bold: true
    }
  }

  Process {
    id: batProc
    command: ["sh", "-c", "cat /sys/class/power_supply/BAT*/capacity"]
    stdout: StdioCollector {
      onStreamFinished: battery.battery = this.text.trim()
      
    }
  }
    
  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: batProc.running = true
  }
}

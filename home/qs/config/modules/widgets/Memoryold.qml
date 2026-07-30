import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

RowLayout {
  spacing: 6

  property int memUse: 0

  Text {
    text: "M " + parent.memUse + ""
    color: root.colCyan
    font {
      family: root.fontFamily
      pixelSize: root.fontSize
      bold: true
    }
  }


  Process {
    id: memProc
    command: ["sh", "-c", "free | awk '/^Mem:/{printf \"%.0f\", 100*$3/$2}'"]

    stdout: StdioCollector {
      onStreamFinished: {
        memUse = parseInt(text.trim()) 
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

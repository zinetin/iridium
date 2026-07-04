import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

RowLayout {
  spacing: 6

  id: clock

  property string day: ""
  property string thisdate: ""
  property string thistime: ""

  ColumnLayout {
    Text {
      text: clock.day
      color: root.colWhite
      font {
        family: root.fontFamily
        pixelSize: root.fontSize
        bold: true
      }
    }

    Text {
      text: clock.thisdate
      color: root.colWhite
      font {
        family: root.fontFamily
        pixelSize: root.fontSize
        bold: true
      }
    }

    Text {
      text: clock.thistime
      color: root.colWhite
      font {
        family: root.fontFamily
        pixelSize: root.fontSize
        bold: true
      }
    }
  }
 
  Process {
    id: dayProc
    command: ["date", "+%A"]
    stdout: StdioCollector {
      onStreamFinished: clock.day = this.text.trim()
    }
  }

  Process {
    id: dateProc
    command: ["date", "+%D"]
    stdout: StdioCollector {
      onStreamFinished: clock.thisdate = this.text.trim()
    }
  }

  Process {
    id: timeProc
    command: ["date", "+%T"]
    stdout: StdioCollector {
      onStreamFinished: clock.thistime = this.text.trim()
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      dayProc.running = true
      dateProc.running = true
      timeProc.running = true
    }
  }
}

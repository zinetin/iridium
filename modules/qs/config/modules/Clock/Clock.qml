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
      Layout.alignment: Qt.AlignHCenter
      text: clock.day
      color: root.colWhite
      font {
        family: root.fontFamily
        pixelSize: root.fontSize
        bold: true
      }
    }

    Text {
      Layout.alignment: Qt.AlignHCenter
      text: clock.thisdate
      color: root.colWhite
      font {
        family: root.fontFamily
        pixelSize: root.fontSize
        bold: true
      }
    }

    Text {
      Layout.alignment: Qt.AlignHCenter
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
    command: ["date", "+%a"]
    stdout: StdioCollector {
      onStreamFinished: clock.day = this.text.trim()
    }
  }

  Process {
    id: dateProc
    command: ["date", "+%m/%d"]
    stdout: StdioCollector {
      onStreamFinished: clock.thisdate = this.text.trim()
    }
  }

  Process {
    id: timeProc
    command: ["date", "+%H:%M"]
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

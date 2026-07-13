import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Rectangle {

  id: sysUsageWrap

  property bool hasGpu: false


  width: 42
  height: sysUsage.height + 16
  color: root.colBFBg
  radius: width / 2

  ColumnLayout {


    id: sysUsage
    anchors.centerIn: parent

    Rectangle {
      height: 30
      width: 30
      color: root.colBFBg
      radius: width / 2

      CPU {
        anchors.centerIn: parent
        Layout.alignment: Qt.AlignHCenter
      }
    }

    Rectangle {
      height: 30
      width: 30
      color: root.colFBg
      radius: width / 2

      Memory {
        anchors.centerIn: parent
        Layout.alignment: Qt.AlignHCenter
      }
    }

    Rectangle {
      height: 30
      width: 30
      color: root.colFBg
      radius: width / 2

      GPU {
        anchors.centerIn: parent
        Layout.alignment: Qt.AlignHCenter
      }
    }
  }

  Process {
    id: nvidiaCheck
    command: ["sh", "-c", "nvidia-smi -L"]
    onExited: (code) => { hasGpu = (code ===0); }
    running: true
  }
}

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Rectangle {

  id: sysUsageWrap

  property bool hasGpu: false


  width: 42
  height: sysUsage.height + 16
  color: root.colDarkestGrey
  radius: width / 2

  ColumnLayout {


    id: sysUsage
    anchors.centerIn: parent

    CPU {
      Layout.alignment: Qt.AlignHCenter
    }

    Memory {
      Layout.alignment: Qt.AlignHCenter
    }

    GPU {
      Layout.alignment: Qt.AlignHCenter
      visible: hasGpu
    }
  }

  Process {
    id: nvidiaCheck
    command: ["sh", "-c", "nvidia-smi -L"]
    onExited: (code) => { hasGpu = (code ===0); }
    running: true
  }
}

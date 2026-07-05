import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "modules/Workspaces"
import "modules/CPU"
import "modules/Clock"
import "modules/Memory"
import "modules/Battery"

PanelWindow {
  id: rootbar

  implicitWidth: 60

  anchors {
    top: true
    left: true
    bottom: true
  }

  color: root.colBg

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 8

    Workspaces {
      Layout.alignment: Qt.AlignHCenter
    }

    Item { Layout.fillHeight: true }

    CPU {
      Layout.alignment: Qt.AlignHCenter
    }

    Memory {
      Layout.alignment: Qt.AlignHCenter
    }

    Battery {
      Layout.alignment: Qt.AlignHCenter
    }
    
    Clock {
      Layout.alignment: Qt.AlignHCenter
    }
  }
}

import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "modules/widgets"
import "modules/popups"

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
    Layout.alignment: Qt.AlignHCenter
    anchors.fill: parent
    anchors.margins: 8

    Workspaces {
      Layout.alignment: Qt.AlignHCenter
    }

    Item { Layout.fillHeight: true }

    BiggerSidebarButton {
      Layout.alignment: Qt.AlignHCenter
    }

    Item { Layout.fillHeight: true }

    SysUsage {
      Layout.alignment: Qt.AlignHCenter
    } 

    Battery {
      Layout.alignment: Qt.AlignHCenter
    }
    
    Clock {
      Layout.alignment: Qt.AlignHCenter
    }

    Tray {
      Layout.alignment: Qt.AlignHCenter
    }

    ThatOtherTray {
      Layout.alignment: Qt.AlignHCenter
    }

    Power {
      Layout.alignment: Qt.AlignHCenter
    }
  }
}

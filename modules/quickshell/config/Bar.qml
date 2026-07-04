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

  anchors {
    top: true
    left: true
    bottom: true
  }

  color: root.colBg

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 8

    Workspaces {}

    Item { Layout.fillHeight: true }

    CPU {}

    Memory {}

    Battery {}
    
    Clock {}
  }
}

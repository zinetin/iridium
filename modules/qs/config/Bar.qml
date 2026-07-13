import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "modules/widgets"
import "modules/popups"

Variants {
  model: Quickshell.screens

  PanelWindow {
    id: rootbar

    required property var modelData
    screen: modelData

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
  
      Item { 
        Layout.fillHeight: true
        Layout.minimumHeight: 0
      }
  
      BiggerSidebarButton {
        Layout.alignment: Qt.AlignHCenter
      }
  
      Item { 
        Layout.fillHeight: true
        Layout.preferredHeight: 300
        Layout.maximumHeight: 300
        Layout.minimumHeight: 0
      }
  
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
}

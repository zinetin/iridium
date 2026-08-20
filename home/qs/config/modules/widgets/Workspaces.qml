import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Rectangle {

  height: workspaces.height
  color: root.colBFBg

  ColumnLayout {
    id: workspaces

    anchors.centerIn: parent

    spacing: 8

    Repeater {

      model: {
        let workspaces = Hyprland.workspaces.values;
        return [...workspaces].sort((a, b) => a.id - b.id);
      }

      Rectangle {

        Layout.alignment: Qt.AlignHCenter
        width: 30
        height: 30
        color: root.colFBg
        radius: width / 2

        property var ws: modelData
        property bool isActive: Hyprland.focusedWorkspace?.id === ws.id


        Text {
          anchors.centerIn: parent

          
          Layout.alignment: Qt.AlignHCenter

          text: ws.name.startsWith("special: ") ? ws.name.replace("special: ", "s") : ws.id
          color: isActive ? root.colBlue : root.colMuted

          font {
            pixelSize: root.fontSize
            bold: true
            family: root.fontFamily
          }

        }
        MouseArea {
          anchors.fill: parent
          onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + ws.id + "})")
        }
      }
    }
  }
}

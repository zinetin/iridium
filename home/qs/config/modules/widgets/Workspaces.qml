import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Rectangle {

  width: 42
  height: workspaces.height + 16
  color: root.colBFBg
  radius: width / 2

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

        Text {
          anchors.centerIn: parent

          property var ws: modelData
          property bool isActive: Hyprland.focusedWorkspace?.id === ws.id

          Layout.alignment: Qt.AlignHCenter

          text: ws.name.startsWith("special: ") ? ws.name.replace("special: ", "s") : ws.id
          color: isActive ? root.colBlue : root.colMuted

          font {
            pixelSize: root.fontSize
            bold: true
            family: root.fontFamily
          }

          MouseArea {
            anchors.fill: parent
            onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + ws.id + "})")
          }
        }
      }
    }
  }
}

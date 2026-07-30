import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

ShellRoot {
  id: root

  property color colBg: "#1a1b26"
  property color colBFBg: "#212330"
  property color colFBg: "#272834"
  property color colFg: "#a9b1d6"
  property color colMuted: "#444b6a"
  property color colCyan: "#66ffff"
  property color colBlue: "#7aa2f7"
  property color colYellow: "#e1e368"
  property color colGreen: "#119368"
  property color colPurple: "#911378"
  property color colWhite: "#F0F0F0"
  property color colRed: "#d42020"
  property real lineWidth: 8
  property string fontFamily: "JetBrainsMono Nerd Font"
  property int fontSize: 14

  Bar {}
}

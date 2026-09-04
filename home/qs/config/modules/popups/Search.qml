import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

PanelWindow {
  id: launcher

  property bool launcherOpen: false
  property var filteredApps: {
    const q = searchInput.text.trim().toLowerCase()
    const all = [...DesktopEntries.applications.values]
      .filter(d => d.name)
      .sort((a, b) => a.name.localeCompare(b.name))

    if (q === "") return all

    return all.filter(d => {
      const name = (d.name || "").toLowerCase()
      const comment = (d.comment || "").toLowerCase()
      return name.includes(q) || comment.includes(q)
    })
  }

  visible: launcherOpen
  color: "transparent"

  WlrLayershell.layer: WlrLayer.Overlay
  WlrLayershell.keyboardFocus: launcherOpen ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None
  exclusiveZone: 0

  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }

  // Toggle this popup from Hyprland with:
  //   hyprctl dispatch exec "qs ipc call launcher toggle"
  IpcHandler {
    target: "launcher"

    function toggle(): void {
      launcher.launcherOpen = !launcher.launcherOpen
    }
    function open(): void {
      launcher.launcherOpen = true
    }
    function close(): void {
      launcher.launcherOpen = false
    }
  }

  onLauncherOpenChanged: {
    if (launcherOpen) {
      searchInput.text = ""
      searchInput.forceActiveFocus()
      appList.currentIndex = 0
    }
  }

  function launch(entry) {
    entry.execute()
    launcherOpen = false
  }

  // click-catcher: clicking outside the card closes the launcher
  MouseArea {
    anchors.fill: parent
    onClicked: launcher.launcherOpen = false
  }

  Rectangle {
    id: card

    anchors.centerIn: parent
    width: 480
    height: 420
    radius: 16
    color: root.colDarkestGrey
    border.color: root.colLightestGrey
    border.width: 1

    // absorb clicks so they don't fall through to the catcher above
    MouseArea {
      anchors.fill: parent
      onClicked: {}
    }

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 14
      spacing: 10

      TextField {
        id: searchInput

        Layout.fillWidth: true
        placeholderText: "Search apps…"
        color: root.colWhite
        placeholderTextColor: root.colLightestGrey
        selectByMouse: true

        font {
          family: root.fontFamily
          pixelSize: root.fontSize
        }

        background: Rectangle {
          color: root.colGrey
          radius: 10
        }

        Keys.onEscapePressed: launcher.launcherOpen = false
        Keys.onDownPressed: appList.incrementCurrentIndex()
        Keys.onUpPressed: appList.decrementCurrentIndex()
        Keys.onReturnPressed: {
          const entry = launcher.filteredApps[appList.currentIndex]
          if (entry) launcher.launch(entry)
        }
      }

      ListView {
        id: appList

        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        spacing: 4
        model: launcher.filteredApps
        currentIndex: 0
        highlightMoveDuration: 80

        delegate: Rectangle {
          required property var modelData
          required property int index

          width: appList.width
          height: 44
          radius: 8
          color: index === appList.currentIndex ? root.colGrey : "transparent"

          RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            spacing: 10

            IconImage {
              Layout.preferredWidth: 24
              Layout.preferredHeight: 24
              source: Quickshell.iconPath(modelData.icon, true)
            }

            ColumnLayout {
              Layout.fillWidth: true
              spacing: 0

              Text {
                text: modelData.name
                color: root.colWhite
                elide: Text.ElideRight
                Layout.fillWidth: true
                font {
                  family: root.fontFamily
                  pixelSize: root.fontSize
                  bold: true
                }
              }

              Text {
                visible: !!modelData.comment
                text: modelData.comment
                color: root.colLightestGrey
                elide: Text.ElideRight
                Layout.fillWidth: true
                font {
                  family: root.fontFamily
                  pixelSize: root.fontSize - 3
                }
              }
            }
          }

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: appList.currentIndex = index
            onClicked: launcher.launch(modelData)
          }
        }
      }
    }
  }
}

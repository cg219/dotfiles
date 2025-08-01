import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Io
import "./../common"

Item {
    property var panel
    property int totalTime: 10
    property int currentTime: 0

    function reset() {
        timer.running = false
        reboot.running = false
        window.visible = false
        currentTime = 0
    }

    implicitHeight: 24
    implicitWidth: 30

    Button {
        id: button
        flat: true
        implicitWidth: 30
        onClicked: {
            window.visible = true
            timer.running = true
        }

        Text {
            text: '\uead2'
            color: 'black'
            font.family: 'Symbols Nerd Font'
            font.pixelSize: 21
            anchors.centerIn: parent
        }
    }

    PopupWindow {
        id: window
        anchor.window: panel
        anchor.rect.y: (Quickshell.screens[0].height * .5) - (this.implicitHeight * .5)
        anchor.rect.x: (panel.width * .5) - (this.implicitWidth * .5)
        color: 'transparent'
        implicitWidth: 500
        implicitHeight: 200
        visible: false

        Rectangle {
            color: 'lightsteelblue'
            radius: 10
            anchors.fill: parent

            Column {
                spacing: 30
                anchors.centerIn: parent

                Text {
                    text: `Rebooting in ${totalTime - currentTime} seconds...`
                    font.pixelSize: 20
                }

                Row {
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter

                    StyledButton {
                        text: 'Cancel'
                        onClicked: reset()
                    }

                    StyledButton {
                        text: 'Reboot Now'
                        onClicked: reboot.running = true
                    }
                }
            }
        }
    }

    Process {
        id: reboot
        running: false
        command: ["reboot"]
    }

    Timer {
        id: timer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            if (currentTime == totalTime) {
                reset()
                reboot.running = true
            } else {
                currentTime += 1
            }
        }
    }
}


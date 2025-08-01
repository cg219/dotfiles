import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "modules/clock"
import "modules/bluetooth"
import "modules/poweroff"
import "modules/reboot"

ShellRoot {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            id: bar
            screen: modelData
            implicitHeight: 30
            color: 'transparent'

            anchors {
                top: true
                left: true
                right: true
            }

            margins {
                right: 25
                left: 25
            }

            Rectangle {
                anchors.fill: parent
                radius: 10
                color: 'lightsteelblue'
            }

            PowerOff {
                id: poweroff
                panel: bar
                totalTime: 20

                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: 20
                }
            }

            Reboot {
                id: reboot
                panel: bar
                totalTime: 20

                anchors {
                    left: poweroff.right
                    verticalCenter: parent.verticalCenter
                    leftMargin: 20
                }
            }

            Bluetooth {
                id: bluetooth
                panel: bar

                anchors {
                    right: clock.left
                    verticalCenter: parent.verticalCenter
                    rightMargin: 20
                }
            }

            Clock {
                id: clock

                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 20
                }
            }
        }
    }
}


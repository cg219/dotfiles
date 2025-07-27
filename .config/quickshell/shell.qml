import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "modules/clock"
import "modules/bluetooth"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            implicitHeight: 30

            anchors {
                top: true
                left: true
                right: true
            }

            margins {
                right: 25
                left: 25
            }

            Row {
                spacing: 20

                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 20
                }

                Bluetooth {}
                Clock {}
            }

        }
    }
}


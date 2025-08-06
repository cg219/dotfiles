import QtQuick
import Quickshell
import QtQuick.Controls

Item {
    property var panel
    implicitWidth: 30
    implicitHeight: 24

    Button {
        id: button
        flat: true
        implicitWidth: 30
        onClicked: {
            const action = !window.visible
            window.visible = action
            list.clear()
            BluetoothProcess.deviceList = []
            BluetoothProcess.scan = action
        }

        Text {
            text: '\udb80\udcaf'
            color: 'blue'
            font.family: 'Symbols Nerd Font'
            font.pixelSize: 18
            anchors.centerIn: parent
        }
    }

    PopupWindow {
        id: window
        implicitWidth: 300
        implicitHeight: 400
        visible: false
        anchor.item: button
        anchor.rect.y: panel.height
        color: 'transparent'

        Rectangle {
            implicitWidth: parent.width
            implicitHeight: parent.height
            color: 'lightsteelblue'
            radius: 10
            anchors.fill: parent
        }

        ListView {
            model: list
            implicitWidth: parent.width
            implicitHeight: parent.height

            delegate: Row {
                required property string mac
                required property string name
                required property string icon

                spacing: 20

                Text {
                    text: icon
                    font.family: 'UbuntuMono Nerd Font'
                    font.pixelSize: 18
                    // anchors.centerIn: parent
                }

                Text {
                    text: name
                    font.family: 'UbuntuMono Nerd Font'
                    font.pixelSize: 18
                    // anchors.centerIn: parent
                }

            }
        }
    }

    ListModel {
        id: list
    }

    Connections {
        target: BluetoothProcess

        function onDeviceListChanged(val) {
            list.clear()
            BluetoothProcess.deviceList.forEach((d) => {
                list.append({mac: d.mac, name: d.name, icon: d.icon})
            })
        }
    }
}

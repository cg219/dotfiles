import QtQuick
import Quickshell
import QtQuick.Controls

Column {
    property var panel

    Button {
        id: button
        flat: true
        implicitWidth: 30
        onClicked: window.visible = !window.visible

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
        implicitWidth: 200
        implicitHeight: 400
        visible: false
        anchor.item: button
        anchor.rect.y: panel.height
        color: 'transparent'

        Rectangle {
            implicitWidth: 500
            implicitHeight: 500
            color: 'lightsteelblue'
            radius: 10
            anchors.fill: parent
        }
    }
}

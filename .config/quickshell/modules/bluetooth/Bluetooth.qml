import QtQuick
import Quickshell

Item {
    implicitHeight: bluetooth.impicitHeight
    implicitWidth: bluetooth.impicitWidth

    Text {
        id: bluetooth
        text: '\udb80\udcaf'
        color: 'blue'
        font.family: 'Symbols Nerd Font'
        font.pixelSize: 18
    }

    FloatingWindow {
        maximumSize: Qt.size(20, 100)
        minimumSize: Qt.size(20, 100)
    }
}

pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: bt
    property bool scan: false
    property bool devices: false
    property var deviceList: []
    property var rawList: []

    function getInfo(uuid) {
        btinfo.device = uuid
        btinfo.running = true

        btinfo.exited.connect(() => {
            const iconLine = btinfo.info.split('\n').map((l) => l.trim()).filter((line) => line.startsWith('Icon: '))
            const device = getDeviceFromRaw(uuid)

            if (device) {
                const icon = iconLine[0].replace('Icon: ', '')
                bt.deviceList = [...bt.deviceList, { mac: device.mac, name: device.name, icon }]

                console.log(bt.deviceList)
            }
        })
    }

    function getInfoForList() {
        for (const d of bt.rawList) {
            getInfo(d.mac)
        }
    }

    function getDeviceFromRaw(uuid) {
        return bt.rawList.find((d) => d.mac == uuid)
    }

    Process {
        id: btscan
        command: ['bluetoothctl', '-t', 8, 'scan', 'bredr']
        running: bt.scan

        stdout: StdioCollector {
            onStreamFinished: {
                bt.scan = false
                bt.devices = true
            }
        }
    }

    Process {
        id: btdevices
        command: ['bluetoothctl', 'devices']
        running: bt.devices

        stdout: StdioCollector {
            onStreamFinished: {
                bt.devices = false
                bt.rawList = this.text.split('\n')
                .map((line) => line.split(' '))
                .filter((line) => line[0].toLowerCase() == 'device')
                .map((line) => ({ mac: line[1], name: line[2] }))

                getInfoForList()
            }
        }
    }

    Process {
        id: btinfo
        property string device
        property string info

        command: ['bluetoothctl', 'info', this.device]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                btinfo.info = this.text
                btinfo.running = false
            }
        }
    }
}

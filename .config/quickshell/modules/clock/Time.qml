pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string time: {
        Qt.formatDateTime(clock.date, "ddd hh:mmap | M/d")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}


pragma ComponentBehavior: Bound

import QtQuick

DropArea {
    id: area

    property string dropPath: ""

    onEntered: drag => FileDragHover.track(area, dropPath, drag)
    onPositionChanged: drag => FileDragHover.track(area, dropPath, drag)
    onContainsDragChanged: {
        if (!containsDrag)
            FileDragHover.release(area);
    }
    Component.onDestruction: FileDragHover.release(area)
}

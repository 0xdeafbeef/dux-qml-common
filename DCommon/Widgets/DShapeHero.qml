import QtQuick
import Quickshell.Widgets
import qs.DCommon.Common

Item {
    id: root

    default property alias content: contentColumn.data
    property real paddingV: Style.spacingXL + Style.spacingS
    property real accentSize: Style.buttonHeightM * 1.6
    property Component backdrop: defaultBackdrop

    readonly property real availableWidth: width - Style.spacingXL * 2

    height: contentColumn.implicitHeight + paddingV * 2

    component Decoration: DMaterialShape {
        respectThemeShape: false
    }

    Component {
        id: defaultBackdrop

        Item {
            Decoration {
                width: root.height * 1.15
                height: width
                x: parent.width - width * 0.62
                y: -height * 0.42
                shape: "cookie12"
                color: Style.withAlpha(Style.primary, Style.tonalTintAlpha)
                rotation: 12
            }

            Decoration {
                width: root.height * 0.8
                height: width
                x: -width * 0.38
                y: parent.height - height * 0.58
                shape: "softBurst"
                color: Style.withAlpha(Style.tertiary, Style.tonalTintAlpha)
                rotation: -8
            }

            Decoration {
                width: root.accentSize * 0.6
                height: width
                x: parent.width * 0.12
                y: root.paddingV * 0.6
                shape: "flower"
                color: Style.withAlpha(Style.onPrimaryContainer, Style.stateLayerHover)
            }

            Decoration {
                width: root.accentSize * 0.75
                height: width
                x: parent.width * 0.8
                y: parent.height - height - root.paddingV * 0.5
                shape: "pill"
                color: Style.withAlpha(Style.secondary, Style.tonalTintAlpha)
                rotation: -40
            }
        }
    }

    ClippingRectangle {
        anchors.fill: parent
        radius: Style.cornerRadiusXL
        color: Style.primaryContainer

        Loader {
            anchors.fill: parent
            sourceComponent: root.backdrop
        }
    }

    Column {
        id: contentColumn
        anchors.centerIn: parent
        width: root.availableWidth
        spacing: Style.spacingM
    }
}

import QtQuick
import Quickshell.Widgets
import qs.DCommon.Common

DCard {
    id: root

    property string brand: ""
    property string accent: ""
    property string caption: ""
    property string symbol: ""
    property int atomicNumber: 0
    property string atomicMass: ""
    property real paddingH: Style.spacingXL
    property real paddingV: Style.spacingXL + Style.spacingS
    default property alias extra: slot.data

    readonly property string release: accent !== "" ? brand + " " + accent : brand
    readonly property bool hasElement: symbol !== "" && caption.toLowerCase().startsWith(symbol.toLowerCase())
    readonly property string headline: hasElement ? caption.slice(symbol.length) : release
    readonly property string badge: hasElement ? release : caption
    readonly property real availableWidth: width - paddingH * 2
    readonly property real lockupScale: Math.min(1, availableWidth / Math.max(1, (hasElement ? Style.fontSizeDisplayLarge * 1.6 + Style.spacingS : 0) + headlineMetrics.width))
    readonly property real lockupSize: Style.fontSizeDisplayLarge * lockupScale
    readonly property real tileSize: lockupSize * 1.6

    width: parent?.width ?? 0
    height: heroColumn.implicitHeight + paddingV * 2
    restRadius: Style.groupedListOuterRadius
    color: Style.primaryContainer
    pad: 0
    showFocusRing: false

    StyledTextMetrics {
        id: headlineMetrics
        text: root.headline
        font.pixelSize: Style.fontSizeDisplayLarge
        font.weight: Style.fontWeightBold
    }

    component Decoration: DMaterialShape {
        respectThemeShape: false
    }

    // Clips the shapes only: text inside a ClippingRectangle is drawn from a texture and blurs at fractional scales.
    ClippingRectangle {
        anchors.fill: parent
        radius: root.bodyRadius
        color: "transparent"

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
            width: root.tileSize * 0.6
            height: width
            x: parent.width * 0.12
            y: root.paddingV * 0.6
            shape: "flower"
            color: Style.withAlpha(Style.onPrimaryContainer, Style.stateLayerHover)
        }

        Decoration {
            width: root.tileSize * 0.75
            height: width
            x: parent.width * 0.8
            y: parent.height - height - root.paddingV * 0.5
            shape: "pill"
            color: Style.withAlpha(Style.secondary, Style.tonalTintAlpha)
            rotation: -40
        }
    }

    Column {
        id: heroColumn
        anchors.centerIn: parent
        width: root.availableWidth
        spacing: Style.spacingM

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: Style.spacingS

            Rectangle {
                id: tile
                anchors.verticalCenter: parent.verticalCenter
                width: root.tileSize
                height: width
                radius: Style.cornerRadiusS
                color: Style.primary
                visible: root.hasElement

                StyledText {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: tile.width * 0.07
                    text: root.atomicNumber
                    font.pixelSize: tile.width * 0.15
                    font.weight: Style.fontWeightMedium
                    color: Style.onPrimary
                }

                StyledText {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: tile.width * 0.03
                    text: root.symbol
                    font.pixelSize: root.lockupSize * 0.9
                    font.weight: Style.fontWeightBold
                    color: Style.onPrimary
                }

                StyledText {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: tile.width * 0.05
                    text: root.atomicMass
                    font.pixelSize: tile.width * 0.11
                    color: Style.onPrimary
                }
            }

            StyledText {
                anchors.verticalCenter: parent.verticalCenter
                text: root.headline
                font.pixelSize: root.lockupSize
                font.weight: Style.fontWeightBold
                color: Style.onPrimaryContainer
            }
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: Math.min(parent.width, badgeText.implicitWidth + Style.spacingL * 2)
            height: Style.buttonHeightXXS
            radius: Style.fullRadius(width, height)
            color: Style.primary
            visible: root.badge !== ""

            StyledText {
                id: badgeText
                anchors.centerIn: parent
                width: Math.min(implicitWidth, parent.width - Style.spacingL * 2)
                text: root.badge
                font.pixelSize: Style.fontSizeMedium
                font.weight: Style.fontWeightBold
                color: Style.onPrimary
                elide: Text.ElideRight
            }
        }

        Column {
            id: slot
            width: parent.width
            spacing: Style.spacingS
            topPadding: visibleChildren.length > 0 ? Style.spacingS : 0
        }
    }
}

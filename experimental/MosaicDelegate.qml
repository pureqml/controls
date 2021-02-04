Rectangle {
    signal pressed;
    property bool allowOpacity;
    property bool playing;
    width: parent.cellWidth;
    height: parent.cellHeight;
    property bool active: activeFocus;
    property Mixin hoverMixin: HoverClickMixin { }
    property alias hover: hoverMixin.value;
    anchors.margins: mosaicGrid.delegateRadius;
    transform.scaleX: active ? 1.05 : 1;
    transform.scaleY: active ? 1.05 : 1;
    effects.shadow.blur: 10;
    effects.shadow.color: active ? "#8AF" : "#0000";
    effects.shadow.spread: 2;
    border.width: active ? 1 : 0;
    border.color: active ? "#8AF" : "#0000";
    radius: mosaicGrid.delegateRadius;
    color: "#464646";
    clip: true;
    opacity: playing && allowOpacity ? 0.0 : 1.0;
    z: active ? parent.z + 1 : parent.z;

    MouseMoveMixin {
        onMouseMove: {
            mosaicGrid.hoverMode = true
            mosaicGrid.currentIndex = model.index
        }
    }

    Image {
        id: programImage;
        property bool display;
        source: model.preview? model.preview: '';
        anchors.fill: parent;
        fillMode: Image.PreserveAspectCrop;
        visible: source;

        onStatusChanged: {
            this.display = this.status == this.Ready
        }
    }

    Rectangle {
        width: 100%;
        height: 70s;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 2s;
        gradient: Gradient {
            GradientStop { color: "#0000"; position: 0.0; }
            GradientStop { color: "#000"; position: 1.0; }
        }
    }

    Image {
        x: 10s;
        width: 100s;
        height: 70s;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 21s;
        fillMode: Image.PreserveAspectFit;
        source: model.icon? model.icon: '';
        verticalAlignment: Image.AlignTop;
        horizontalAlignment: Image.AlignRight;
    }

    EllipsisText {
        x: 10s;
        width: 270s;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 6s;
        font.pixelSize: mosaicGrid.mobile ? 9s : 18s;
        color: "#fff";
        text: model.title;
    }

    Rectangle {
        width: 100%;
        height: 2s;
        color: "#000c";
        anchors.bottom: parent.bottom;
        clip: true;

        Rectangle {
            height: 100%;
            width: parent.width * model.progress;
            color: "#e53935";
        }
    }

    Timer {
        id: flipTimer;
        interval: 3000;

        onTriggered: {
            if (!this.parent.active)
                return
            this.parent.playing = true
            mosaicGrid.itemFocused(model.index)
        }
    }

    onActiveChanged: {
        if (!mosaicGrid._firstTimeFlag) {
            mosaicGrid._firstTimeFlag = true
            return
        }

        if (!value) {
            this.playing = false
            return
        }

        flipTimer.restart()
    }

    onClicked: { mosaicGrid.currentIndex = model.index; this.pressed() }
    onSelectPressed: { this.pressed() }
    onPressed: { mosaicGrid.play(model.index) }

    Behavior on opacity { Animation { duration: 1200; } }
    Behavior on transform, boxshadow { Animation { duration: 400; } }
}

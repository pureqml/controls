GridView {
	id: nowonTvGrid;
	property bool hoverMode;
	property bool mobile: context.system.device === context.system.Mobile;
	property int offset;
	signal play;
	signal itemFocused;
	property int delegateRadius;
	width: 100%;
	height: 100%;
	cellWidth: (context.width > context.height ? 0.25 : 0.5) * width - spacing;
	cellHeight: cellWidth * 0.625;
	spacing: 10s;
	keyNavigationWraps: false;
	content.cssTranslatePositioning: true;
	nativeScrolling: true;
	contentFollowsCurrentItem: !hoverMode;
	model: ListModel { }
	delegate: Rectangle {
		signal pressed;
		property bool active: activeFocus;
		property Mixin hoverMixin: HoverClickMixin { }
		property alias hover: hoverMixin.value;
		width: parent.cellWidth;
		height: parent.cellHeight;
		color: "#464646";
		transform.scaleX: active ? 1.05 : 1;
		transform.scaleY: active ? 1.05 : 1;
		effects.shadow.blur: 10;
		effects.shadow.color: active ? "#00f" : "#0000";
		radius: nowonTvGrid.delegateRadius;
		effects.shadow.spread: 1;
		clip: true;
		z: active ? parent.z + 1 : parent.z;

		MouseMoveMixin {
			onMouseMove: {
				nowonTvGrid.hoverMode = true
				nowonTvGrid.currentIndex = model.index
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
			font.pixelSize: nowonTvGrid.mobile ? 9s : 18s;
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
				this.parent.transform.scaleX = 0
				nowonTvGrid.itemFocused(model.index)
			}
		}

		onActiveChanged: {
			if (!value)
				return

			flipTimer.restart()
		}

		onClicked: { this.parent.currentIndex = model.index; this.pressed() }
		onSelectPressed: { this.pressed() }
		onPressed: { this.parent.play(model.index) }

		Behavior on transform { Animation { duration: 300; } }
	}

	onKeyPressed: {
		this.hoverMode = false
		return false
	}

	fill(items, mappingFunc): {
		var res = []
		for (var i in items) {
			var row = mappingFunc(items[i])
			if (row)
				res.push(row)
		}
		this.model.assign(res)
	}
}

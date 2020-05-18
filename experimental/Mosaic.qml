GridView {
	id: nowonTvGrid;
	property int selectedIndex;
	signal play;
	signal itemFocused;
	width: 100%;
	height: 100%;
	cellWidth: width * 0.25;
	cellHeight: cellWidth * 0.625;
	keyNavigationWraps: false;
	content.cssTranslatePositioning: true;
	model: ListModel { }
	delegate: WebItem {
		signal pressed;
		property bool active: model.index == parent.selectedIndex;
		width: parent.cellWidth - 10s;
		height: parent.cellHeight - 10s;
		color: "#464646";
		transform.scaleX: active ? 1.1 : 1;
		transform.scaleY: active ? 1.1 : 1;
		effects.shadow.spread: 1;
		effects.shadow.blur: 10;
		effects.shadow.color: active ? "#00f" : "#0000";
		z: active ? parent.z + 1 : parent.z;

		Image {
			id: programImage;
			property bool display;
			source: model.preview;
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
			source: model.icon;
			verticalAlignment: Image.AlignTop;
			horizontalAlignment: Image.AlignRight;
		}

		EllipsisText {
			x: 10s;
			width: 270s;
			anchors.bottom: parent.bottom;
			anchors.bottomMargin: 6s;
			font.pixelSize: 18s;
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
				if (!this.parent.activeFocus)
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

		onClicked: { this.pressed() }
		onSelectPressed: { this.pressed() }
		onPressed: { this.parent.play(model.index) }
		onHoverChanged: { if (value) this.parent.selectedIndex = model.index }

		Behavior on transform { Animation { duration: 300; } }
	}

	onCurrentIndexChanged: { this.selectedIndex = value }

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

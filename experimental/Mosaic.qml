GridView {
	id: nowonTvGrid;
	signal play;
	signal itemFocused;
	width: 100%;
	height: 100%;
	cellWidth: 300s;
	cellHeight: 180s;
	keyNavigationWraps: false;
	content.cssTranslatePositioning: true;
	model: ListModel { }
	delegate: WebItem {
		signal pressed;
		width: 290s;
		height: 170s;
		color: "#464646";
		transform.scaleX: activeFocus ? 1.1 : 1;
		transform.scaleY: activeFocus ? 1.1 : 1;
		effects.shadow.spread: 1;
		effects.shadow.blur: 10;
		effects.shadow.color: activeFocus ? "#00f" : "#0000";
		z: activeFocus ? parent.z + 1 : parent.z;

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

		onActiveFocusChanged: {
			if (!value)
				return

			flipTimer.restart()
		}

		onClicked: { this.pressed() }
		onSelectPressed: { this.pressed() }
		onPressed: { this.parent.play(model.index) }

		Behavior on transform { Animation { duration: 300; } }
	}
}

Item {
	id: swapImageProto;
	property int swapDuration: 500;
	property enum fillMode { Stretch, PreserveAspectFit, PreserveAspectCrop, Tile, TileVertically, TileHorizontally, Pad };

	Image {
		id: backImage;
		anchors.fill: parent;
		fillMode: parent.fillMode;

		onStatusChanged: {
			if (frontImage.atTheTop && value == this.Ready) {
				frontImage.opacity = 0.0
				animationSyncTimer.restart()
			}
		}

		Behavior on opacity { Animation { duration: swapImageProto.swapDuration; } }
	}

	Image {
		id: frontImage;
		property bool atTheTop: z == parent.z;
		anchors.fill: parent;
		fillMode: parent.fillMode;

		onStatusChanged: {
			if (!frontImage.atTheTop && value == this.Ready) {
				backImage.opacity = 0.0
				animationSyncTimer.restart()
			}
		}

		Behavior on opacity { Animation { duration: swapImageProto.swapDuration; } }
	}

	Timer {
		id: animationSyncTimer;
		interval: swapImageProto.swapDuration;

		onTriggered: { this.parent.swapLayers() }
	}

	swapLayers: {
		if (frontImage.atTheTop) {
			frontImage.z = this.z - 1
			backImage.z = this.z
			frontImage.opacity = 1.0
		} else {
			backImage.z = this.z - 1
			frontImage.z = this.z
			backImage.opacity = 1.0
		}
	}

	swap(source): {
		if (!frontImage.source) {
			backImage.z = this.z - 1
			frontImage.z = this.z
			frontImage.source = source
		} else if (frontImage.atTheTop) {
			backImage.source = source
		} else {
			frontImage.source = source
		}
	}
}

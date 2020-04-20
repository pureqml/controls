Item {
	id: floatingTextProto;
	property string text;
	property int pixelSize: 21;
	property bool running;
	property Color color: "#fff";
	height: 24;
	clip: true;

	Text {
		id: floatingText;
		property int delta: parent.width - width;
		text: parent.text;
		color: parent.color;
		font.pixelSize: parent.pixelSize;

		onPaintedWidthChanged: {
			if (this.parent.running)
				this.parent.startFloatingText()
		}

		Behavior on transform {
			Animation {
				id: floatingAnimation;
				duration: -floatingText.delta * 30;
				easing: "linear";
				delay: 300;
			}
		}
	}

	Timer {
		id: floatingTextTimer;
		interval: -floatingText.delta * 30 + 2000;
		running: parent.running;
		repeat: parent.running;

		onTriggered: {
			this.parent.startFloatingText()
			floatingText.transform.translateX = floatingText.delta
		}
	}

	resetPosition: {
		floatingAnimation.disable()
		floatingText.transform.translateX = 0
		floatingAnimation.enable()
	}

	startFloatingText: {
		this.resetPosition()
		if (floatingText.paintedWidth)
			floatingText.transform.translateX = floatingText.delta
	}

	onRunningChanged: {
		if (value)
			this.startFloatingText()
		else
			this.resetPosition()
	}
}

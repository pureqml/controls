Rectangle {
	id: scrollBarProto;
	property int contentY;
	property int minHeight: 10;
	property int contentHeight: 1;
	property int displayHeight: 1;
	property int displaySeconds: 1000;
	property int animationDuration: 300;
	property int realContentY: contentHeight ? -contentY * 1.0 / contentHeight * displayHeight : 0;
	property int realHeight: contentHeight ? displayHeight * 1.0 / contentHeight * displayHeight : 0;
	property int maxContentY: displayHeight - movingBar.height;
	property int shift: realContentY > maxContentY ? maxContentY : realContentY;
	property bool display: false;
	property Color barColor: "#fff";
	width: 6;
	height: displayHeight;
	opacity: display ? 1.0 : 0.0;
	visible: contentHeight > displayHeight;
	radius: width / 2;
	color: "gray";

	Rectangle {
		id: movingBar;
		width: 100%;
		transform.translateY: parent.shift;
		radius: width / 2;
		height: parent.realHeight < parent.minHeight ? parent.minHeight : parent.realHeight;
		color: parent.barColor;

		Behavior on transform { Animation { duration: scrollBarProto.animationDuration; easing: "ease-out"; } }
	}

	Timer {
		id: displayTimer;
		interval: parent.displaySeconds;

		onTriggered: { this.parent.display = false }
	}

	onHeightChanged,
	onContentYChanged: { this.show() }

	show: {
		this.display = true
		displayTimer.restart()
	}

	Behavior on opacity { Animation { duration: scrollBarProto.animationDuration; easing: "ease-out"; } }
}

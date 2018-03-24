/// simple checkbox control with swipable button
MouseArea {
	id: checkboxProto;
	property bool checked;	///< is checkbox checked or not
	property color panelColor: "#ccc";	///< panel color
	property color checkedColor: "#8BC34A";	///< button color if checked
	property color uncheckedColor: "#F44336";	///< button color if not checked
	height: 40;	///< @private
	width: 80;	///< @private

	Rectangle {
		anchors.fill: parent;
		anchors.topMargin: parent.height / 8;
		anchors.bottomMargin: parent.height / 8;
		radius: height / 2;
		color: parent.panelColor;
	}

	Rectangle {
		id: checkboxSwitcher;
		x: !parent.checked ? 0 : parent.width - width;
		height: parent.height;
		width: height;
		radius: width / 2;
		color: parent.checked ? parent.checkedColor : parent.uncheckedColor;
		effects.shadow.x: checkboxProto.checked ? -1 : 1;
		effects.shadow.color: "#9e9e9e";

		Behavior on x { Animation { duration: 150; } }
		Behavior on color { ColorAnimation { duration: 150; } }
	}

	Timer {
		id: checkboxDelay;
		interval: 100;

		onTriggered: { checkboxProto.checked = checkboxProto._dx && checkboxProto._dx >= 0 }
	}

	///@private
	onHorizontalSwiped(event): {
		var box = this.toScreen()
		var touch = event.touches[0]
		var x = touch.pageX - box[0]
		this._dx = x - this._startX
		checkboxDelay.restart()
	}

	///@private
	onMouseMove: {
		if (this.pressed) {
			this._dx = this.mouseX - this.width / 2
			checkboxDelay.restart()
		}
	}
}

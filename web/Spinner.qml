WebItem {
	id: spinnerItem;
	property bool running;
	width: 80;
	height: 80;
	rotate: 0;
	property int squize: 0;

	start: {
		this.running = true;
	}

	stop: {
		this.running = false;
	}

	onRunningChanged: {
		spinnerItem.rotate += 360;
		spinnerItem.squize = ++spinnerItem.squize % 5;
	}

	Rectangle {
		id: r1;
		x: parent.squize * 5;
		y: parent.squize * 5;
		width: 30;
		height: 30;
		radius: 15;
		color: "#FFEB3B";
		opacity: 0.8;
		Behavior on x, y { Animation {duration: 400; easing: "linear"; cssTransition: true;} }
	}

	Rectangle {
		id: r2;
		x: 50 - parent.squize * 5;
		y: parent.squize * 5;
		width: 30;
		height: 30;
		radius: 15;
		color: "#4CAF50";
		opacity: 0.8;
		Behavior on x, y { Animation {duration: 400; easing: "linear";  cssTransition: true;} }
	}

	Rectangle {
		x: parent.squize * 5;
		y: 50 - parent.squize * 5;
		id: r3;
		width: 30;
		height: 30;
		radius: 15;
		color: "#2196F3";
		opacity: 0.8;
		Behavior on x, y { Animation {duration: 400; easing: "linear";  cssTransition: true;} }
	}

	Rectangle {
		x: 50 - parent.squize * 5;
		y: 50 - parent.squize * 5;
		id: r4;
		width: 30;
		height: 30;
		radius: 15;
		z: 1;
		color: "#F44336";
		opacity: 0.8;
		Behavior on x, y { Animation {duration: 400; easing: "linear";  cssTransition: true;} }
	}

	Behavior on rotate { Animation {duration: 850; cssTransition: true;} }

	Timer {
		id: spinTimer;
		running: parent.running && spinnerItem.recursiveVisible;
		interval: 600;
		repeat: true;

		onTriggered: {
			spinnerItem.rotate += 360;
			spinnerItem.squize = ++spinnerItem.squize % 5;
			if (spinnerItem.squize === 1) {
				var t = r1.z;
				r1.z = r2.z; r2.z = r3.z; r3.z = r4.z; r4.z = t;
			}
		}
	}
}
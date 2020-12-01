WebItem {
	id: spinnerItem;
	property bool running;
	width: 80;
	height: 80;
	transform.rotate: 0;
	property int squeeze: 0;
	property int squeezeX: squeeze * width * 5 / 80;
	property int squeezeY: squeeze * height * 5 / 80;

	start: {
		this.running = true;
	}

	stop: {
		this.running = false;
	}

	onRunningChanged: {
		spinnerItem.transform.rotate += 360;
		spinnerItem.squeeze = ++spinnerItem.squeeze % 5;
	}

	Rectangle {
		id: r1;
		x: parent.squeezeX;
		y: parent.squeezeY;
		width: spinnerItem.width * 3/8;
		height: spinnerItem.height * 3/8;
		radius: width / 2;
		color: "#FFEB3B";
		opacity: 0.8;
		Behavior on x, y { Animation {duration: 400; easing: "linear"; cssTransition: true;} }
	}

	Rectangle {
		id: r2;
		x: parent.width * 5/8 - parent.squeezeX;
		y: parent.squeezeY;
		width: spinnerItem.width * 3/8;
		height: spinnerItem.height * 3/8;
		radius: width / 2;
		color: "#4CAF50";
		opacity: 0.8;
		Behavior on x, y { Animation {duration: 400; easing: "linear";  cssTransition: true;} }
	}

	Rectangle {
		x: parent.squeezeX;
		y: spinnerItem.height * 5/8 - parent.squeezeY;
		id: r3;
		width: spinnerItem.width * 3/8;
		height: spinnerItem.height * 3/8;
		radius: width / 2;
		color: "#2196F3";
		opacity: 0.8;
		Behavior on x, y { Animation {duration: 400; easing: "linear";  cssTransition: true;} }
	}

	Rectangle {
		x: spinnerItem.height * 5/8 - parent.squeezeX;
		y: spinnerItem.height * 5/8 - parent.squeezeY;
		id: r4;
		width: spinnerItem.width * 3/8;
		height: spinnerItem.height * 3/8;
		radius: width / 2;
		z: 1;
		color: "#F44336";
		opacity: 0.8;
		Behavior on x, y { Animation {duration: 400; easing: "linear";  cssTransition: true;} }
	}

	Behavior on transform { Animation {duration: 850; cssTransition: true;} }

	Timer {
		id: spinTimer;
		running: parent.running && spinnerItem.recursiveVisible;
		interval: 600;
		repeat: true;

		onTriggered: {
			spinnerItem.transform.rotate += 360;
			spinnerItem.squeeze = ++spinnerItem.squeeze % 5;
			if (spinnerItem.squeeze === 1) {
				var t = r1.z;
				r1.z = r2.z; r2.z = r3.z; r3.z = r4.z; r4.z = t;
			}
		}
	}
}

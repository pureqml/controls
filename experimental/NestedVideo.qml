VideoPlayer {
	property bool display;
	width: 290s;
	height: 170s;
	transform.scaleX: display ? 1.1 : 0.001;
	transform.scaleY: 1.1;
	autoPlay: true;
	visible: false;

	showPlayerAt(x, y): {
		this.x = x
		this.y = y
		this.visible = true
		this.display = true
	}

	hide: {
		this.visible = false
		this.display = false
		this.stop()
	}

	Behavior on transform { Animation { duration: 300; delay: 300; } }
}

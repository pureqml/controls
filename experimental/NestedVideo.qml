Rectangle {
	property bool display;
	width: 290s;
	height: 170s;
	transform.scaleX: display ? 1.1 : 0.001;
	transform.scaleY: 1.1;
	visible: false;
	clip: true;
	color: "transparent";

	VideoPlayer {
		id: videoPlayer;
		anchors.fill: parent;
		autoPlay: true;
	}

	showPlayerAt(x, y, source): {
		this.x = x
		this.y = y
		this.visible = true
		this.display = true
		videoPlayer.source = source
	}

	hide: {
		this.visible = false
		this.display = false
		videoPlayer.stop()
	}

	Behavior on transform { Animation { duration: 300; delay: 300; } }
}

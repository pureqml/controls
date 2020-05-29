Rectangle {
	property bool display;
	transform.scaleX: display ? 1.05 : 0.001;
	transform.rotateZ: display ? 0 : -180;
	transform.scaleY: display ? 1.05 : 0.001;
	visible: false;
	clip: true;
	color: "transparent";

	VideoPlayer {
		id: videoPlayer;
		anchors.fill: parent;
		autoPlay: true;
	}

	showAndPlay(source): {
		this.visible = true
		this.display = true
		videoPlayer.source = source
	}

	hide: {
		this.visible = false
		this.display = false
		videoPlayer.source = ""
		videoPlayer.stop()
	}

	Behavior on transform { Animation { duration: 400; delay: 400; } }
}

Rectangle {
	property bool display;
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

	showAndPlay(source): {
		this.visible = true
		this.display = true
		videoPlayer.source = source
	}

	hide: {
		this.visible = false
		videoPlayer.source = ""
		videoPlayer.stop()
	}

	Behavior on transform { Animation { duration: 300; delay: 300; } }
}

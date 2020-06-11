Rectangle {
	property bool display;
	visible: false;
	clip: true;
	color: "transparent";

	VideoPlayer {
		id: videoPlayer;
		anchors.fill: parent;
		autoPlay: true;
	}

	showAndPlay(source): {
		log('VideoPlayer showAndPlay', source)
		this.visible = true
		this.display = true
		videoPlayer.source = source
	}

	hide: {
		log('VideoPlayer hide')
		this.visible = false
		this.display = false
		videoPlayer.source = ""
		videoPlayer.stop()
	}
}

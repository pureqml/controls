///COntrol for playing audio
Object {
	property bool autoPlay: true;	///<autoplay flag, audio start to play immediately after source was changed
	property string source: "";		///<audio source URL

	///@private
	onSourceChanged: {
		if (!this.element)
			return

		this.element.dom.src = value
		if (this.autoPlay)
			this.play()
	}

	/// play current audio
	play: { this.element.dom.play() }

	/// pause current audio
	pause: { this.element.dom.pause() }

	///@private
	onAutoPlayChanged: { if (value) this.play() }

	/// @private returns tag for corresponding element
	function getTag() { return 'audio' }
}

///Control for playing audio
Item {
	signal finished;				///< audio finished signal
	property bool ready;			///< read only property becomes 'true' when audio is ready to play, 'false' otherwise
	property bool autoPlay: true;	///<autoplay flag, audio start to play immediately after source was changed
	property bool loop;				///<audio loop flag
	property string source;			///<audio source URL

	constructor: {
		var audio = this.element
		var self = this

		audio.on('ended', function() { self.finished() }.bind(self))
		audio.on('canplay', function(state) { self.ready = state.type === "canplay" }.bind(self))
	}

	///@private
	onSourceChanged: {
		if (!this.element)
			return

		this.ready = false
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

	///@private
	onLoopChanged: { this.element.setAttribute('loop', value) }

	///@private
	onFinished: { this.ready = false }

	/// @private returns tag for corresponding element
	function getTag() { return 'audio' }
}

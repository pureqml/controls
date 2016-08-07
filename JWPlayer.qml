Item {
	signal finished;
	signal error;
	property int	duration;
	property int	progress;
	property int	buffered;
	property bool	autoPlay;
	property bool	loop: false;
	property bool	ready : false;
	property bool	paused: false;
	property bool	muted: false;
	property bool	waiting: false;
	property bool	seeking: false;
	property float	volume: 1.0;
	property string	source;
	property string	provider;

	function _update(name, value) {
		switch (name) {
			case 'width': this._updateSize(); break
			case 'height': this._updateSize(); break
		}

		qml.core.Item.prototype._update.apply(this, arguments);
	}

	function _updateSize() {
		var style = { width: this.width, height: this.height }

		this._setupPlayer(style)
		this.style(style)
	}

	_setupPlayer(options): {
		if (!this._jwplayer || !this._videoId) {
			log("Player not init yet")
			return
		}
		this._jwplayer(this._videoId).setup(options);
	}

	_player: { return this._jwplayer(this._videoId) }

	play: { this._player().play() }
	pause: { this._player().play() }
	//TODO impl
	seek(value): { }
	seekTo(value): { }

	onSourceChanged: {
		this.ready = false
		this._setupPlayer({"file": value})
	}

	onReadyChanged: {
		if (value)
			this.provider = this._player().getProvider().name
	}

	onCompleted: {
		if (!window.jwplayer) {
			log("JW player not found! Maybe you forget to include 'jwplayer.js' file?")
			return
		}
		this._jwplayer = window.jwplayer
		this._videoId = "videoDiv" + Math.floor(Math.random() * 100500)
 
		var player = this.getContext().createElement('div')
		player.id = this._videoId
		this.element.append(player)

		var options = {}
		options.file = this.source
		options.width = this.width
		options.height = this.height

		if (options)
			this._setupPlayer(options)

		var self = this
		this._player().setControls(false)
		this._player().on('ready', function(event) { log("jwplayer ready"); self.ready = true })
		this._player().on('pause', function(event) { log("jwplayer paused"); self.paused = true })
		this._player().on('error', function(event) { log("jwplayer error"); } )
		this._player().on('play', function(event) { log("jwplayer play"); } )
		this._player().on('bufferChange', function(event) { log("jwplayer bufferChange"); } )

		if (this.autoPlay && this.source)
			this.play()
	}
}

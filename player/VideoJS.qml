///Video palyer based on JWplayer
Item {
	width: 640;				///< @private
	height: 480;			///< @private
	signal error;			///< error occured signal
	signal finished;		///< video finished signal
	property string	source;	///< video source URL
	property Color	backgroundColor: "#000";	///< default background color
	property float	volume: 1.0;	///< video volume value [0:1]
	property bool	loop;			///< video loop flag
	property bool	ready;			///< read only property becomes 'true' when video is ready to play, 'false' otherwise
	property bool	muted;			///< volume mute flag
	property bool	paused;			///< video paused flag
	property bool	waiting;		///< wating flag while video is seeking and not ready to continue playing
	property bool	seeking;		///< seeking flag
	property bool	autoPlay;		///< play video immediately after source changed
	property bool	controls;		///< display VideoJS controls
	property int	duration;		///< content duration in seconds (valid only for not live videos)
	property int	progress;		///< current playback progress in seconds
	property int	buffered;		///< buffered contetnt in seconds
	property bool	logsEnabled: recursiveVisible;

	///@private
	function getTag() { return 'video' }

	///@private
	constructor: {
		if (!window.videojs) {
			log("'videojs' is undefined it looks like you forget to add 'video.js'")
			return
		}
		this.element.setAttribute('id', 'videojs')
		if (this.controls)
			this.element.setAttribute('controls')
		if (this.autoPlay)
			this.element.setAttribute('autoplay')
		this.element.setAttribute('preload', 'auto')
		this.element.setAttribute('data-setup', '{}')
		this.element.setAttribute('class', 'video-js')

		var player = this.element
		var dom = player.dom
		var self = this
		player.on('play', function() { self.waiting = false; self.paused = dom.paused }.bind(this))
		player.on('error', function() { log("Player error occured"); self.error() }.bind(this))
		player.on('pause', function() { self.paused = dom.paused }.bind(this))
		player.on('ended', function() { self.finished() }.bind(this))
		player.on('seeked', function() { log("seeked"); self.seeking = false; this.waiting = false }.bind(this))
		player.on('canplay', function() { log("canplay", dom.readyState); this.ready = dom.readyState }.bind(this))
		player.on('seeking', function() { log("seeking"); self.seeking = true; this.waiting = true }.bind(this))
		player.on('waiting', function() { log("waiting"); self.waiting = true }.bind(this))
		player.on('stalled', function() { log("Was stalled", dom.networkState); }.bind(this))
		player.on('emptied', function() { log("Was emptied", dom.networkState); }.bind(this))
		player.on('volumechange', function() { self.muted = dom.muted }.bind(this))
		player.on('canplaythrough', function() { log("ready to play"); }.bind(this))

		player.on('timeupdate', function() {
			self.waiting = false
			if (!self.seeking)
				self.progress = dom.currentTime
		}.bind(this))

		player.on('durationchange', function() {
			var d = dom.duration
			self.duration = isFinite(d) ? d : 0
		}.bind(this))

		player.on('progress', function() {
			var last = dom.buffered.length - 1
			self.waiting = false
			if (last >= 0)
				self.buffered = dom.buffered.end(last) - dom.buffered.start(last)
		}.bind(this))

		this._player = window.videojs('videojs')
	}

	endsWith(str, tail): {
		return str.indexOf(tail) == str.length - tail.length
	}

	onSourceChanged: {
		var url = value
		var media = { 'src': url }
		if (url) {
			var urlLower = url.toLowerCase()
			if (this.endsWith(urlLower, '.m3u8') || this.endsWith(urlLower, '.m3u'))
				media.type = 'application/x-mpegURL'
		}

		this._player.src(media);

		var self = this
		self.ready = false
		this._player.ready(function() {
			log("VideoJS ready")
			self.ready = true
			if (self.autoPlay)
				self.play()
		}.bind(this))
	}

	///play video
	play(state): { this._player.play(state) }

	///pause video
	pause: { this.element.dom.pause() }

	///stop video
	stop: { this.element.dom.pause() }

	/**@param value:int seek time in seconds
	seek video on 'value' seconds respectivly current playback progress*/
	seek(value): { this.element.dom.currentTime += value }

	/**@param value:int progress time in seconds
	set video progres to fixed second*/
	seekTo(value): { this.element.dom.currentTime = value }

	///@private
	toggleAttr(name, value): {
		if (value)
			this.element.setAttribute(name)
		else
			this.element.removeAttribute(name)
	}

	onAutoPlay: { this.toggleAttr('autoplay', value) }

	onControlsChanged: { this.toggleAttr('controls', value) }

	onWidthChanged: {
		this.element.dom.width = value
		if (this._player)
			this._player.width = value
	}

	onHeightChanged: {
		this.element.dom.height = value
		if (this._player)
			this._player.width = value
	}
}

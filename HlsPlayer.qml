Item {
	signal finished;
	signal error;
	property string	source;
	property Color	backgroundColor: "#000";
	property float	volume: 1.0;
	property bool	loop: false;
	property bool	ready: false;
	property bool	muted: false;
	property bool	paused: false;
	property bool	autoPlay: false;
	property bool	waiting: false;
	property bool	seeking: false;
	property int	duration;
	property int	progress;
	property int	buffered;

	function getTag() { return 'video' }

	constructor: {
		if (!window.Hls || !window.Hls.isSupported()) {
			log("Hls() is not supported. Maybe you forget to include 'hls.js'?")
			return
		}
		
		log("Init hls player...")
		this._hls = new Hls()
		var hls = this._hls

		this._hlsevents = Hls.Events
		this._hlserrorTypes = Hls.ErrorTypes
		this._hlserrorDetails = Hls.ErrorDetails
		hls.on(this._hlsevents.MANIFEST_PARSED, this.manifestParsedHandler)

		var self = this
		this._attachVideo = function() {
			log("hls.js attached")
			self.ready = false
		}.bind(this)

		hls.on(this._hlsevents.MEDIA_ATTACHED, this._attachVideo)
		hls.on(this._hlsevents.ERROR, this.errorHandling)
		this.initHls()

		var player = this.element
		var dom = this.element.dom
		player.on('play', function() { self.waiting = false; self.paused = dom.paused }.bind(this))
		player.on('error', function() { log("Player error occured"); self.error() }.bind(this))
		player.on('pause', function() { self.paused = dom.paused }.bind(this))
		player.on('ended', function() { self.finished() }.bind(this))
		player.on('seeked', function() { log("seeked"); self.seeking = false; self.waiting = false }.bind(this))
		player.on('canplay', function() { log("canplay", dom.readyState); self.ready = dom.readyState }.bind(this))
		player.on('seeking', function() { log("seeking"); self.seeking = true; self.waiting = true }.bind(this))
		player.on('waiting', function() { log("waiting"); self.waiting = true }.bind(this))
		player.on('stolled', function() { log("Was stolled", dom.networkState); }.bind(this))
		player.on('emptied', function() { log("Was emptied", dom.networkState); }.bind(this))
		player.on('volumechange', function() { self.muted = dom.muted }.bind(this))
		player.on('canplaythrough', function() { log("Canplaythrough"); }.bind(this))

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
	}

	initHls: { this._hls.attachMedia(this.element.dom) }

	deinit: { this._hls.detachMedia() }

	function errorHandling(event, data) {
		var types = this._hlserrorTypes
		var details = this._hlserrorDetails
		var errorType = data.type;
		var errorDetails = data.details;
		var fatal = data.fatal;
		var hls = this._hls

		if (fatal) {
			switch (errorType) {
			case types.NETWORK_ERROR:
				log("HLS Error: NETWORK_ERROR")
				log("try to recover...")
				hls.startLoad()
				break
			case types.MEDIA_ERROR:
				log("HLS Error: MEDIA_ERROR")
				log("try to recover...")
				hls.recoverMediaError()
				break
			default:
				log("Unknown error type:", errorType)
				//hls.destroy()
				break
			}
		} else {
			switch (errorDetails) {
			case details.MANIFEST_LOAD_ERROR:		log("HLS Error: FRAG_LOAD_ERROR"); break
			case details.MANIFEST_LOAD_TIMEOUT:		log("HLS Error: MANIFEST_LOAD_TIMEOUT"); break
			case details.MANIFEST_PARSING_ERROR:	log("HLS Error: MANIFEST_PARSING_ERROR"); break
			case details.LEVEL_LOAD_ERROR:			log("HLS Error: LEVEL_LOAD_ERROR"); break
			case details.LEVEL_LOAD_TIMEOUT:		log("HLS Error: LEVEL_LOAD_TIMEOUT"); break
			case details.LEVEL_SWITCH_ERROR:		log("HLS Error: LEVEL_SWITCH_ERROR"); break
			case details.LEVEL_SWITCH_ERROR:		log("HLS Error: LEVEL_SWITCH_ERROR"); break
			case details.FRAG_LOAD_ERROR:			log("HLS Error: FRAG_LOAD_ERROR"); break
			case details.FRAG_LOOP_LOADING_ERROR:	log("HLS Error: FRAG_LOOP_LOADING_ERROR"); break
			case details.FRAG_LOAD_TIMEOUT:			log("HLS Error: FRAG_LOAD_TIMEOUT"); break
			case details.FRAG_PARSING_ERROR:		log("HLS Error: FRAG_PARSING_ERROR"); break
			case details.BUFFER_ADD_CODEC_ERROR:	log("HLS Error: BUFFER_ADD_CODEC_ERROR"); break
			case details.BUFFER_APPEND_ERROR:		log("HLS Error: BUFFER_APPEND_ERROR"); break
			case details.BUFFER_APPENDING_ERROR:	log("HLS Error: BUFFER_APPENDING_ERROR"); break
			case details.BUFFER_STALLED_ERROR:		log("HLS Error: BUFFER_STALLED_ERROR"); break
			case details.BUFFER_FULL_ERROR:			log("HLS Error: BUFFER_FULL_ERROR"); break
			case details.BUFFER_SEEK_OVER_HOLE:		log("HLS Error: BUFFER_SEEK_OVER_HOLE"); break
			case details.MANIFEST_INCOMPATIBLE_CODECS_ERROR: log("HLS Error: MANIFEST_INCOMPATIBLE_CODECS_ERROR"); break
			default: log("HLS Error: Unknown error"); break
			}
		}
		this.error(data)
	}

	function manifestParsedHandler(event, data) {
		log("manifest parsed, found " + data.levels.length + " quality level")
		this.ready = true
	}

	play: { this.element.dom.play() }
	stop: { this.element.dom.pause(); this.deinit() }
	pause: { this.element.dom.pause() }
	seek(value): { }
	seekTo(value): { }

	onSourceChanged: {
		if (!this._hls)
			return
		this.stop()
		this.deinit()
		this.initHls()
		this._hls.loadSource(value)
		if (this.autoPlay)
			this.play()
	}
}

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

		this._player = window.videojs('videojs')
	}

	onSourceChanged: {
		this._player.src({
			src: value,
			type: 'application/x-mpegURL'
		});

		var self = this
		this._player.ready(function() { log("VideoJS ready", value); self.play() }.bind(this))
	}

	///play video
	play(state): { this._player.play(state) }

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

///Video paly er based on shaka-player
Item {
	width: 640; height: 480;
	signal error;		///< error occured signal
	signal finished;	///< video finished signal
	property string	source;	///< video source URL
	property Color	backgroundColor: "#000";	///< default background color
	property float	volume: 1.0;		///< video volume value [0:1]
	property bool	loop: false;		///< video loop flag
	property bool	ready: false;		///< read only property becomes 'true' when video is ready to play, 'false' otherwise
	property bool	muted: false;		///< volume mute flag
	property bool	paused: false;		///< video paused flag
	property bool	waiting: false;		///< wating flag while video is seeking and not ready to continue playing
	property bool	seeking: false;		///< seeking flag
	property bool	autoPlay: false;	///< play video immediately after source changed
	property int	duration;			///< content duration in seconds (valid only for not live videos)
	property int	progress;			///< current playback progress in seconds
	property int	buffered;			///< buffered contetnt in seconds

	///@private
	function getTag() { return 'video' }

	///@private
	constructor: {
		var shaka = window.shaka
		if (!shaka) {
			log("shaka is undefined maybe you forget to include 'shaka-player.compiled.js'")
			return
		}
		if (!shaka.Player.isBrowserSupported()) {
			log("shaka player is not supported for this browser")
			return
		}

		this._player = new shaka.Player(this.element.dom)

		var errorCallback = function(event) { log("Error", event) }
		this._player.addEventListener('error', this.error);
		this.element.setAttribute('controls', '')
		this.element.setAttribute('autoplay', '')
	}

	///@private
	onSourceChanged: {
		this._player.load(this.source).then(function() {
			log('The video has now been loaded!');
		}).catch(function(err) {
			log("Error while loading", err)
		});
	}

	onWidthChanged: { this.element.dom.width = value; }
	onHeightChanged: { this.element.dom.height = value; }

}

///Video palyer based on JWplayer
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
	property bool	logsEnabled: recursiveVisible;


	///@private
	constructor: {
		this.element.setAttribute('id', 'jwplayer')

		this._player = window.jwplayer('jwplayer')
//		this._player.setup({});
		this._player.on('all', function (e, x) {
			log("on all", e, x)
		})
	}

	///@private
	onSourceChanged: {
		this._player.setup({
			file: value,
			volume: 10,
			title: "My Favorite Video!",
		    description: "This has lots of kittens in it!"
		});
	}

	play(state): {
		this._player.play(state)
	}

	loadPlaylist(pl): {

		this._player.setup(pl[0])

		var self = this;

		this._player.on('all', function (e, x) {
			if (e !== "time" && self.logsEnabled)
				log("JWplayer event", e, x)
		})



		this._player.load(pl)
	}

	onWidthChanged: { this.element.dom.width = value; }
	onHeightChanged: { this.element.dom.height = value; }
}

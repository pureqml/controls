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
		this.element.setAttribute('id', 'bitmovin')

		this.conf = {
			key:       "8ea98414-488b-41cf-ac9b-fdec00b58572",
			source: {
				poster:      "//bitmovin-a.akamaihd.net/content/MI201109210084_1/poster.jpg"
			}
		};

		this._player = window.bitmovin.player("bitmovin");
	}

	///@private
	onSourceChanged: {
		this.conf.source.hls = value;

		if (this._player.isSetup())
			this._player.unload()

		this._player.setup(this.conf).then(function(value) {
			// Success
			console.log("Successfully created bitmovin player instance");
		}, function(reason) {
			// Error!
			console.log("Error while creating bitmovin player instance");
		});

	}

	play(state): {
		// this._player.play(state)
	}

	loadPlaylist(pl): {

		this._player.setup(pl[0])

		var self = this;

		this._player.on('all', function (e, x) {
			if (e !== "time" && self.logsEnabled)
			    console.log("JWplayer event", e, x)
		})



		this._player.load(pl)
	}

	onWidthChanged: { this.element.dom.width = value; }
	onHeightChanged: { this.element.dom.height = value; }
}

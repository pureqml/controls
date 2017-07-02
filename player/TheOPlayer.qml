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
		this.element.setAttribute('class', 'theoplayer-container video-js theoplayer-skin theo-seekbar-above-controls')

		var element = document.querySelector('.theoplayer-container'); 
		this._player = new window.THEOplayer.Player(element, { 
			libraryLocation : ''
		});

		this._player.source = {
			sources : [{
				src : '//cdn.theoplayer.com/video/star_wars_episode_vii-the_force_awakens_official_comic-con_2015_reel_(2015)/index.m3u8',
				type : 'application/x-mpegurl'
			}]
		};
	}

	onSourceChanged: {
		this._player.source = {
			sources : [{
				src : value,
				type : 'application/x-mpegurl'
			}]
		};
	}

	play(state): {
		// this._player.play(state)
	}

	loadPlaylist(pl): {

	}

	onWidthChanged: { this.element.dom.width = value; }
	onHeightChanged: { this.element.dom.height = value; }
}

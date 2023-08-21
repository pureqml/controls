///item for embedded youtube video
Item {
	property string source;			///< video source URL
	property bool allowFullScreen;	///< allow fullscreen flag
	height: 315;	///<@private
	width: 560;		///<@private

	///@private
	onWidthChanged,
	onHeightChanged: { this._updateSize(); }

	///@private
	onSourceChanged: { this.element.dom.src = value; }

	///@private
	onAllowFullScreenChanged: { this.element.dom.allowFullscreen = value; }

	htmlTag: "iframe";

	///@private
	function _updateSize() {
		var style = { width: this.width, height: this.height }
		this.style(style)
	}
}

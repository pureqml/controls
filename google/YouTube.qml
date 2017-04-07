///item for embedded youtube video
Item {
	property string source;			///< video source URL
	property bool allowFullScreen;	///< allow fullscreen flag
	height: 315;	///<@private
	width: 560;		///<@private

	///@private
	function _update(name, value) {
		switch (name) {
			case 'width': this._updateSize(); break
			case 'height': this._updateSize(); break
			case 'source': this.element.dom.src = value; break
			case 'allowFullScreen': this.element.dom.allowFullscreen = value; break
		}

		_globals.core.Item.prototype._update.apply(this, arguments);
	}

	///@private
	function getTag() { return 'iframe' }

	///@private
	function _updateSize() {
		var style = { width: this.width, height: this.height }
		this.style(style)
	}
}

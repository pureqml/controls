Item {
	property bool autoPlay: true;
	property string source: "";

	function _update(name, value) {
		switch (name) {
			case 'source': this.element.dom.src = value; if (this.autoPlay) this.play(); break
		}
		_globals.core.Item.prototype._update.apply(this, arguments);
	}

	play: { this.element.play() }
	pause: { this.element.pause() }
	onAutoPlayChanged: { if (value) this.play() }

	/// returns tag for corresponding element
	function getTag() { return 'audio' }
}

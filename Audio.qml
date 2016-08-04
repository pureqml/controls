Item {
	property bool autoPlay: true;
	property string source: "";

	function _update(name, value) {
		switch (name) {
			case 'source': this.element[0].setAttribute('src', value); if (this.autoPlay) this.play(); break
		}
		qml.core.Item.prototype._update.apply(this, arguments);
	}

	play: { this._audioPlayer.play() }
	pause: { this._audioPlayer.pause() }
	onAutoPlayChanged: { if (value) this.play() }

	constructor: {
		this.element.remove()
		this.element = $(this.getContext().createElement('audio'))
		this._audioPlayer = this.element[0]
		this.parent.element.append(this.element)
	}
}

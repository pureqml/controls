Item {
	property string source;
	property bool allowFullScreen;
	height: 315;
	width: 560;

	function _update(name, value) {
		switch (name) {
			case 'width': this._updateSize(); break
			case 'height': this._updateSize(); break
			case 'source': this.element[0].src = value; break
			case 'allowFullScreen': this.element[0].allowFullscreen = value; break
		}

		qml.core.Item.prototype._update.apply(this, arguments);
	}

	constructor: {
		this.element.remove()
		this.element = this._context.createElement('iframe')
		this.parent.element.append(this.element)
	}

	function _updateSize() {
		var style = { width: this.width, height: this.height }
		this.style(style)
	}
}

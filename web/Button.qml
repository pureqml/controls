Item {
	property string text;
	property Font font: Font { }
	property Border border: Border { }

	function _update(name, value) {
		switch (name) {
			case 'height': this._updateSize(); break
			case 'width': this._updateSize(); break
			case 'text': this.element.dom.innerText = value; break;
		}
		_globals.core.Item.prototype._update.apply(this, arguments)
	}

	/// returns tag for corresponding element
	function getTag() { return 'button' }

	function _updateSize() {
		var style = { width: this.width, height: this.height }
		this.style(style)
	}
}

Item {
	property Font font: Font {}
	property Color color: "#000";
	property string value;
	width: 100;
	height: 40;

	constructor: {
		this.element.on("change", function() { this.value = this.element.dom.value }.bind(this))
	}

	/// @private
	function _update(name, value) {
		switch (name) {
			case 'width':
			case 'height': this._updateSize(); break
		}

		_globals.core.Item.prototype._update.apply(this, arguments);
	}

	/// @private
	function getTag() { return 'select' }

	/// @private
	function _updateSize() {
		var style = { width: this.width, height: this.height }
		this.style(style)
	}

	/// add option into select
	append(text): {
		var option = this._context.createElement('option')
		option.dom.value = text
		option.dom.innerHTML = text
		this.element.append(option)
	}
}

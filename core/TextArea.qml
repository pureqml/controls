InputBase {
	property Paddings paddings: Paddings {}
	property string text;
	width: 150;
	height: 100;

	function _update(name, value) {
		switch (name) {
			case 'text': if (value != this.element.dom.value) this.element.dom.value = value; break
		}

		_globals.core.InputBase.prototype._update.apply(this, arguments);
	}

	/// returns tag for corresponding element
	function getTag() { return 'textarea' }

	constructor: {
		this.element.on("input", function() { this.text = this.element.dom.value }.bind(this))
	}
}

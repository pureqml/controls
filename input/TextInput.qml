BaseInput {
	property string text;
	property bool passwordMode: false;
	height: 20;
	width: 173;
	type: passwordMode ? "password" : "text";

	function _update(name, value) {
		switch (name) {
			case 'text': if (value != this.element.dom.value) this.element.dom.value = value; break
		}
		_globals.controls.input.BaseInput.prototype._update.apply(this, arguments);
	}

	onActiveFocusChanged: {
		if (value)
			this.element.dom.select()
		else
			this.element.dom.blur()
	}

	constructor: {
		this.element.on("input", function() { this.text = this.element.dom.value }.bind(this))
	}
}

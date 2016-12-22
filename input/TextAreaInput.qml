BaseInput {
	property string text;
	width: 150;
	height: 100;

	function _update(name, value) {
		switch (name) {
			case 'text': if (value != this.element.dom.value) this.element.dom.value = value; break
		}

		_globals.controls.input.BaseInput.prototype._update.apply(this, arguments);
	}

	/// returns tag for corresponding element
	function getTag() { return 'textarea' }

	function registerStyle(style, tag) {
		style.addRule('textarea', "position: absolute; visibility: inherit; border-style: solid; border-width: 0px; box-sizing: border-box; resize: none;")
		style.addRule('textarea:focus', "outline: none;")
	}

	constructor: {
		this.element.on("input", function() { this.text = this.element.dom.value }.bind(this))
	}
}

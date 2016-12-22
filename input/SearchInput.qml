BaseInput {
	property string text;
	width: 100;
	height: 25;
	type: "search";

	function _update(name, value) {
		_globals.controls.input.BaseInput.prototype._update.apply(this, arguments);
	}

	constructor: {
		this.element.on("input", function() { this.text = this.element.dom.value }.bind(this))
	}
}

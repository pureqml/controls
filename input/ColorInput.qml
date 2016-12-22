BaseInput {
	property Color value;
	width: 100;
	height: 25;
	type: "color";

	function _update(name, value) {
		_globals.controls.input.BaseInput.prototype._update.apply(this, arguments);
	}

	constructor: {
		this.element.on("input", function() { this.color = this.element.dom.value }.bind(this))
	}
}

BaseInput {
	property string max;
	property string min;
	property string value;
	width: 75;
	height: 20;
	type: "time";

	function _update(name, value) {
		switch (name) {
			case 'min': this.element.dom.min = value; break
			case 'max': this.element.dom.max = value; break
		}

		_globals.controls.input.BaseInput.prototype._update.apply(this, arguments);
	}

	constructor: {
		this.element.on("change", function() { this.value = this.element.dom.value }.bind(this))
	}
}

InputBase {
	property float max;
	property float min;
	property float step;
	property float value;
	width: 100;
	height: 25;
	type: "number";

	function _update(name, value) {
		switch (name) {
			case 'min': this.element.dom.min = value; break
			case 'max': this.element.dom.max = value; break
			case 'step': this.element.dom.step = value; break
			case 'value': this.element.dom.value = value; break
		}
		_globals.controls.core.InputBase.prototype._update.apply(this, arguments);
	}

	constructor: {
		this.element.on("input", function() { this.value = this.element.dom.value }.bind(this))
	}
}

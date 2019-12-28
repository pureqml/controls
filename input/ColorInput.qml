///color selecting input
BaseInput {
	width: 80;
	height: 32;
	type: "color";

	onColorChanged: {
		this._updateValue(value)
	}

	constructor: {
		this.element.on("input", function(e) { this.color = e.target.value; }.bind(this))
	}
}

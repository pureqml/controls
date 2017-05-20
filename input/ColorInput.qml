BaseInput {
	width: 80;
	height: 32;
	type: "color";

	onColorChanged: {
		if (value != this.element.dom.value)
			this.element.dom.value = value;
	}

	constructor: {
		this.element.on("input", function(e) { this.color = e.target.value; }.bind(this))
	}
}

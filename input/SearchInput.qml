BaseInput {
	property string text;
	width: 100;
	height: 25;
	type: "search";

	onTextChanged: { if (value != this.element.dom.value) this.element.dom.value = value }

	constructor: {
		this.element.on("input", function() { this.text = this.element.dom.value }.bind(this))
	}
}

BaseInput {
	property bool checked: false;
	height: 20;
	width: 20;
	type: "checkbox";

	onCheckedChanged: {
		this.element.dom.checked = value
	}

	constructor: {
		this.element.on("change", function() { this.checked = this.element.dom.checked }.bind(this))
	}
}

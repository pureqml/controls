InputBase {
	property bool checked: false;
	height: 20;
	width: 173;
	type: "checkbox";

	constructor: {
		this.element.on("change", function() { this.checked = this.element.dom.checked }.bind(this))
	}
}

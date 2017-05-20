BaseInput {
	property string max;
	property string min;
	property string value;
	width: 75;
	height: 20;
	type: "time";

	onMinChanged: { this.element.dom.min = value; }
	onMaxChanged: { this.element.dom.max = value; }

	constructor: { this.element.on("change", function() { this.value = this.element.dom.value }.bind(this)) }
}

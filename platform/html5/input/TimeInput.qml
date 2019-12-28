///time selecting input
BaseInput {
	property string max;	///< maximum time value
	property string min;	///< minimal time value
	property string value;	///< current value
	width: 75;
	height: 20;
	type: "time";

	onMinChanged: { this.element.dom.min = value; }
	onMaxChanged: { this.element.dom.max = value; }

	constructor: { this.element.on("change", function() { this.value = this.element.dom.value }.bind(this)) }
}

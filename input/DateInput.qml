///date selecting input
BaseInput {
	property string max;	///< maximum date value
	property string min;	///< minimal date value
	property string value;	///< current date value
	width: 150;
	height: 20;
	type: "date";

	onMinChanged: { this.element.dom.min = value; }
	onMaxChanged: { this.element.dom.max = value; }

	constructor: {
		this.element.on("change", function() { this.value = this.element.dom.value }.bind(this))
	}
}

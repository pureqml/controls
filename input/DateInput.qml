///date selecting input
BaseInput {
	property string max;	///< maximum date value
	property string min;	///< minimal date value
	property string value;	///< current date value
	width: 150;
	height: 20;
	type: "date";

	onMinChanged: { this.element.setProperty('min', value) }
	onMaxChanged: { this.element.setProperty('max', value) }

	constructor: {
		this.element.on("change", function() {
			this.value = this._getValue()
		}.bind(this))
	}
}

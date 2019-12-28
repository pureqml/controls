///time selecting input
BaseInput {
	property string max;	///< maximum time value
	property string min;	///< minimal time value
	property string value;	///< current value
	width: 75;
	height: 20;
	type: "time";

	onMinChanged: { this.element.setAttribute('min', value) }
	onMaxChanged: { this.element.setAttribute('max', value) }

	constructor: {
		this.element.on("change", function() {
			this.value = this._getValue()
		}.bind(this))
	}
}

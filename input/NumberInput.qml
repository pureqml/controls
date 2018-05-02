///number input
BaseInput {
	property float max;		///< maximum number value
	property float min;		///< minimum number value
	property float step;	///< number step value
	property float value;	///< number value
	horizontalAlignment: BaseInput.AlignHCenter;
	width: 50;
	height: 25;
	type: "number";

	onMinChanged: { this.element.dom.min = value; }
	onMaxChanged: { this.element.dom.max = value; }
	onStepChanged: { this.element.dom.step = value; }
	onValueChanged: { this.element.dom.value = value; }

	constructor: {
		this.element.on("input", function() {
			var currentValue = this.element.dom.value
			this.value = currentValue <= this.max && currentValue >= this.min ? currentValue : (currentValue > this.max ? this.max : this.min)
		}.bind(this))
	}
}

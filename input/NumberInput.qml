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

	onMinChanged: { this.element.setProperty('min', value) }
	onMaxChanged: { this.element.setProperty('max', value) }
	onStepChanged: { this.element.setProperty('step', value) }
	onValueChanged: {
		this.value = this._setValueWithLimits(value);
	}

	/// @private - sets element native value while applying min/max limits. if called externally, onValueChanged will not fire
	function _setValueWithLimits(_value) {
		if(_value > this.max) {
			_value = this.max;
		} else if(_value < this.min) {
			_value = this.min;
		}
		this._setValue(_value);
		return(_value);
	}

	constructor: {
		 this.element.on("input", function() {
			 this.value = this._setValueWithLimits(this._getValue());
		 }.bind(this))
	}
}

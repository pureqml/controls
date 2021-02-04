///number input
BaseInput {
	id: rootNumberInput;
	property float max;                 ///< maximum number value
	property float min;                 ///< minimum number value
	property float step;                ///< number step value
	property float value;               ///< number value
	property float debounceTimeout: 0;  ///< set to non zero to debounce input allowing user time to type characters (suggest 500)
	horizontalAlignment: BaseInput.AlignHCenter;
	width: 50;
	height: 25;
	type: "number";

	onMinChanged: { this.element.setProperty('min', value) }
	onMaxChanged: { this.element.setProperty('max', value) }
	onStepChanged: { this.element.setProperty('step', value) }
	onValueChanged: {
		this.startDebounce(value);
	}

	Timer {
		id: debounceTimer;
		interval: rootNumberInput.debounceTimeout;
		property float value;
		triggeredOnStart: false;

		onTriggered: {
			rootNumberInput.value = rootNumberInput._setValueWithLimits(this.value);
		}
	}

	function startDebounce(value) {
		debounceTimer.value = value;
		debounceTimer.restart();
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
			 this.startDebounce(this._getValue());
		 }.bind(this))
	}
}

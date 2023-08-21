///range input
Item {
	property int value;		///< current value
	property int min: 0;	///< minimal range value
	property int max: 100;	///< maximum range value
	property int step: 1;	///< range step
	property enum orientation { Horizontal, Vertical };	///< range position orientation
	height: 30;

	/// @private
	constructor: {
		this.element.setAttribute('type', 'range')
		this._setValue(0)
		this.element.on("input", function() {
			this.value = this._getValue()
		}.bind(this))
	}

	/// @private
	onMinChanged: { this.element.setProperty('min', value) }

	/// @private
	onMaxChanged: { this.element.setProperty('max', value) }

	/// @private
	onStepChanged: { this.element.setProperty('step', value) }

	/// @private
	onOrientationChanged: {
		switch (value) {
		case this.Horizontal:
			this.style("appearance", "slider-horizontal")
			this.element.setAttribute('orient', 'horizontal')
			break
		case this.Vertical:
			this.style("appearance", "slider-vertical")
			this.element.setAttribute('orient', 'vertical')
			break
		}
	}

	htmlTag: "input";

	/// gets element native value
	function _getValue() {
		return this.element.getProperty('value')
	}

	/// sets element native value
	function _setValue(value) {
		this.element.setProperty('value', value)
	}
}

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
		this.element.dom.type = "range"
		this.element.dom.value = 0
		this.element.on("input", function() { this.value = this.element.dom.value }.bind(this))
	}

	/// @private
	onMinChanged: { this.element.dom.min = value; }

	/// @private
	onMaxChanged: { this.element.dom.max = value; }

	/// @private
	onStepChanged: { this.element.dom.step = value; }

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

	/// returns tag for corresponding element
	function getTag() { return 'input' }
}

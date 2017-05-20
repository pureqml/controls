Item {
	property int value;
	property int min: 0;
	property int max: 100;
	property int step: 1;
	property enum orientation { Horizontal, Vertical };
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

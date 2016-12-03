Item {
	property int value;
	property int min: 0;
	property int max: 100;
	property int step: 1;

	/// @private
	constructor: {
		this.element.dom.type = "range"
		this.element.on("input", function() { this.value = this.element.dom.value }.bind(this))
	}

	/// @private
	function _update(name, value) {
		switch (name) {
			case 'min': this.element.dom.min = value; break
			case 'max': this.element.dom.max = value; break
			case 'step': this.element.dom.step = value; break
		}

		_globals.core.Item.prototype._update.apply(this, arguments);
	}

	/// returns tag for corresponding element
	function getTag() { return 'input' }
}

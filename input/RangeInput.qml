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
	function _update(name, value) {
		switch (name) {
			case 'min': this.element.dom.min = value; break
			case 'max': this.element.dom.max = value; break
			case 'step': this.element.dom.step = value; break
			case 'orientation':
				switch (value) {
				case this.Horizontal:
					this.transform.rotate = 0
					break
				case this.Vertical:
					this.transform.rotate = -90
					break
				}
		}

		_globals.core.Item.prototype._update.apply(this, arguments);
	}

	/// returns tag for corresponding element
	function getTag() { return 'input' }
}

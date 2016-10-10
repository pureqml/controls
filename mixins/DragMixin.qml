Object {
	property bool pressed;
	property bool enabled: true;

	constructor: { this.element = this.parent.element; }

	function _bindPressed(value) {
		var onDown = function() { 
			this.pressed = true 

		}.bind(this)
		var onUp = function() { this.pressed = false }.bind(this)

		if (value) {
			this.element.on('mousedown', onDown)
			this.element.on('mouseup', onUp)
		} else {
			this.element.removeListener('mousedown', onDown)
			this.element.removeListener('mouseup', onUp)
		}
	}

	onEnabledChanged: {
		this._bindPressed(value)
	}

	onCompleted: {
		if (this.enabled)
			this._bindPressed(true)
	}
}

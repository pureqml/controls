Object {
	property bool pressed;
	property bool enabled: true;

	constructor: { this.element = this.parent.element; }

	function _bindPressed(value) {
		if (value && !this._dmPressBinder) {
			this._dmPressBinder = new _globals.core.dmPressBinder(this.element)
			this._dmPressBinder.on('mousedown', function() { this.pressed = true }.bind(this))
			this._dmPressBinder.on('mouseup', function() { this.pressed = false }.bind(this))
		}
		if (this._dmPressBinder)
			this._dmPressBinder.enable(value)
	}

	onEnabledChanged: {
		this._bindPressed(value)
	}

	onCompleted: {
		this._bindPressed(this.enabled)
	}
}

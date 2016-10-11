Object {
	property bool pressed;
	property bool enabled: true;
	property int x;
	property int y;

	constructor: { this.element = this.parent.element; }

	function _bindPressed(value) {
		if (value && !this._dmPressBinder) {
			this._dmPressBinder = new _globals.core.EventBinder(this.element)
			this._dmPressBinder.on('mousedown', function(e) {
				e.preventDefault();
				this.pressed = true
				this._startX = e.clientX - this.parent.x
				this._startY = e.clientY - this.parent.y
				if (!this._dmMoveBinder) {
					this._dmMoveBinder = new _globals.core.EventBinder(context.window)
					this._dmMoveBinder.on('mousemove', function(e) {
						e.preventDefault();
						this.parent.y = e.clientY - this._startY
						this.parent.x = e.clientX - this._startX
					}.bind(this))

					this._dmMoveBinder.on('mouseup', function() { 
						this.pressed = false
						this._dmMoveBinder.enable(false)
					}.bind(this))
				} 
				this._dmMoveBinder.enable(true)
			}.bind(this))
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

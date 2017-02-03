Object {
	property bool moved;
	property bool pressed;
	property bool enabled: true;
	property int top;
	property int left;
	property int right;
	property int bottom;
	property enum direction { Any, Vertical, Horizontal };

	constructor: {
		this.element = this.parent.element;
		this._bindPressed(this.enabled)
	}

	function _moveHandler(e) {
		e.preventDefault();

		if (e.changedTouches)
			e = e.changedTouches[0]

		if (this.direction !== this.Horizontal) {
			var eY = e.clientY, sY = this._startY, top = this.top, bottom = this.bottom
			if (bottom  && (eY - sY > bottom)) {
				this.parent.y = bottom
			}
			else if (top && (eY - sY < top))
				this.parent.y = top
			else {
				this.moved = true;
				this.parent.y = eY - sY
			}
		}
		if (this.direction !== this.Vertical) {
			var eX = e.clientX, sX = this._startX, left = this.left, right = this.right
			if (right  && (eX - sX > right)) {
				this.parent.x = right
			}
			else if (left && (eX - sX < left))
				this.parent.x = left
			else {
				this.moved = true;
				this.parent.x = eX - sX
			}
		}
	}

	function _downHandler(e) {
		e.preventDefault();
		this.pressed = true

		if (e.changedTouches)
			e = e.changedTouches[0]

		this._startX = e.clientX - this.parent.x
		this._startY = e.clientY - this.parent.y
		if (!this._dmMoveBinder) {
			this._dmMoveBinder = new _globals.core.EventBinder(context.window)

			this._dmMoveBinder.on('mousemove', this._moveHandler.bind(this))
			this._dmMoveBinder.on('touchmove', this._moveHandler.bind(this))

			this._dmMoveBinder.on('mouseup', function() {
				this.pressed = false
				this._dmMoveBinder.enable(false)
			}.bind(this))

			this._dmMoveBinder.on('touchend', function() {
				this.pressed = false
				this._dmMoveBinder.enable(false)
			}.bind(this))
		}
		this._dmMoveBinder.enable(true)
	}

	function _bindPressed(value) {
		if (value && !this._dmPressBinder) {
			this._dmPressBinder = new _globals.core.EventBinder(this.element)
			this._dmPressBinder.on('mousedown', this._downHandler.bind(this))
			this._dmPressBinder.on('touchstart', this._downHandler.bind(this))
		}
		if (this._dmPressBinder)
			this._dmPressBinder.enable(value)
	}

	onEnabledChanged: {
		this._bindPressed(value)
	}
}

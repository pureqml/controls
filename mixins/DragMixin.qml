/// makes parent item dragable
BaseMouseMixin {
	property bool pressed;	///< is mouse pressed flag
	property int top;		///< top border
	property int left;		///< left border
	property int right;		///< right border
	property int bottom;	///< bottom border
	property enum direction { Any, Vertical, Horizontal };	///< available drag direction

	///@private
	constructor: {
		this._bindPressed(this.enabled)
		this.moved = $core.createSignalForwarder(this.parent, 'moved')
	}

	///@private
	function _moveHandler(e) {
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
				this.parent.x = eX - sX
			}
		}

		if (Math.abs(this._initY - e.clientY) < 4 && Math.abs(this._initX - e.clientX) < 4)
			return 

		this.moved(e)  // emit moved signal to the parent
	}

	///@private
	function _downHandler(e) {
		this.pressed = true

		if (e.changedTouches)
			e = e.changedTouches[0]

		this._startX = e.clientX - this.parent.x
		this._startY = e.clientY - this.parent.y
		this._initX = e.clientX
		this._initY = e.clientY
		if (!this._dmMoveBinder) {
			this._dmMoveBinder = new _globals.core.EventBinder(context.window || this.element)

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

		$core.callMethod(e, 'stopPropagation')
	}

	///@private
	function _bindPressed(value) {
		if (value && !this._dmPressBinder) {
			this._dmPressBinder = new _globals.core.EventBinder(this.element)
			this._dmPressBinder.on('mousedown', this._downHandler.bind(this))
			this._dmPressBinder.on('touchstart', this._downHandler.bind(this))
		}
		if (this._dmPressBinder)
			this._dmPressBinder.enable(value)
	}

	///@private
	onEnabledChanged: {
		this._bindPressed(value)
	}
}

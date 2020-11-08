/// makes parent item dragable
BaseMixin {
	property bool moved;	///< is moved flag
	property bool pressed;	///< is mouse pressed flag
	property bool enabled: true;	///< enable/disable mixin
	property int top;		///< top border
	property int left;		///< left border
	property int right;		///< right border
	property int bottom;	///< bottom border
	property enum direction { Any, Vertical, Horizontal };	///< available drag direction

	///@private
	constructor: {
		this.element = this.parent.element;
		this._bindPressed(this.enabled)
	}

	///@private
	function _moveHandler(e) {
		if ('preventDefault' in e)
			e.preventDefault();

		if (e.changedTouches)
			e = e.changedTouches[0]

		if (this.direction !== this.Horizontal) {
			var eY = e.clientY !== undefined? e.clientY: e.offsetY, sY = this._startY, top = this.top, bottom = this.bottom
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
			var eX = e.clientX !== undefined? e.clientX: e.offsetX, sX = this._startX, left = this.left, right = this.right
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

	///@private
	function _downHandler(e) {
		if ('preventDefault' in e)
			e.preventDefault();
		this.pressed = true

		if (e.changedTouches)
			e = e.changedTouches[0]

		this._startX = (e.clientX !== undefined? e.clientX: e.offsetX) - this.parent.x
		this._startY = (e.clientY !== undefined? e.clientY: e.offsetY) - this.parent.y
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

		this.stopPropagation(e)
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

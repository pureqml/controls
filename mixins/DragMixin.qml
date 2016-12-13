Object {
	property bool pressed;
	property bool moved;
	property bool enabled: true;
	property int x;
	property int y;
	property int limitx1;
	property int limitx2;
	property int limity1;
	property int limity2;

	property enum direction {
		Any, Vertical, Horizontal
	};

	constructor: {
		this.element = this.parent.element;
		this._bindPressed(this.enabled)
	}

	function _moveHandler(e) {
		e.preventDefault();

		if (e.changedTouches)
			e = e.changedTouches[0]
		
		if (this.direction !== this.Horizontal) {
			var eY = e.clientY, sY = this._startY, ly1 = this.limity1, ly2 = this.limity2
			if (ly2  && (eY - sY > ly2)) {
				this.parent.y = ly2
			}
			else if (ly1 && (eY - sY < ly1))
				this.parent.y = ly1
			else {
				this.moved = true;
				this.parent.y = eY - sY
			}
		}
		if (this.direction !== this.Vertical) {
			var eX = e.clientX, sX = this._startX, lx1 = this.limitx1, lx2 = this.limitx2
			if (lx2  && (eX - sX > lx2)) {
				this.parent.x = lx2
			}
			else if (lx1 && (eX - sX < lx1))
				this.parent.x = lx1
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

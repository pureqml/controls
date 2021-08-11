/// mixin provides touch swipe events
BaseMixin {
	signal touchMove;			///< @private
	signal touchStart;			///< @private
	signal touchEnd;			///< @private
	signal verticalSwiped;		///< emitted on vertical swipe
	signal horizontalSwiped;	///< emitted on horizontal swipe

	constructor: { this._bindTouch(this.enabled) }

	onEnabledChanged: { this._bindTouch(value) }

	///@private
	function _bindTouch(value) {
		if (value && !this._touchBinder) {
			this._touchBinder = new _globals.core.EventBinder(this.parent.element)
			this._touchBinder.on('touchstart', function(event) { this.touchStart(event) }.bind(this))
			this._touchBinder.on('touchend', function(event) { this.touchEnd(event) }.bind(this))
			this._touchBinder.on('touchmove', function(event) { this.touchMove(event) }.bind(this))
		}
		if (this._touchBinder)
			this._touchBinder.enable(value)
	}

	///@private
	onTouchStart(event): {
		var box = this.parent.toScreen()
		var e = event.touches[0]
		var x = e.pageX - box[0]
		var y = e.pageY - box[1]
		this._startX = x
		this._startY = y
		this._orientation = null;
		this._startTarget = event.target;
	}

	///@private
	onTouchMove(event): {
		var box = this.parent.toScreen()

		var e = event.touches[0]
		var x = e.pageX - box[0]
		var y = e.pageY - box[1]
		var dx = x - this._startX
		var dy = y - this._startY
		var adx = Math.abs(dx)
		var ady = Math.abs(dy)
		var motion = adx > 5 || ady > 5
		if (!motion)
			return

		if (!this._orientation)
			this._orientation = adx > ady ? 'horizontal' : 'vertical'

		// for delegated events, the target may change over time
		// this ensures we notify the right target and simulates the mouseleave behavior
		while (event.target && event.target !== this._startTarget)
			event.target = event.target.parentNode;
		if (event.target !== this._startTarget) {
			event.target = this._startTarget;
			return;
		}

		if (this._orientation == 'horizontal')
			this.horizontalSwiped(event)
		else
			this.verticalSwiped(event)
	}
}

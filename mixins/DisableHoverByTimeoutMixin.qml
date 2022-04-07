/// this mixin turns off hover and activeHover by timeout and could be used for SmartTV's with autohiding cursor
HoverClickMixin {
	id: hoverMixinProto;
	property int timeout: 5000;		///< timeout delay
	property int mouseX;
	property int mouseY;
	signal mouseMove;

	Timer {
		id: disableHoverTimer;
		interval: parent.timeout;

		onTriggered: {
			hoverMixinProto._setHover(false)
		}
	}

	/// @private
	constructor: {
		this._bindMove(this.enabled)
	}

	/// @private
	function _updatePosition(event) {
		var parent = this.parent
		var x = event.offsetX
		var y = event.offsetY
		if (x >= 0 && y >= 0 && x < parent.width && y < parent.height) {
			this.mouseX = x
			this.mouseY = y
			this.mouseMove(x, y)
			return true
		}
		else
			return false
	}

	/// @private
	function _bindMove(value) {
		if (value && !this._mouseMoveBinder) {
			this._mouseMoveBinder = new $core.EventBinder(this.element)
			this._mouseMoveBinder.on('mousemove', function(event) {
				if (!this._updatePosition(event))
					$core.callMethod(event, 'preventDefault')
			}.bind(this))
		}
		if (this._mouseMoveBinder)
			this._mouseMoveBinder.enable(value)
	}

	/// @private
	function _setHover(value) {
		this.value = value
		if (this.activeHoverEnabled)
			this.activeHover = value
	}

	/// @private
	onEnabledChanged: {
		this._bindMove(value)
	}

	/// @private
	onValueChanged: {
		if (value)
			disableHoverTimer.restart()
	}

	/// @private
	onMouseMove: {
		this._setHover(!this._touchEvent)
		disableHoverTimer.restart()
	}
}

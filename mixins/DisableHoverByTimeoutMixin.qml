/// this mixin turn off hover and activeHover by timeout and could be used for SmartTV's with autohiding cursor
Object {
    id: hoverMixinProto;
	property bool value;			///< is 'true' if item if hovered, 'false' otherwise
	property bool enabled: true;	///< enable/disable mixin
	property string cursor;			///< mouse cursor
	property int timeout: 5000;     ///< timeout delay
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
		this.element = this.parent.element
		this.parent.style('cursor', this.cursor)
		this._bindHover(this.enabled)
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

	///@private
	function _bindHover(value) {
		if (value && !this._hmHoverBinder) {
			this._hmHoverBinder = new $core.EventBinder(this.parent.element)

			if (this._context.backend.capabilities.mouseEnterLeaveSupported) {
				this._hmHoverBinder.on('mouseenter', function() { this.value = true }.bind(this))
				this._hmHoverBinder.on('mouseleave', function() { this.value = false }.bind(this))
			} else {
				this._hmHoverBinder.on('mouseover', function() { this.value = true }.bind(this))
				this._hmHoverBinder.on('mouseout', function() { this.value = false }.bind(this))
			}
		}
		if (this._hmHoverBinder)
			this._hmHoverBinder.enable(value)
	}

	/// @private
    function _bindMove(value) {
        if (value && !this._mouseMoveBinder) {
            this._mouseMoveBinder = new $core.EventBinder(this.element)
            this._mouseMoveBinder.on('mousemove', function(event) {
                if (!this._updatePosition(event))
                    event.preventDefault()
            }.bind(this))
        }
        if (this._mouseMoveBinder)
            this._mouseMoveBinder.enable(value)
    }

    /// @private
    function _setHover(value) {
        hoverMixinProto.parent.hover = value
        if (hoverMixinProto.parent.activeHoverEnabled)
            hoverMixinProto.parent.activeHover = value
    }

	/// @private
	onCursorChanged: {
		this.parent.style('cursor', value)
	}

	/// @private
	onEnabledChanged: {
	    this._bindHover(value)
	    this._bindMove(value)
    }

    /// @private
    onValueChanged: {
        if (value)
            disableHoverTimer.restart()
    }

    /// @private
    onMouseMove: {
        this._setHover(true)
        disableHoverTimer.restart()
    }
}

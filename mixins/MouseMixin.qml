/// Provide mouse signals: clicked, mouseMove, wheel. And properties: mouseX, mouseY, hover, pressed
BaseMouseMixin {
	property bool clickable: true;		///< enable mouse click event handling flag
	property bool hoverable: true;		///< hoverEnabled property alias
	property bool pressable: true;		///< enable mouse click event handling flag
	property bool wheelEnabled: true;	///< enable mouse click event handling flag

	///@private
	constructor: {
		var parent = this.parent
		this._bindClick(this.clickable)
		this._bindHover(this.hoverable)
		this._bindPressable(this.pressable)
		this._bindWheel(this.wheelEnabled)

		if (!exports.hasProperty(parent, "mouseX"))
			exports.addProperty(parent, "real", "mouseX", 0.0)
		if (!exports.hasProperty(parent, "mouseY"))
			exports.addProperty(parent, "real", "mouseY", 0.0)
		if (!exports.hasProperty(parent, "hover"))
			exports.addProperty(parent, "bool", "hover", false)
		if (!exports.hasProperty(parent, "pressed"))
			exports.addProperty(parent, "bool", "pressed", false)
	}

	///@private
	function _bindClick(value) {
		if (value && !this._cmClickBinder) {
			this._cmClickBinder = new $core.EventBinder(this.element)
			this._cmClickBinder.on('click', $core.createSignalForwarder(this.parent, 'clicked').bind(this))
		}
		if (this._cmClickBinder)
			this._cmClickBinder.enable(value)
	}

	/// @private
	function _bindWheel(value) {
		if (value && !this._wheelBinder) {
			this._clickBinder = new $core.EventBinder(this.element)
			this._cmClickBinder.on('mousewheel', $core.createSignalForwarder(this.parent, 'wheel').bind(this))
		}
		if (this._clickBinder)
			this._clickBinder.enable(value)
	}

	///@private
	function _bindHover(value) {
		var parent = this.parent
		if (value && !this._hoverBinder) {
			this._hoverBinder = new $core.EventBinder(this.element)
			this._hoverBinder.on('mousemove', function(event) { if (this.updatePosition(event)) $core.callMethod(event, 'preventDefault') }.bind(this))
			this._hoverBinder.on('mouseenter', function() { parent.hover = true }.bind(this))
			this._hoverBinder.on('mouseleave', function() { parent.hover = false }.bind(this))
		}
		if (this._hoverBinder)
			this._hoverBinder.enable(value)

		if (value && !this._mouseMovebinder) {
			this._mouseMovebinder = new $core.EventBinder(this.element)
			this._mouseMovebinder.on('mousemove', $core.createSignalForwarder(parent, 'mouseMove').bind(this))
		}

		if (this._mouseMovebinder)
			this._mouseMovebinder.enable(value)
	}

	///@private
	function _bindPressable(value) {
		if (value && !this._pressableBinder) {
			this._pressableBinder = new $core.EventBinder(this.element)
			var parent = this.parent
			this._pressableBinder.on('mousedown', function() { parent.pressed = true }.bind(this))
			this._pressableBinder.on('mouseup', function() { parent.pressed = false }.bind(this))
		}
		if (this._pressableBinder)
			this._pressableBinder.enable(value)
	}

	updatePosition(event): {
		var parent = this.parent
		if (!parent.recursiveVisible)
			return false

		var x = event.offsetX
		var y = event.offsetY

		if (x >= 0 && y >= 0 && x < parent.width && y < parent.height) {
			parent.mouseX = x
			parent.mouseY = y
			return true
		} else {
			return false
		}
	}

	onHoverableChanged: { this._bindHover(value) }
	onClickableChanged: { this._bindClick(value) }
	onPressableChanged: { this._bindPressable(value) }
}

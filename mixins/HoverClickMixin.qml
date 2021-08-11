/// this mixin provides mouse hover and click events handling
BaseMouseMixin {
	property bool enabled: true;				///< enable/disable mixin
	property bool clickable: true;
	property bool activeHoverEnabled: false;
	property bool value;
	property bool activeHover: false;

	constructor: {
		this.element = this.parent.element;
		this._bindClick(this.clickable)
		this._bindHover(this.enabled)
		this._bindActiveHover(this.activeHoverEnabled)
	}

	///@private
	function _bindClick(value) {
		if (value && !this._hmClickBinder) {
			this._hmClickBinder = new _globals.core.EventBinder(this.element)
			this._hmClickBinder.on('click', _globals.core.createSignalForwarder(this.parent, 'clicked').bind(this))
		}
		if (this._hmClickBinder)
			this._hmClickBinder.enable(value)
	}

	///@private
	function _bindHover(value) {
		if (value && !this._hmHoverBinder) {
			this._hmHoverBinder = new _globals.core.EventBinder(this.parent.element)
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

	///@private
	function _bindActiveHover(value) {
		if (value && !this._hmActiveHoverBinder) {
			this._hmActiveHoverBinder = new _globals.core.EventBinder(this.parent.element)
			this._hmActiveHoverBinder.on('mouseover', function() { this.activeHover = true }.bind(this))
			this._hmActiveHoverBinder.on('mouseout', function() { this.activeHover = false }.bind(this))
		}
		if (this._hmActiveHoverBinder)
		{
			this._hmActiveHoverBinder.enable(value)
		}
	}

	onEnabledChanged: { this._bindHover(value) }
	onClickableChanged: { this._bindClick(value) }
	onActiveHoverEnabledChanged: { this._bindActiveHover(value) }
}

Object {
	property bool clickable: true;
	property bool value;
	property bool enabled: true;
	property string cursor: "pointer";

	constructor: {
		this.element = this.parent.element;
		this.parent.style('cursor', this.cursor) 
	}

	onCursorChanged: {
		this.parent.style('cursor', value)
	}

	function _bindClick(value) {
		if (value && !this._hmClickBinder) {
			this._hmClickBinder = new _globals.core.EventBinder(this.element)
			this._hmClickBinder.on('click', _globals.core.createSignalForwarder(this.parent, 'clicked').bind(this))
		}
		if (this._hmClickBinder)
			this._hmClickBinder.enable(value)
	}

	onClickableChanged: {
		this._bindClick(value)
	}

	function _bindHover(value) {
		if (value && !this._hmHoverBinder) {
			this._hmHoverBinder = new _globals.core.EventBinder(this.parent.element)
			this._hmHoverBinder.on('mouseenter', function() { this.value = true }.bind(this))
			this._hmHoverBinder.on('mouseleave', function() { this.value = false }.bind(this))
		}
		if (this._hmHoverBinder)
			this._hmHoverBinder.enable(value)
	}

	onEnabledChanged: {
		this._bindHover(value)
	}

	onCompleted: {
		this._bindClick(this.clickable)
		this._bindHover(this.enabled)
	}
}

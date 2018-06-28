BaseMixin {
	property bool enabled: true;
	signal clicked;

	constructor: {
		this.element = this.parent.element;
		this._bindClicked(this.enabled)
	}

	///@private
	function _bindClicked(value) {
		if (value && !this._clickedBinder) {
			this._clickedBinder = new _globals.core.EventBinder(this.element)
			var self = this
			this._clickedBinder.on('mousedown', function(e) { if (e.which === 3) self.clicked(e); self.stopPropagation(e) }.bind(this))
		}
		if (this._clickedBinder)
			this._clickedBinder.enable(value)
	}

	///@private
	onEnabledChanged: {
		this._bindClicked(value)
	}
}

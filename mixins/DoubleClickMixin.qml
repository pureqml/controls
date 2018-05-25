BaseMixin {
	property bool enabled: true;
	signal doubleClicked;

	constructor: {
		this.element = this.parent.element;
		this._bindClicked(this.enabled)
	}

	///@private
	function _bindClicked(value) {
		if (value && !this._dblClickedBinder) {
			this._dblClickedBinder = new _globals.core.EventBinder(this.element)
			var self = this
			this._dblClickedBinder.on('dblclick', function(e) { self.doubleClicked(); self.stopPropagation(e) }.bind(this))
		}
		if (this._dblClickedBinder)
			this._dblClickedBinder.enable(value)
	}

	///@private
	onEnabledChanged: {
		this._bindClicked(value)
	}
}

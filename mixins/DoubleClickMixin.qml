/// This mixin provides mouse double click event detecting
BaseMouseMixin {
	constructor: {
		this._bindClicked(this.enabled)
	}

	///@private
	function _bindClicked(value) {
		if (value && !this._dblClickedBinder) {
			this._dblClickedBinder = new _globals.core.EventBinder(this.element)
			this._dblClickedBinder.on('dblclick', $core.createSignalForwarder(this.parent, 'doubleClicked').bind(this))
		}
		if (this._dblClickedBinder)
			this._dblClickedBinder.enable(value)
	}

	///@private
	onEnabledChanged: { this._bindClicked(value) }
}

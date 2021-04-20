BaseMouseMixin {
	constructor: {
		this.element = this.parent.element;
		this._bindClicked(this.enabled)
	}

	///@private
	function _bindClicked(value) {
		if (value && !this._clickedBinder) {
			this._clickedBinder = new _globals.core.EventBinder(this.element)
			this._clickedBinder.on('mousedown', function(e) {
				if (e.which === 3) {
					this._emit(e)
				} else if (e.button === 2) {
					this._emit(e)
				}
			}.bind(this))
		}
		if (this._clickedBinder)
			this._clickedBinder.enable(value)
	}

	///@private
	function _emit(e) {
		this.parent.emitWithArgs('rightClicked', arguments)
		if (e !== undefined)
			this.stopPropagation(e)
	}

	///@private
	onEnabledChanged: {
		this._bindClicked(value)
	}
}

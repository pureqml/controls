Object {
	property string text;			///< inner text placeholder
	property Color color;			///< placeholder color
	//TODO: implement
	property Font font: Font { }	///< placeholder font

	constructor: {
		this._placeholderClass = ''
	}

	/// @private
	function _update(name, value) {
		switch (name) {
			case 'text': this.parent.element.setAttribute('placeholder', value); break
			case 'color': this.setPlaceholderColor(value); break
			case 'fontSize': this.setPlaceholderFontSize(value); break
		}

		_globals.core.Item.prototype._update.apply(this, arguments);
	}

	function getClass() {
		var cls
		if (!this._placeholderClass) {
			cls = this._placeholderClass = this._context.stylesheet.allocateClass('input')
			this.parent.element.addClass(cls)
		}
		else
			cls = this._placeholderClass
		return cls
	}

	function setPlaceholderColor(color) {
		var cls = this.getClass()

		var rgba = new _globals.core.Color(color).rgba()
		//fixme: port to modernizr
		var selectors = ['::-webkit-input-placeholder', '::-moz-placeholder', ':-moz-placeholder', ':-ms-input-placeholder']
		selectors.forEach(function(selector) {
			try {
				this._context.stylesheet._addRule('.' + cls + selector, 'color: ' + rgba)
				log('added rule for .' + cls + selector)
			} catch(ex) {
				//log(ex)
			}
		}.bind(this))
	}

	function setPlaceholderFontSize(value) {
		var cls = this.getClass()

		//fixme: port to modernizr
		var selectors = ['::-webkit-input-placeholder', '::-moz-placeholder', ':-moz-placeholder', ':-ms-input-placeholder']
		selectors.forEach(function(selector) {
			try {
				this._context.stylesheet._addRule('.' + cls + selector, 'font-size: ' + value + "px")
				log('added rule for .' + cls + selector)
			} catch(ex) {
				//log(ex)
			}
		}.bind(this))
	}
}

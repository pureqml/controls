Object {
	property string family;		///< font family
	property bool italic;		///< applies italic style
	property bool bold;			///< applies bold style
	property bool underline;	///< applies underline style
	property int pixelSize;		///< font size in pixels
	property int pointSize;		///< font size in points
	property int lineHeight;	///< font line height in pixels
	property int weight;		///< font weight value

	/// @private
	function _update(name, value) {
		switch (name) {
			case 'family':		this.updateProperty('font-family', value); this.parent.parent._updateSize(); break
			case 'pointSize':	this.updateProperty('font-size', value + "pt"); this.parent.parent._updateSize(); break
			case 'pixelSize':	this.updateProperty('font-size', value + "px"); this.parent.parent._updateSize(); break
			case 'italic': 		this.updateProperty('font-style', value? 'italic': 'normal'); this.parent.parent._updateSize(); break
			case 'bold': 		this.updateProperty('font-weight', value? 'bold': 'normal'); this.parent.parent._updateSize(); break
			case 'underline':	this.updateProperty('text-decoration', value? 'underline': ''); this.parent.parent._updateSize(); break
			case 'lineHeight':	this.updateProperty('line-height', value + "px"); this.parent.parent._updateSize(); break;
			case 'weight':		this.updateProperty('font-weight', value); this.parent.parent._updateSize(); break;
		}
		_globals.core.Object.prototype._update.apply(this, arguments);
	}

	/// @private
	function getClass() {
		var cls
		if (!this._placeholderClass) {
			cls = this._placeholderClass = this._context.stylesheet.allocateClass('placeholderFont')
			this.parent.parent.element.addClass(cls)
		}
		else
			cls = this._placeholderClass
		return cls
	}

	/// @private
	function updateProperty(name, value) {
		var cls = this.getClass()

		//fixme: port to modernizr
		var selectors = ['::-webkit-input-placeholder', '::-moz-placeholder', ':-moz-placeholder', ':-ms-input-placeholder']
		selectors.forEach(function(selector) {
			try {
				this._context.stylesheet._addRule('.' + cls + selector, name + ':' + value)
				log('added rule for .' + cls + selector)
			} catch(ex) {
				log(ex)
			}
		}.bind(this))
	}
}

Object {
	property string family;		///< font family
	property bool italic;		///< applies italic style
	property bool bold;			///< applies bold style
	property bool underline;	///< applies underline style
	property bool strike;		///< line throw text flag
	property int pixelSize;		///< font size in pixels
	property int pointSize;		///< font size in points
	property int lineHeight;	///< font line height in pixels
	property int weight;		///< font weight value

	/// @private
	onBoldChanged: { this.updateProperty('font-weight', value? 'bold': 'normal'); this.parent.parent._updateSize(); }

	/// @private
	onWeightChanged: { this.updateProperty('font-weight', value); this.parent.parent._updateSize(); }

	/// @private
	onFamilyChanged: { this.updateProperty('font-family', value); this.parent.parent._updateSize(); }

	/// @private
	onItalicChanged: { this.updateProperty('font-style', value? 'italic': 'normal'); this.parent.parent._updateSize(); }

	/// @private
	onStrikeChanged: { this.updateProperty('text-decoration', value? 'line-through': ''); this.parent._updateSize(); }

	/// @private
	onPointSizeChanged: { this.updateProperty('font-size', value + "pt"); this.parent.parent._updateSize(); }

	/// @private
	onPixelSizeChanged: { this.updateProperty('font-size', value + "px"); this.parent.parent._updateSize(); }

	/// @private
	onUnderlineChanged: { this.updateProperty('text-decoration', value? 'underline': ''); this.parent.parent._updateSize(); }

	/// @private
	onLineHeightChanged: { this.updateProperty('line-height', value + "px"); this.parent.parent._updateSize(); }

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
				this._context.stylesheet.addRule('.' + cls + selector, name + ':' + value)
				log('added rule for .' + cls + selector)
			} catch(ex) {
				//log(ex)
			}
		}.bind(this))
	}
}

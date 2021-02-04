///placeholder adjustment object for inputs
Object {
	property string text;			///< inner text placeholder
	property Color color;			///< placeholder color
	property Font font: PlaceholderFont { }	///< placeholder font

	///@private
	constructor: { this._placeholderClass = '' }

	///@private
	onTextChanged: { this.parent.element.setAttribute('placeholder', value) }

	///@private
	onColorChanged: { this.setPlaceholderColor(value) }

	///@private
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

	///@private
	function setPlaceholderColor(color) {
		var cls = this.getClass()

		var rgba = $core.Color.normalize(color)
		this.parent.element.style('-pure-placeholder-color', rgba)

		//fixme: port to modernizr
		var selectors = ['::-webkit-input-placeholder', '::-moz-placeholder', ':-moz-placeholder', ':-ms-input-placeholder']
		selectors.forEach(function(selector) {
			this._context.stylesheet.addRule('.' + cls + selector, 'color: ' + rgba)
		}.bind(this))
	}
}

Item {
	property int contentWidth;		///< content width
	property int contentHeight;		///< content height
	property string code;			///< code string
	property string language;		///< programming language
	property Font font: Font {}		///< code text font
	height: contentHeight;
	width: contentWidth;

	/// @private
	onWidthChanged, onHeightChanged: { this._updateSize(); }

	/// @private
	onCodeChanged: {
		this._code.dom.innerHTML = value
		window.hljs.highlightBlock(this._code.dom)
		this._updateSize()
	}

	/// @private
	onLanguageChanged: {
		this._code.dom.className = value
		window.hljs.highlightBlock(this._code.dom)
	}

	/// @private returns tag for corresponding element
	function getTag() { return 'pre' }

	/// @private
	function registerStyle(style, tag) {
		style.addRule(tag, 'position: absolute; visibility: inherit; margin: 0px;')
	}

	/// @private
	constructor: {
		if (!window.hljs) {
			log("hljs is not defined! Maybe you forget to attach highlight.js file.")
			return
		}
		this._code = this._context.createElement('code')
		this._code.dom.style.width = "auto"
		this._code.dom.style.height = "auto"
		this._code.dom.style.font = "inherit"
		this.element.append(this._code)
	}

	/// @private
	function _updateSize() {
		this.contentWidth = this._code.dom.scrollWidth
		this.contentHeight = this._code.dom.scrollHeight
		if (this.height && this.contentHeight != this.height)
			this._code.dom.style.height = "inherit"
		if (this.width && this.contentWidth != this.width)
			this._code.dom.style.width = "inherit"
		var style = { width: this.width, height: this.height }
		this.style(style)
	}
}

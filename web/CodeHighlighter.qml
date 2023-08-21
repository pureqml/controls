///item for displaying code with syntax highlighting powered by highlight.js
Item {
	property int contentWidth;		///< content width
	property int contentHeight;		///< content height
	property string code;			///< code string
	property string language;		///< programming language
	property Font font: Font {}		///< code text font
	property int tabWidth: 2;		///< replace tabs with spaces (-1 to turn off)
	height: contentHeight;
	width: contentWidth;

	/// @private
	onWidthChanged, onHeightChanged: { this._updateSize(); }

	/// @private
	function _highlightBlock() {
		if (this.tabWidth >= 0) {
			//FIXME: this is global - find a way to reconfigure each block or create shared configuration
			var tab = new Array(this.tabWidth + 1).join(' ')
			window.hljs.configure({tabReplace: tab})
		}
		window.hljs.highlightBlock(this._code.dom)
	}

	/// @private
	onCodeChanged: {
		this._code.dom.innerHTML = value
		this._highlightBlock()
		this._updateSize()
	}

	/// @private
	onLanguageChanged: {
		this._code.dom.className = value
		this._highlightBlock()
	}

	htmlTag: "pre";

	/// @private
	function registerStyle(style, tag) {
		style.addRule(tag, 'position: absolute; visibility: inherit; margin: 0px; pointer-events: auto; touch-action: auto')
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

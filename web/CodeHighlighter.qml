Item {
	property string code;
	property string language;
	property Font font: Font {}
	clip: true;

	function _update(name, value) {
		switch (name) {
			case 'width':		this._updateSize(); break
			case 'height':		this._updateSize(); break
			case 'code':		this._code.dom.innerHTML = value; window.hljs.highlightBlock(this._code.dom); break
			case 'language':	this._code.dom.className = value; window.hljs.highlightBlock(this._code.dom); break
		}
		_globals.core.Item.prototype._update.apply(this, arguments);
	}

	constructor: {
		if (!window.hljs) {
			log("hljs is not defined! Maybe you forget to attach highlight.js file.")
			return
		}
		this.element.remove()
		this.element = this._context.createElement('pre')
		this._code = this._context.createElement('code')
		this._code.dom.style.width = "inherit"
		this._code.dom.style.height = "inherit"
		this._code.dom.style.font = "inherit"
		this.element.append(this._code)
		this.parent.element.append(this.element)
	}

	function _updateSize() {
		var style = { width: this.width, height: this.height }
		this.style(style)
	}
}

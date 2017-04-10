/// HTML button controls
Item {
	signal clicked;			///< button clicked signal
	property string text;	///< button inner text
	property Font font: Font { }	///< button texts font
	property Border border: Border { }	///< buttons border
	property Paddings paddings: Paddings {}		///< inner text paddings

	///@private
	function _update(name, value) {
		switch (name) {
			case 'height': this._updateSize(); break
			case 'width': this._updateSize(); break
			case 'text': this.element.dom.innerText = value; break;
		}
		_globals.core.Item.prototype._update.apply(this, arguments)
	}

	///@private returns tag for corresponding element
	function getTag() { return 'button' }

	///@private
	function registerStyle(style, tag) {
		style.addRule(tag, "position: absolute; visibility: inherit;")
	}

	///@private
	function _updateSize() {
		var style = { width: this.width, height: this.height }
		this.style(style)
	}

	///@private
	constructor: {
		var self = this
		this.element.dom.onclick = function() { self.clicked() }.bind(this)
	}
}

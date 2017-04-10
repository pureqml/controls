/// HTML button controls
Rectangle {
	signal clicked;			///< button clicked signal
	property string text;	///< button inner text
	property Font font: Font { }	///< button texts font
	property Border border: Border { }	///< buttons border
	property Paddings paddings: Paddings {}		///< inner text paddings
	property HoverMixin hover: HoverMixin { cursor: "pointer"; }
	property color textColor;
	property int paintedWidth;
	property int paintedHeight;
	width: paintedWidth;
	height: paintedHeight;

	///@private
	function _update(name, value) {
		switch (name) {
			case 'height': this.style("height", value ); break
			case 'width': this.style("width", value); break
			case 'textColor': this.style('color', _globals.core.normalizeColor(value)); break;
			case 'text': this.element.dom.innerText = value; this._layout(); break;
		}
		_globals.core.Rectangle.prototype._update.apply(this, arguments)
	}

	///@private returns tag for corresponding element
	function getTag() { return 'button' }

	///@private
	function registerStyle(style, tag) {
		style.addRule(tag, "position: absolute; visibility: inherit; text-decoration: none; border: none;")
	}

	///@private
	function _layout() {
		this.style({ width: 'auto', height: 'auto'}) //no need to reset it to width, it's already there

		this.paintedWidth = this.element.fullWidth()
		this.paintedHeight = this.element.fullHeight()

		this.style({ width: this.width, height: this.height })
	}

	///@private
	constructor: {
		var self = this
		this.element.dom.onclick = function() { self.clicked() }.bind(this)
	}
}

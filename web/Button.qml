/// HTML button controls
Rectangle {
	signal clicked;			///< button clicked signal
	property string text;	///< button inner text
	property Font font: Font { }	///< button texts font
	property Paddings paddings: Paddings {}		///< inner text paddings
	property HoverMixin hover: HoverMixin { cursor: "pointer"; }
	property color textColor;
	property int paintedWidth;
	property int paintedHeight;
	width: paintedWidth;
	height: paintedHeight;

	///@private
	onTextChanged: { this.element.setHtml(value, this); this._updateSize(); }

	///@private
	onWidthChanged: { this.style("width", value); }

	///@private
	onHeightChanged: { this.style("height", value ); }

	///@private
	onTextColorChanged: { this.style('color', _globals.core.normalizeColor(value)); }

	///@private returns tag for corresponding element
	function getTag() { return 'button' }

	///@private
	function registerStyle(style, tag) {
		style.addRule(tag, "position: absolute; visibility: inherit; text-decoration: none; border: none; outline: none; box-sizing: content-box;")
	}

	///@private
	function _updateSize() {
		this.style({ width: 'auto', height: 'auto'}) //no need to reset it to width, it's already there

		this.paintedWidth = this.element.dom.scrollWidth
		this.paintedHeight = this.element.dom.scrollHeight

		this.style({ width: this.width, height: this.height })
	}

	///@private
	constructor: {
		var self = this
		this.element.dom.onclick = function() { self.clicked() }.bind(this)
	}
}

/// HTML button controls
Rectangle {
	signal clicked;			///< button clicked signal
	property string text;	///< button inner text
	property Font font: Font { }	///< button texts font
	property lazy paddings: Paddings {}		///< inner text paddings
	property HoverMixin hover: HoverMixin { cursor: "pointer"; }
	property color textColor;
	property int paintedWidth;
	property int paintedHeight;
	property bool enabled: true;
	width: paintedWidth;
	height: paintedHeight;

	///@private
	onTextChanged: { this.element.setHtml(value, this); this._updateSize(); }

	///@private
	onWidthChanged: { this.element.style("width", value); }

	///@private
	onHeightChanged: { this.element.style("height", value ); }

	///@private
	onTextColorChanged: { this.element.style('color', _globals.core.Color.normalize(value)); }

	onEnabledChanged: {
		if (value)
			this.element.removeAttribute('disabled')
		else
			this.element.setAttribute('disabled', '')
	}

	htmlTag: "button";

	///@private
	function registerStyle(style, tag) {
		style.addRule(tag, "position: absolute; visibility: inherit; text-decoration: none; border: none; outline: none; box-sizing: content-box; padding: 0;")
	}

	///@private
	function _updateSize() {
		this._context.delayedAction('button:update-size', this, this._updateSizeImpl)
	}

	///@private
	function _updateSizeImpl() {
		this.element.style({ width: 'auto', height: 'auto'}) //no need to reset it to width, it's already there
		this.element.updateStyle()

		this.paintedWidth = this.element.fullWidth()
		this.paintedHeight = this.element.fullHeight()

		this.element.style({ width: this.width, height: this.height })
	}

	///@private
	constructor: {
		var self = this
		this.element.on('click', function() { self.clicked() })
	}
}

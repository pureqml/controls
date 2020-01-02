///base class for all inputs
Item {
	property enum horizontalAlignment { AlignLeft, AlignRight, AlignHCenter, Justify };	///< inner text alignment
	property lazy paddings: Paddings {}		///< inner text paddings
	property Color color: "#000";				///< text color
	property Color backgroundColor: "#fff";		///< background color
	property Font font: Font {}					///< object holding properties of text font
	property Border border: Border {}			///< object holding properties of the border
	property string type: "text";				///< input type value, must override in inheriting component
	property PlaceHolder placeholder: PlaceHolder{}	///< input placeholder object
	property bool enabled: true;				///< input enabled

	/// @private
	constructor: {
		this._placeholderClass = ''
		this.element.on("focus", function() { this.forceActiveFocus(); }.bind(this))
		this.element.on("blur", function() { this.forceActiveFocus(); }.bind(this))
	}

	/// @private
	onActiveFocusChanged: {
		if (value)
			this.focusBrowser()
		else
			this.blurBrowser()
	}

	/// @private
	onRecursiveVisibleChanged: {
		if (!value)
			this.blurBrowser()
	}

	/// @private
	onWidthChanged,
	onHeightChanged: { this._updateSize() }

	/// @private
	onTypeChanged: { this.element.setAttribute('type', value) }

	/// @private
	onColorChanged: { this.style('color', value) }

	/// @private
	onBackgroundColorChanged: { this.style('background', value) }

	/// @private
	onHorizontalAlignmentChanged: {
		switch(value) {
		case this.AlignLeft:	this.style('text-align', 'left'); break
		case this.AlignRight:	this.style('text-align', 'right'); break
		case this.AlignHCenter:	this.style('text-align', 'center'); break
		case this.AlignJustify:	this.style('text-align', 'justify'); break
		}
	}

	onEnabledChanged: {
		this.element.setAttribute('disabled', !value)
	}

	/// returns tag for corresponding element
	function getTag() { return 'input' }

	/// @private
	function registerStyle(style) {
		style.addRule('input', "position: absolute; visibility: inherit; border-style: solid; border-width: 0px; box-sizing: border-box;")
		style.addRule('input:focus', "outline: none;")
	}

	/// @private
	function _updateSize() {
		var style = { width: this.width, height: this.height }
		this.style(style)
	}

	/// focus browser
	function focusBrowser() {
		focusTimer.restart()
	}

	/// blur browser
	function blurBrowser() {
		focusTimer.stop()
		this.element.blur()
	}

	/// gets element native value
	function _getValue() {
		return this.element.getAttribute('value')
	}

	/// sets element native value
	function _setValue(value) {
		this.element.setAttribute('value', value)
	}

	/// @private
	function _updateValue(value) {
		if (value !== this._getValue())
			this._setValue(value)
	}

	Timer {
		id: focusTimer;
		interval: 100;

		onTriggered: {
			this.parent.element.focus()
		}
	}
}

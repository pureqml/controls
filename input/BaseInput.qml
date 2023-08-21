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
	property bool nativeFocus: manifest.useNativeFocusForInput; ///< use native focus for input (may trigger IME)
	property string inputMode;					///< inputmode attribute, numeric keyboard, etc
	property string autocomplete;				///< autocomplete variants (username, current-password, etc)
	signal change; 								///< emit signal when input loses focus or IME closes
	cssPointerTouchEvents: true;

	/// @private
	constructor: {
		this._placeholderClass = ''
		this.element.on("focus", function() { this.forceActiveFocus(); }.bind(this))
		this.element.on("blur", function() { /* fixme: remove focus from current input */ }.bind(this))
		this.element.on("change", function() { this.change() }.bind(this))
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
		if(value) {
			this.element.removeAttribute('disabled');
		}
		else {
			this.element.setAttribute('disabled', true);
		}
	}

	onAutocompleteChanged: {
		this.element.setAttribute('autocomplete', value)
	}

	htmlTag: "input";

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
		if (!this.nativeFocus)
			return

		focusTimer.restart()
	}

	/// blur browser
	function blurBrowser() {
		if (!this.nativeFocus)
			return

		focusTimer.stop()
		this.element.blur()
	}

	/// gets element native value
	function _getValue() {
		return this.element.getProperty('value')
	}

	/// sets element native value
	function _setValue(value) {
		this.element.setProperty('value', value)
	}

	/// @private
	function _updateValue(value) {
		if (value !== this._getValue())
			this._setValue(value)
	}

	onInputModeChanged: {
		this.element.setAttribute('inputmode', value)
	}

	Timer {
		id: focusTimer;
		interval: 100;

		onTriggered: {
			this.parent.element.focus()
		}
	}
}

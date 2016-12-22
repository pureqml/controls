///base class for all inputs
Item {
	property enum horizontalAlignment { AlignLeft, AlignRight, AlignHCenter, Justify };	///< inner text alignment
	property Paddings paddings: Paddings {}		///< inner text paddings
	property Color color: "#000";				///< text color
	property Color backgroundColor: "#fff";		///< background color
	property Font font: Font {}					///< object holding properties of text font
	property Border border: Border {}			///< object holding properties of the border
	property string placeholder;				///< inner text placeholder
	property string type: "text";				///< input type value, must overrie in inheritor

	/// @private
	constructor: {
		this.element.on("focus", function() { this.activeFocus = true; }.bind(this))
		this.element.on("blur", function() { this.activeFocus = false; }.bind(this))
	}

	/// @private
	onActiveFocusChanged: {
		if (value)
			this.element.dom.select()
		else
			this.element.dom.blur()
	}

	/// @private
	onRecursiveVisibleChanged: {
		if (!value)
			this.element.dom.blur()
	}

	/// @private
	function _update(name, value) {
		switch (name) {
			case 'type': this.element.dom.type = value; break
			case 'width': this._updateSize(); break
			case 'height': this._updateSize(); break
			case 'placeholder': this.element.setAttribute('placeholder', value); break
			case 'color': this.style('color', value); break
			case 'backgroundColor': this.style('background', value); break
			case 'horizontalAlignment':
				switch(value) {
				case this.AlignLeft:	this.style('text-align', 'left'); break
				case this.AlignRight:	this.style('text-align', 'right'); break
				case this.AlignHCenter:	this.style('text-align', 'center'); break
				case this.AlignJustify:	this.style('text-align', 'justify'); break
				}
				break
		}

		_globals.core.Item.prototype._update.apply(this, arguments);
	}

	/// returns tag for corresponding element
	function getTag() { return 'input' }

	function registerStyle(style) {
		style.addRule('input', "position: absolute; visibility: inherit; border-style: solid; border-width: 0px; box-sizing: border-box;")
		style.addRule('input:focus', "outline: none;")
	}

	/// @private
	function _updateSize() {
		var style = { width: this.width, height: this.height }
		this.style(style)
	}
}

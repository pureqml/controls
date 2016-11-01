Item {
	property enum horizontalAlignment { AlignLeft, AlignRight, AlignHCenter, Justify };
	property Paddings paddings: Paddings {}
	property Color color: "#000";
	property Color backgroundColor: "#fff";
	property Font font: Font {}
	property Border border: Border {}
	property string placeholder;
	property string type: "text";

	constructor: {
		this.element.on("focus", function() { this.activeFocus = true; }.bind(this))
		this.element.on("blur", function() { this.activeFocus = false; }.bind(this))
	}

	onActiveFocusChanged: {
		if (value)
			this.element.dom.select()
		else
			this.element.dom.blur()
	}

	onRecursiveVisibleChanged: {
		if (!value)
			this.element.dom.blur()
	}

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

	function _updateSize() {
		var style = { width: this.width, height: this.height }
		this.style(style)
	}
}

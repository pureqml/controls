Item {
	property enum horizontalAlignment { AlignLeft, AlignRight, AlignHCenter, Justify };
	property int borderWidth: border.width;
	property Color color: "#000";
	property Color backgroundColor: "#fff";
	property string type: "text";
	property Font font: Font {}
	property Border border: Border {}

	function _update(name, value) {
		switch (name) {
			case 'type': this.element.dom.type = value; break
			case 'width': this._updateSize(); break
			case 'height': this._updateSize(); break
			case 'color': this.style('color', value); break
			case 'backgroundColor': this.style('background', value); break
			case 'borderWidth': this.style('borderStyle', value ? 'inherit' : 'hidden'); break
			case 'horizontalAlignment':
				switch(value) {
				case this.AlignLeft:	this.style('text-align', 'left'); break
				case this.AlignRight:	this.style('text-align', 'right'); break
				case this.AlignHCenter:	this.style('text-align', 'center'); break
				case this.AlignJustify:	this.style('text-align', 'justify'); break
				}
				break
		}

		qml.core.Item.prototype._update.apply(this, arguments);
	}

	constructor: {
		this.element.remove()
		this.element = this._context.createElement('input')
		this.parent.element.append(this.element)
		this.style('borderStyle', 'hidden')
	}

	function _updateSize() {
		var style = { width: this.width, height: this.height }
		this.style(style)
	}
}

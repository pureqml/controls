Item {
	property enum horizontalAlignment { AlignLeft, AlignRight, AlignHCenter, Justify };
	property int borderWidth: border.width;
	property string text;
	property Color color: "#000";
	property Color backgroundColor: "#fff";
	property Font font: Font {}
	property Border border: Border {}
	width: 150;
	height: 100;

	function _update(name, value) {
		switch (name) {
			case 'text': if (value != this.element.dom.value) this.element.dom.value = value; break
			case 'color': this.style('color', value); break
			case 'width': this._updateSize(); break
			case 'height': this._updateSize(); break
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

		_globals.core.Item.prototype._update.apply(this, arguments);
	}

	/// returns tag for corresponding element
	function getTag() { return 'textarea' }

	constructor: {
		var self = this
		this.element.on("input", function() { self.text = this.element.dom.value }.bind(this))
	}

	function _updateSize() {
		var style = { width: this.width, height: this.height }
		this.style(style)
	}
}

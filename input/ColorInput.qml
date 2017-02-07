BaseInput {
	width: 80;
	height: 32;
	type: "color";

	function _update(name, value) {
		switch(name) {
			case 'color': 
				if (value != this.element.dom.value) 
					this.element.dom.value = value;
				break
		}

		_globals.controls.input.BaseInput.prototype._update.apply(this, arguments);
	}

	constructor: {
		this.element.on("input", function(e) { this.color = e.target.value; }.bind(this))
	}
}

InputBase {
	property string text;
	property bool passwordMode: false;
	height: 20;
	width: 173;
	type: passwordMode ? "password" : "text";

	function _update(name, value) {
		switch (name) {
			case 'text': if (value != this.element.dom.value) this.element.dom.value = value; break
		}

		qml.qb.InputBase.prototype._update.apply(this, arguments);
	}

	constructor: {
		var self = this
		this.element.on("input", function() { self.text = this.element.dom.value }.bind(this))
	}
}

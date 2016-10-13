InputBase {
	property string text;
	width: 100;
	height: 25;
	type: "search";

	function _update(name, value) {
		_globals.core.InputBase.prototype._update.apply(this, arguments);
	}

	constructor: {
		var self = this
		this.element.on("input", function() { self.text = this.element.dom.value }.bind(this))
	}
}

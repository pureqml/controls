InputBase {
	property Color value;
	width: 100;
	height: 25;
	type: "color";

	function _update(name, value) {
		qml.qb.InputBase.prototype._update.apply(this, arguments);
	}

	constructor: {
		var self = this
		this.element.on("input", function() { self.color = this.element.dom.value }.bind(this))
	}
}

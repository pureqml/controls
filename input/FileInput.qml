BaseInput {
	property string value;
	property string filter;
	width: 250;
	height: 30;
	type: "file";

	onFilterChanged: { this.element.dom.accept = value; }

	constructor: {
		var self = this
		this.element.on("change", function(e) { self.value = e.target.value }.bind(this))
	}
}

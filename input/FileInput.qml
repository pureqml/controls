///file selected input
BaseInput {
	property string value;		///< selected filename
	property string filter;		///< filter for file selecting
	width: 250;
	height: 30;
	type: "file";

	onFilterChanged: { this.element.setProperty('accept', value) }

	constructor: {
		var self = this
		this.element.on("change", function(e) { self.value = e.target.value }.bind(this))
	}
}

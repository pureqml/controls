/// HTML5 search input item
BaseInput {
	property string text;	///< input text string property
	width: 100;		///<@private
	height: 25;		///<@private
	type: "search";	///<@private

	onTextChanged: { if (value != this.element.dom.value) this.element.dom.value = value }

	constructor: {
		this.element.on("input", function() { this.text = this.element.dom.value }.bind(this))
	}
}

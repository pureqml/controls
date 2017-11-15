///HTML text input item
BaseInput {
	property string text;		///< input text string property
	property bool passwordMode: false;	///< show password chars instead of input text flag property
	height: 20;	///<@private
	width: 173;	///<@private
	type: passwordMode ? "password" : "text";	///<@private

	onTextChanged: { if (value != this.element.dom.value) this.element.dom.value = value; }

	constructor: {
		this.element.on("input", function() { this.text = this.element.dom.value }.bind(this))
	}
}

///HTML text input item
BaseInput {
	property string text;		///< input text string property
	property int maxLength;		///< max available length for the input text
	property bool passwordMode: false;	///< show password chars instead of input text flag property
	property Color cursorColor: "#fff";	///< cursor color
	height: 20;	///<@private
	width: 173;	///<@private
	type: passwordMode ? "password" : "text";	///<@private

	onTextChanged: { this._updateValue(value) }

	constructor: {
		this.element.on("input", function() {
			this.text = this._getValue()
		}.bind(this))
	}

	onMaxLengthChanged: { this.element.setAttribute('maxlength', value) }
	onCursorColorChanged: { this.style('caret-color', value) }
}
